select
    date_trunc(first_order_at, month) as signup_month,
    product_category,
    sum(amount) as revenue

from {{ ref('item_sales') }}
