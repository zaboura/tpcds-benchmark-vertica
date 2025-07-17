
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_zip ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ca_address_sk, 
        ca_zip
 FROM tpcds.customer_address 
 ORDER BY ca_address_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_current_addr_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.item_DBD_3_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTAVAL, 
 i_brand_id ENCODING ZSTD_FAST_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_manufact_id ENCODING DELTAVAL, 
 i_manufact ENCODING ZSTD_FAST_COMP, 
 i_manager_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand_id, 
        i_brand, 
        i_manufact_id, 
        i_manufact, 
        i_manager_id
 FROM tpcds.item 
 ORDER BY i_manager_id,
          i_brand,
          i_brand_id,
          i_manufact_id,
          i_manufact
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_customer_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_customer_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_DBD_18_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 s_store_sk ENCODING COMMONDELTA_COMP,
 s_store_id ENCODING ZSTD_FAST_COMP,
 s_rec_start_date ENCODING ZSTD_FAST_COMP,
 s_rec_end_date ENCODING ZSTD_FAST_COMP,
 s_closed_date_sk ENCODING ZSTD_FAST_COMP,
 s_store_name ENCODING ZSTD_FAST_COMP,
 s_number_employees ENCODING DELTAVAL,
 s_floor_space ENCODING ZSTD_FAST_COMP,
 s_hours ENCODING ZSTD_FAST_COMP,
 s_manager ENCODING ZSTD_FAST_COMP,
 s_market_id ENCODING DELTAVAL,
 s_geography_class ENCODING RLE,
 s_market_desc ENCODING ZSTD_FAST_COMP,
 s_market_manager ENCODING ZSTD_FAST_COMP,
 s_division_id ENCODING RLE,
 s_division_name ENCODING RLE,
 s_company_id ENCODING RLE,
 s_company_name ENCODING RLE,
 s_street_number ENCODING ZSTD_FAST_COMP,
 s_street_name ENCODING ZSTD_FAST_COMP,
 s_street_type ENCODING ZSTD_FAST_COMP,
 s_suite_number ENCODING ZSTD_FAST_COMP,
 s_city ENCODING ZSTD_FAST_COMP,
 s_county ENCODING ZSTD_FAST_COMP,
 s_state ENCODING ZSTD_FAST_COMP,
 s_zip ENCODING ZSTD_FAST_COMP,
 s_country ENCODING RLE,
 s_gmt_offset ENCODING BLOCKDICT_COMP,
 s_tax_precentage ENCODING DELTAVAL
)
AS
 SELECT store.s_store_sk,
        store.s_store_id,
        store.s_rec_start_date,
        store.s_rec_end_date,
        store.s_closed_date_sk,
        store.s_store_name,
        store.s_number_employees,
        store.s_floor_space,
        store.s_hours,
        store.s_manager,
        store.s_market_id,
        store.s_geography_class,
        store.s_market_desc,
        store.s_market_manager,
        store.s_division_id,
        store.s_division_name,
        store.s_company_id,
        store.s_company_name,
        store.s_street_number,
        store.s_street_name,
        store.s_street_type,
        store.s_suite_number,
        store.s_city,
        store.s_county,
        store.s_state,
        store.s_zip,
        store.s_country,
        store.s_gmt_offset,
        store.s_tax_precentage
 FROM tpcds.store
 ORDER BY store.s_geography_class,
          store.s_division_id,
          store.s_division_name,
          store.s_company_id,
          store.s_company_name,
          store.s_country,
          store.s_store_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_moy,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

