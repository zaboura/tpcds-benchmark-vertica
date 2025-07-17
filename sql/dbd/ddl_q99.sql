
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cs_sold_date_sk ENCODING COMMONDELTA_COMP, 
 cs_ship_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ship_mode_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_date_sk, 
        cs_call_center_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_ship_mode_sk,
          cs_warehouse_sk,
          cs_sold_date_sk
SEGMENTED BY MODULARHASH (cs_ship_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cs_sold_date_sk ENCODING COMMONDELTA_COMP, 
 cs_ship_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ship_mode_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_date_sk, 
        cs_call_center_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_ship_mode_sk,
          cs_warehouse_sk,
          cs_sold_date_sk
SEGMENTED BY MODULARHASH (cs_ship_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.call_center_DBD_1_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 cc_call_center_sk,
 cc_call_center_id ENCODING ZSTD_FAST_COMP,
 cc_rec_start_date ENCODING COMMONDELTA_COMP,
 cc_rec_end_date ENCODING BLOCKDICT_COMP,
 cc_closed_date_sk ENCODING RLE,
 cc_open_date_sk,
 cc_name ENCODING ZSTD_FAST_COMP,
 cc_class ENCODING RLE,
 cc_employees,
 cc_sq_ft,
 cc_hours ENCODING ZSTD_FAST_COMP,
 cc_manager ENCODING ZSTD_FAST_COMP,
 cc_mkt_id,
 cc_mkt_class ENCODING ZSTD_FAST_COMP,
 cc_mkt_desc ENCODING ZSTD_FAST_COMP,
 cc_market_manager ENCODING ZSTD_FAST_COMP,
 cc_division,
 cc_division_name,
 cc_company,
 cc_company_name,
 cc_street_number ENCODING ZSTD_FAST_COMP,
 cc_street_name ENCODING ZSTD_FAST_COMP,
 cc_street_type,
 cc_suite_number,
 cc_city ENCODING ZSTD_FAST_COMP,
 cc_county ENCODING ZSTD_FAST_COMP,
 cc_state ENCODING ZSTD_FAST_COMP,
 cc_zip ENCODING ZSTD_FAST_COMP,
 cc_country ENCODING RLE,
 cc_gmt_offset ENCODING RLE,
 cc_tax_percentage
)
AS
 SELECT call_center.cc_call_center_sk,
        call_center.cc_call_center_id,
        call_center.cc_rec_start_date,
        call_center.cc_rec_end_date,
        call_center.cc_closed_date_sk,
        call_center.cc_open_date_sk,
        call_center.cc_name,
        call_center.cc_class,
        call_center.cc_employees,
        call_center.cc_sq_ft,
        call_center.cc_hours,
        call_center.cc_manager,
        call_center.cc_mkt_id,
        call_center.cc_mkt_class,
        call_center.cc_mkt_desc,
        call_center.cc_market_manager,
        call_center.cc_division,
        call_center.cc_division_name,
        call_center.cc_company,
        call_center.cc_company_name,
        call_center.cc_street_number,
        call_center.cc_street_name,
        call_center.cc_street_type,
        call_center.cc_suite_number,
        call_center.cc_city,
        call_center.cc_county,
        call_center.cc_state,
        call_center.cc_zip,
        call_center.cc_country,
        call_center.cc_gmt_offset,
        call_center.cc_tax_percentage
 FROM tpcds.call_center
 ORDER BY call_center.cc_closed_date_sk,
          call_center.cc_country,
          call_center.cc_class,
          call_center.cc_gmt_offset,
          call_center.cc_call_center_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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

