
select *
from {{ref('joins')}}
where extract(year from order_date) = 2020