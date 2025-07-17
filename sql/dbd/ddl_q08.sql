
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_zip ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_zip
 FROM tpcds.customer_address 
 ORDER BY ca_zip,
          ca_address_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_qoy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_qoy
 FROM tpcds.date_dim 
 ORDER BY d_qoy,
          d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC_v1_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC_v1_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_store_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_address_DBD_5_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 ca_address_sk ENCODING DELTAVAL,
 ca_address_id ENCODING ZSTD_FAST_COMP,
 ca_street_number ENCODING ZSTD_FAST_COMP,
 ca_street_name ENCODING ZSTD_FAST_COMP,
 ca_street_type ENCODING RLE,
 ca_suite_number ENCODING ZSTD_FAST_COMP,
 ca_city ENCODING ZSTD_FAST_COMP,
 ca_county ENCODING ZSTD_FAST_COMP,
 ca_state ENCODING RLE,
 ca_zip ENCODING ZSTD_FAST_COMP,
 ca_country ENCODING RLE,
 ca_gmt_offset ENCODING RLE,
 ca_location_type ENCODING RLE
)
AS
 SELECT customer_address.ca_address_sk,
        customer_address.ca_address_id,
        customer_address.ca_street_number,
        customer_address.ca_street_name,
        customer_address.ca_street_type,
        customer_address.ca_suite_number,
        customer_address.ca_city,
        customer_address.ca_county,
        customer_address.ca_state,
        customer_address.ca_zip,
        customer_address.ca_country,
        customer_address.ca_gmt_offset,
        customer_address.ca_location_type
 FROM tpcds.customer_address
 ORDER BY customer_address.ca_country,
          customer_address.ca_location_type,
          customer_address.ca_gmt_offset,
          customer_address.ca_street_type,
          customer_address.ca_state,
          customer_address.ca_address_id
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_DBD_7_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 c_customer_sk ENCODING DELTARANGE_COMP,
 c_customer_id ENCODING ZSTD_FAST_COMP,
 c_current_cdemo_sk ENCODING DELTAVAL,
 c_current_hdemo_sk ENCODING DELTAVAL,
 c_current_addr_sk ENCODING DELTAVAL,
 c_first_shipto_date_sk ENCODING DELTAVAL,
 c_first_sales_date_sk ENCODING DELTAVAL,
 c_salutation ENCODING RLE,
 c_first_name ENCODING ZSTD_FAST_COMP,
 c_last_name ENCODING ZSTD_FAST_COMP,
 c_preferred_cust_flag ENCODING RLE,
 c_birth_day ENCODING RLE,
 c_birth_month ENCODING RLE,
 c_birth_year ENCODING BLOCKDICT_COMP,
 c_birth_country ENCODING ZSTD_FAST_COMP,
 c_login ENCODING RLE,
 c_email_address ENCODING ZSTD_FAST_COMP,
 c_last_review_date ENCODING ZSTD_FAST_COMP
)
AS
 SELECT customer.c_customer_sk,
        customer.c_customer_id,
        customer.c_current_cdemo_sk,
        customer.c_current_hdemo_sk,
        customer.c_current_addr_sk,
        customer.c_first_shipto_date_sk,
        customer.c_first_sales_date_sk,
        customer.c_salutation,
        customer.c_first_name,
        customer.c_last_name,
        customer.c_preferred_cust_flag,
        customer.c_birth_day,
        customer.c_birth_month,
        customer.c_birth_year,
        customer.c_birth_country,
        customer.c_login,
        customer.c_email_address,
        customer.c_last_review_date
 FROM tpcds.customer
 ORDER BY customer.c_login,
          customer.c_preferred_cust_flag,
          customer.c_salutation,
          customer.c_birth_month,
          customer.c_birth_day,
          customer.c_customer_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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


select mark_design_ksafe(1);

