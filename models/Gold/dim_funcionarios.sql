with 
    funcionarios as (
        select
            id_funcionario,
            id_gerente,
            funcionario,
            func_data_nascimento,		
            func_data_contratacao, 		
            func_endereco,	
            func_cidade,
            func_regiao,
            func_cep,		
            func_pais,								
            func_notas

        from {{ ref('stg_erp__funcionarios') }}
    )

    ,self_join_gerentes as (
        select
            funcionarios.id_funcionario,
            funcionarios.id_gerente,
            funcionarios.funcionario,
            gerentes.funcionario as gerente,
            funcionarios.func_data_nascimento,		
            funcionarios.func_data_contratacao, 		
            funcionarios.func_endereco,	
            funcionarios.func_cidade,
            funcionarios.func_regiao,
            funcionarios.func_cep,		
            funcionarios.func_pais,								
            funcionarios.func_notas      
        from funcionarios
        left join funcionarios as gerentes on 
            funcionarios.id_gerente = gerentes.id_funcionario
    )

    , transformacoes as (
        select
            row_number()over(order by id_funcionario) as sk_funcionario
            ,*
        from self_join_gerentes
    )

select *
from transformacoes