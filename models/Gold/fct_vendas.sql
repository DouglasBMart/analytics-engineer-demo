with
    clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )
    , funcionarios as (
        select *
        from {{ ref('dim_funcionarios') }}
    )
    , produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )
    , pedido_item as (
        select *
        from {{ ref('int_vendas__pedido_itens') }}
    )

    , joined_tabelas as (
        select
            pedido_item.id_pedido
            , clientes.sk_cliente as fk_cliente
            , funcionarios.sk_funcionario as fk_funcionario
            , produtos.id_produto as fk_produtos
            , pedido_item.id_transportadora
            , pedido_item.id_produto
            , pedido_item.desconto_perc
            , pedido_item.preco_da_unidade
            , pedido_item.quantidade
            , pedido_item.data_do_pedido
            , pedido_item.frete
            , pedido_item.destinatario
            , pedido_item.endereco_destinatario
            , pedido_item.cep_destinatario
            , pedido_item.cidade_destinatario
            , pedido_item.regiao_destinatario
            , pedido_item.pais_destinatario
            , pedido_item.data_do_envio
            , pedido_item.data_requerida_entrega
            , clientes.nome_cliente
            , funcionarios.funcionario
            , funcionarios.gerente
            , produtos.nome_produto
            , produtos.nome_categoria
            , produtos.nome_fornecedor
            , produtos.is_discontinuado

        from pedido_item
        left join clientes on pedido_item.id_cliente = clientes.id_cliente
        left join funcionarios on pedido_item.id_funcionario = funcionarios.id_funcionario
        left join produtos on pedido_item.id_produto = produtos.id_produto

    )
    , transformacoes as (
        select 
            {{ dbt_utils.generate_surrogate_key(['id_pedido','fk_produtos']) }} as sk_venda
            ,*
            , preco_da_unidade * quantidade as total_bruto
            , (1- desconto_perc) * preco_da_unidade *quantidade as total_liquido
            , case
                when desconto_perc > 0 then true
                when desconto_perc = 0 then false
                else false
                end as is_desconto
        from joined_tabelas

    )
select *
from transformacoes