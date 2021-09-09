with orders as (
    select * from {{ ref('stg_coffee_shop__orders') }}
),

final as (
    select
        order_id,
        customer_id,

        row_number() over (
            partition by customer_id
            order by created_at
        ) = 1 as is_first_order,

        total,

        created_at as sold_at

    from orders

)

select * from final
