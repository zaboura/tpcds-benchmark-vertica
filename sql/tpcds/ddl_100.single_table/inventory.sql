create table {SCHEMA}.inventory
(
    inv_item_sk               integer               not null,
    inv_date_sk               integer               not null,
    inv_warehouse_sk          integer               not null,
    inv_quantity_on_hand      integer
);