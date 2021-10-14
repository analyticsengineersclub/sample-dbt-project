select
  date_trunc(sold_at, month) as date_month,
  sum(case when product_category = 'coffee beans' then amount end) as coffee_beans_amount,
  sum(case when product_category = 'merch' then amount end) as merch_amount,
  sum(case when product_category = 'brewing supplies' then amount end) as brewing_supplies_amount

from {{ ref('item_sales') }}
group by 1

-- this is a mistake
