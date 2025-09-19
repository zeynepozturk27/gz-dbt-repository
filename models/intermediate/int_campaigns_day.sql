with daily as (

    select
        date_date as date,
        sum(ads_cost) as ads_cost,
        sum(impression) as ads_impression,
        sum(click) as ads_clicks
    from {{ ref('int_campaigns') }}
    group by date_date

)

select *
from daily
order by date desc