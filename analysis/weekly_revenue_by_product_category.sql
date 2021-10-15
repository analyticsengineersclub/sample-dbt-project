select
    date_trunc(sold_at, week) as date_week,
    product_category,
    sum(amount) as revenue

from {{ ref('item_sales') }}

group by 1, 2
order by 1, 2
