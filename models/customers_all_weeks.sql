with all_weeks as (
    select * from {{ ref('all_weeks') }}
),

orders as (
    select * from {{ ref('orders') }}
),

customer_weekly_orders as (
    select
        customer_id,
        cast(date_trunc(sold_at, week) as datetime) as date_week,
        sum(total) as total_revenue
    from orders
    group by 1, 2
),

-- find the first week so we can only look at weeks onwards for each
customer_first_week as (
    select
        customer_id,
        cast(min(date_week) as datetime) as first_date_week
    from customer_weekly_orders
    group by 1
),

spined as (
    select
        customer_first_week.customer_id,
        all_weeks.date_week,
        date_diff(all_weeks.date_week, first_date_week, week) as week_number,
    from all_weeks

    inner join customer_first_week
        on all_weeks.date_week >= customer_first_week.first_date_week
),

joined as (
    select
        spined.customer_id,
        spined.week_number,
        spined.date_week,
        coalesce(customer_weekly_orders.total_revenue, 0) as weekly_revenue,
        sum(coalesce(customer_weekly_orders.total_revenue, 0)) over (
            partition by spined.customer_id
            order by spined.week_number
            rows between unbounded preceding and current row
        ) as cumulative_revenue
    from spined
    left join customer_weekly_orders
        on spined.customer_id = customer_weekly_orders.customer_id
        and spined.date_week = customer_weekly_orders.date_week
)

select * from joined
