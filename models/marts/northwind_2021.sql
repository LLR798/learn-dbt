select *
from {{ ref('northwind_denormalized') }}
where date_part(year, order_date) = 2021