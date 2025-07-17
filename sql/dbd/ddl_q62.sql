
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.web_sales_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_sold_date_sk ENCODING COMMONDELTA_COMP, 
 ws_ship_date_sk ENCODING COMMONDELTA_COMP, 
 ws_web_site_sk ENCODING RLE, 
 ws_ship_mode_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE
)
AS
 SELECT ws_sold_date_sk, 
        ws_ship_date_sk, 
        ws_web_site_sk, 
        ws_ship_mode_sk, 
        ws_warehouse_sk
 FROM tpcds.web_sales 
 ORDER BY ws_web_site_sk,
          ws_ship_mode_sk,
          ws_warehouse_sk,
          ws_sold_date_sk,
          ws_ship_date_sk
SEGMENTED BY MODULARHASH (ws_ship_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_sold_date_sk ENCODING COMMONDELTA_COMP, 
 ws_ship_date_sk ENCODING COMMONDELTA_COMP, 
 ws_web_site_sk ENCODING RLE, 
 ws_ship_mode_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE
)
AS
 SELECT ws_sold_date_sk, 
        ws_ship_date_sk, 
        ws_web_site_sk, 
        ws_ship_mode_sk, 
        ws_warehouse_sk
 FROM tpcds.web_sales 
 ORDER BY ws_web_site_sk,
          ws_ship_mode_sk,
          ws_warehouse_sk,
          ws_sold_date_sk,
          ws_ship_date_sk
SEGMENTED BY MODULARHASH (ws_ship_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_site_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 web_site_sk ENCODING COMMONDELTA_COMP, 
 web_name ENCODING AUTO
)
AS
 SELECT web_site_sk, 
        web_name
 FROM tpcds.web_site 
 ORDER BY web_site_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.ship_mode_DBD_15_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 sm_ship_mode_sk,
 sm_ship_mode_id ENCODING ZSTD_FAST_COMP,
 sm_type,
 sm_code ENCODING ZSTD_FAST_COMP,
 sm_carrier ENCODING ZSTD_FAST_COMP,
 sm_contract ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ship_mode.sm_ship_mode_sk,
        ship_mode.sm_ship_mode_id,
        ship_mode.sm_type,
        ship_mode.sm_code,
        ship_mode.sm_carrier,
        ship_mode.sm_contract
 FROM tpcds.ship_mode
 ORDER BY ship_mode.sm_contract
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq
 FROM tpcds.date_dim
 ORDER BY date_dim.d_month_seq,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

