
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL, 
 ss_ext_list_price ENCODING DELTAVAL, 
 ss_ext_tax ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_ext_list_price, 
        ss_ext_tax
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL, 
 ss_ext_list_price ENCODING DELTAVAL, 
 ss_ext_tax ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_ext_list_price, 
        ss_ext_tax
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 1;

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

CREATE PROJECTION tpcds.household_demographics_DBD_9_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 hd_demo_sk ENCODING COMMONDELTA_COMP,
 hd_income_band_sk ENCODING COMMONDELTA_COMP,
 hd_buy_potential ENCODING RLE,
 hd_dep_count ENCODING RLE,
 hd_vehicle_count ENCODING RLE
)
AS
 SELECT household_demographics.hd_demo_sk,
        household_demographics.hd_income_band_sk,
        household_demographics.hd_buy_potential,
        household_demographics.hd_dep_count,
        household_demographics.hd_vehicle_count
 FROM tpcds.household_demographics
 ORDER BY household_demographics.hd_buy_potential,
          household_demographics.hd_vehicle_count,
          household_demographics.hd_dep_count,
          household_demographics.hd_demo_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_dom ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_dom
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_dom,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 ca_address_sk ENCODING COMMONDELTA_COMP,
 ca_city ENCODING ZSTD_FAST_COMP
)
AS
 SELECT customer_address.ca_address_sk,
        customer_address.ca_city
 FROM tpcds.customer_address
 ORDER BY customer_address.ca_address_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 c_customer_sk ENCODING DELTAVAL,
 c_current_addr_sk ENCODING COMMONDELTA_COMP,
 c_first_name ENCODING ZSTD_FAST_COMP,
 c_last_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT customer.c_customer_sk,
        customer.c_current_addr_sk,
        customer.c_first_name,
        customer.c_last_name
 FROM tpcds.customer
 ORDER BY customer.c_current_addr_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_DBD_5_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 s_store_sk,
 s_city ENCODING RLE
)
AS
 SELECT store.s_store_sk,
        store.s_city
 FROM tpcds.store
 ORDER BY store.s_city,
          store.s_store_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

