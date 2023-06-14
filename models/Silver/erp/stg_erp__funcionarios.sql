with
    fonte_funcionarios as (
        select *
        from {{ source('erp', 'employees') }}
    )

    , renomear as (
        select
            cast(employee_id as int)     as id_funcionario,
            cast((first_name || ' ' || last_name) as string) as funcionario_nome,
            cast(birth_date	 as string)  as func_data_nascimento,		
            cast(hire_date	 as date)    as func_data_contratacao, 		
            cast(address	 as string)  as func_endereco,	
            cast(city		 as string)  as func_cidade,
            cast(region		 as string)  as func_regiao,
            cast(postal_code as string)  as func_cep,		
            cast(country	 as string)  as func_pais,										
            cast(notes		 as string)  as func_notas,
            cast(reports_to  as int)     as id_gerente
        
        from fonte_funcionarios
    )
select *
from renomear