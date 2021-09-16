with generated as (
{{ dbt_utils.date_spine(
    datepart="week",
    start_date="cast('2021-01-03' as date)",
    end_date="cast('2021-10-01' as date)"
) }}
)

select
    cast(date_week as timestamp) as date_week
from generated
