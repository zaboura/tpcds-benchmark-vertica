
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_refunded_cash
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_refunded_cash
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_warehouse_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_warehouse_sk,
          cs_item_sk,
          cs_order_number
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_warehouse_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_warehouse_sk,
          cs_item_sk,
          cs_order_number
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.warehouse_DBD_20_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 w_warehouse_sk,
 w_warehouse_id,
 w_warehouse_name ENCODING ZSTD_FAST_COMP,
 w_warehouse_sq_ft,
 w_street_number ENCODING ZSTD_FAST_COMP,
 w_street_name ENCODING ZSTD_FAST_COMP,
 w_street_type,
 w_suite_number,
 w_city ENCODING ZSTD_FAST_COMP,
 w_county ENCODING ZSTD_FAST_COMP,
 w_state,
 w_zip ENCODING ZSTD_FAST_COMP,
 w_country ENCODING RLE,
 w_gmt_offset ENCODING BLOCKDICT_COMP
)
AS
 SELECT warehouse.w_warehouse_sk,
        warehouse.w_warehouse_id,
        warehouse.w_warehouse_name,
        warehouse.w_warehouse_sq_ft,
        warehouse.w_street_number,
        warehouse.w_street_name,
        warehouse.w_street_type,
        warehouse.w_suite_number,
        warehouse.w_city,
        warehouse.w_county,
        warehouse.w_state,
        warehouse.w_zip,
        warehouse.w_country,
        warehouse.w_gmt_offset
 FROM tpcds.warehouse
 ORDER BY warehouse.w_country,
          warehouse.w_zip
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date_sk
SEGMENTED BY hash(date_dim.d_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date_sk
SEGMENTED BY hash(date_dim.d_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC1_v1 /*+createtype(D)*/ 
(
 i_item_sk ENCODING DELTAVAL,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING RLE,
 i_manufact_id ENCODING DELTAVAL
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_item_desc,
        item.i_current_price,
        item.i_manufact_id
 FROM tpcds.item
 ORDER BY item.i_current_price,
          item.i_item_id,
          item.i_item_desc
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

