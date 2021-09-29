select
*
from {{ source('coffee_shop', 'customers') }}
where not regexp_contains(email, r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}")
