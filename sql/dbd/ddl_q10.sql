
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_ship_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_customer_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_ship_customer_sk
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_ship_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_customer_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_ship_customer_sk
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_address_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_county ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_county
 FROM tpcds.customer_address 
 ORDER BY ca_county,
          ca_address_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_cdemo_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_current_cdemo_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.date_dim_DBD_4_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_moy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_moy
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_sales_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_bill_customer_sk
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_bill_customer_sk
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_demographics_DBD_6_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 cd_demo_sk ENCODING COMMONDELTA_COMP,
 cd_gender ENCODING RLE,
 cd_marital_status ENCODING RLE,
 cd_education_status ENCODING RLE,
 cd_purchase_estimate ENCODING COMMONDELTA_COMP,
 cd_credit_rating ENCODING RLE,
 cd_dep_count ENCODING RLE,
 cd_dep_employed_count ENCODING RLE,
 cd_dep_college_count ENCODING RLE
)
AS
 SELECT customer_demographics.cd_demo_sk,
        customer_demographics.cd_gender,
        customer_demographics.cd_marital_status,
        customer_demographics.cd_education_status,
        customer_demographics.cd_purchase_estimate,
        customer_demographics.cd_credit_rating,
        customer_demographics.cd_dep_count,
        customer_demographics.cd_dep_employed_count,
        customer_demographics.cd_dep_college_count
 FROM tpcds.customer_demographics
 ORDER BY customer_demographics.cd_gender,
          customer_demographics.cd_credit_rating,
          customer_demographics.cd_marital_status,
          customer_demographics.cd_education_status,
          customer_demographics.cd_dep_count,
          customer_demographics.cd_dep_employed_count,
          customer_demographics.cd_dep_college_count,
          customer_demographics.cd_demo_sk
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

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING RLE
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_customer_sk
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_customer_sk,
          store_sales.ss_item_sk,
          store_sales.ss_sold_date_sk
SEGMENTED BY hash(store_sales.ss_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING RLE
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_customer_sk
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_customer_sk,
          store_sales.ss_item_sk,
          store_sales.ss_sold_date_sk
SEGMENTED BY hash(store_sales.ss_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

