select 
    count(*) as counter,
    company_name, contact_name

from {{ref('customers')}}

group by company_name, contact_name

having counter > 1