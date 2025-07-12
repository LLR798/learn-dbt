with calc_employees as (
    select 
        -- poderia usar o || '' || para concatenar também
        first_name + ' ' + last_name as name,
        date_part(year, current_date) - date_part(year, birth_date) as age,
        date_part(year, current_date) - date_part(year, hire_date) as lengthofservice,
        *

    from {{source('sources', 'employees')}}
)
select * from calc_employees