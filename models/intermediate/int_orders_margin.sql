with sales_margin as (
    select *
    from {{ ref('int_sales_margin') }}
),

orders as (
    select
        orders_id,
        -- her siparişin tarihi aslında tekil, o yüzden MIN/MAX fark etmez
        min(date_date) as date_date,
        sum(revenue) as revenue,
        sum(quantity) as quantity,
        sum(purchase_cost) as purchase_cost,
        sum(margin) as margin
    from sales_margin
    group by orders_id
)

select * from orders