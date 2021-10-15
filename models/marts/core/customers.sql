{{ config(
    materialized='table'
) }}

with customers as (
    select * from {{ ref('stg_coffee_shop__customers') }}
),

orders as (
    select * from {{ ref('stg_coffee_shop__orders') }}
),

customer_orders as (
    select
        customer_id,
        count(*) as number_of_orders,
        min(created_at) as first_order_at
    from orders
    group by 1
)

select
    customers.customer_id,
    customers.name,
    customers.email,
    customer_orders.first_order_at,
    customer_orders.number_of_orders

from customers
left join customer_orders
    using (customer_id)
