with markup as (
    select *,
    first_value(customer_id)
    over(partition by company_name, contact_name order by company_name
    rows between unbounded preceding and unbounded following) as result
    from {{source('sources_redshift', 'customers')}}
)

, removed as (
    select distinct result
    from markup
    order by 1
)

, final as (
    select *
    from {{source('sources_redshift', 'customers')}}
    where customer_id in (select result from removed)


)

select *
from final