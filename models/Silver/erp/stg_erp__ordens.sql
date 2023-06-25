with
    fonte_ordens as (
        select
            cast(order_id as int) id_pedido
            , cast(employee_id as int) as id_funcionario
            , cast(customer_id as string) as id_cliente
            , cast(ship_via as int) as id_transportadora
            , cast(order_date as date) as data_do_pedido
            , cast(freight as numeric) as frete
            , cast(ship_name as string) as destinatario
            , cast(ship_address as string) as endereco_destinatario
            , cast(ship_postal_code as string) as cep_destinatario
            , cast(ship_city as string) as cidade_destinatario
            , cast(ship_region as string) as regiao_destinatario
            , cast(ship_country as string) as pais_destinatario
            , cast(shipped_date as date) as data_do_envio
            , cast(required_date as date) as data_requerida_entrega
        from {{ source('erp', 'orders') }}
    )
select *
from fonte_ordens