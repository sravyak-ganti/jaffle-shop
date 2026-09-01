--gross_margin calculation
{% macro gross_margin(revenue_column, cost_column) %}
    coalesce({{ revenue_column }}, 0) - coalesce({{ cost_column }}, 0)
{% endmacro %}