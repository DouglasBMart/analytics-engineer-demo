with
    pedidos as (
        select *
        from {{ ref('stg_erp__ordens') }}
    )

    , pedido_itens as (
        select *
        from {{ ref('stg_erp__ordem_detalhes') }}
    )

    , joined_pedido_itens as (
        select
             pedidos.id_pedido
            , pedidos.id_funcionario
            , pedidos.id_cliente
            , pedidos.id_transportadora
            , pedido_itens.id_produto
            , pedido_itens.desconto_perc
            , pedido_itens.preco_da_unidade
            , pedido_itens.quantidade
            , pedidos.data_do_pedido
            , pedidos.frete
            , pedidos.destinatario
            , pedidos.endereco_destinatario
            , pedidos.cep_destinatario
            , pedidos.cidade_destinatario
            , pedidos.regiao_destinatario
            , pedidos.pais_destinatario
            , pedidos.data_do_envio
            , pedidos.data_requerida_entrega
        from pedido_itens
            left join pedidos on
            pedido_itens.id_pedido = pedidos.id_pedido
    )

select * 
from joined_pedido_itens