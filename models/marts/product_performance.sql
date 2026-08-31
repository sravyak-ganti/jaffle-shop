with order_items as (
    select *
    from {{ ref('order_items') }}
),

product_summary as (
    select
        product_id,
        product_name,
        count(distinct order_id) as total_orders,
        count(order_item_id) as total_units_sold,
        sum(coalesce(product_price, 0)) as total_sales,
        sum(coalesce(supply_cost, 0)) as total_supply_cost,
        sum({{ gross_margin('product_price', 'supply_cost') }}) as gross_margin,
        case
            when is_food_item then 'Food'
            when is_drink_item then 'Drink'
            else 'Other'
        end as product_category
    from order_items
    group by
        product_id,
        product_name,
        is_food_item,
        is_drink_item
)

select *
from product_summary