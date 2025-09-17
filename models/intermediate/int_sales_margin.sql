with sales as (
    select
        orders_id,
        -- kaynakta pdt_id var; burada products_id'ye çeviriyoruz
        pdt_id as products_id,
        date_date,
        quantity,
        revenue
    from {{ ref('stg_raw__sales') }}
),

product as (
    select
        products_id,
        purchase_price
    from {{ ref('stg_raw__product') }}
),

joined as (
    select
        s.orders_id,
        s.products_id,
        s.date_date,
        s.quantity,
        s.revenue,
        p.purchase_price,
        s.quantity * p.purchase_price as purchase_cost,
        s.revenue - (s.quantity * p.purchase_price) as margin
    from sales s
    left join product p
        on s.products_id = p.products_id
)

select * from joined