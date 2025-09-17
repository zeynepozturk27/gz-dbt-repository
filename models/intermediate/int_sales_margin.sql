with sales as (
    select
        orders_id,
        pdt_id as products_id,   -- stg_raw__sales’ten geliyor
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
        -- satın alma maliyeti burada hesaplanıyor
        s.quantity * p.purchase_price as purchase_cost,
        -- marj = gelir - maliyet
        s.revenue - (s.quantity * p.purchase_price) as margin
    from sales s
    left join product p
        on s.products_id = p.products_id
)

select * from joined