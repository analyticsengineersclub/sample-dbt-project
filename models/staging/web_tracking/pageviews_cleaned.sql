with pageviews as (
    select * from {{ source('web_tracking', 'pageviews') }}
),

visitors as (
    select * from {{ ref('visitors') }}
),

joined as (
    select
        pageviews.*,
        -- customer id if we have it, else vistor id
        coalesce(
            visitors.first_customer_id,
            pageviews.visitor_id
        ) as blended_user_id,

        visitors.first_visitor_id

    from pageviews
    left join visitors
        on pageviews.visitor_id = visitors.visitor_id
)

select * from joined
