
select
  o.orders_id,
  o.date_date,
  -- null güvenliği ve 2 ondalık
  round(
    o.margin
    + coalesce(s.shipping_fee, 0)
    - (coalesce(s.log_cost, 0) + coalesce(s.ship_cost, 0))
  , 2) as operational_margin,
  o.quantity,
  o.revenue,
  o.purchase_cost,
  o.margin,
  s.shipping_fee,
  s.log_cost,
  s.ship_cost
from {{ ref("int_orders_margin") }} o
left join {{ ref("stg_raw__ship") }} s
  using (orders_id)