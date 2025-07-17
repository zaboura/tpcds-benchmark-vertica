
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_cdemo_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING COMMONDELTA_COMP, 
 ss_sales_price ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL, 
 ss_ext_wholesale_cost ENCODING DELTAVAL, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_sold_date_sk, 
        ss_cdemo_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price, 
        ss_ext_sales_price, 
        ss_ext_wholesale_cost, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_hdemo_sk,
          ss_cdemo_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_cdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_cdemo_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING COMMONDELTA_COMP, 
 ss_sales_price ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL, 
 ss_ext_wholesale_cost ENCODING DELTAVAL, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_sold_date_sk, 
        ss_cdemo_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price, 
        ss_ext_sales_price, 
        ss_ext_wholesale_cost, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_hdemo_sk,
          ss_cdemo_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_cdemo_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 1;

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

CREATE PROJECTION tpcds.customer_demographics_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 cd_demo_sk ENCODING COMMONDELTA_COMP,
 cd_gender ENCODING RLE,
 cd_marital_status ENCODING RLE,
 cd_education_status ENCODING RLE
)
AS
 SELECT customer_demographics.cd_demo_sk,
        customer_demographics.cd_gender,
        customer_demographics.cd_marital_status,
        customer_demographics.cd_education_status
 FROM tpcds.customer_demographics
 ORDER BY customer_demographics.cd_education_status,
          customer_demographics.cd_gender,
          customer_demographics.cd_marital_status,
          customer_demographics.cd_demo_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

