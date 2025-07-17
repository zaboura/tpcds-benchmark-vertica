

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_customer_sk ENCODING RLE, 
 cs_bill_cdemo_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING DELTAVAL, 
 cs_list_price ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL, 
 cs_coupon_amt ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_bill_cdemo_sk, 
        cs_quantity, 
        cs_list_price, 
        cs_sales_price, 
        cs_coupon_amt, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_customer_sk,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_customer_sk ENCODING RLE, 
 cs_bill_cdemo_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING DELTAVAL, 
 cs_list_price ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL, 
 cs_coupon_amt ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_bill_cdemo_sk, 
        cs_quantity, 
        cs_list_price, 
        cs_sales_price, 
        cs_coupon_amt, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_customer_sk,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION customer_address_DBD_2_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_county ENCODING ZSTD_FAST_COMP, 
 ca_state ENCODING RLE, 
 ca_country ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_county, 
        ca_state, 
        ca_country
 FROM tpcds.customer_address 
 ORDER BY ca_state,
          ca_country,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_education_status ENCODING RLE, 
 cd_dep_count ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_education_status, 
        cd_dep_count
 FROM tpcds.customer_demographics 
 ORDER BY cd_gender,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_education_status ENCODING RLE, 
 cd_dep_count ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_education_status, 
        cd_dep_count
 FROM tpcds.customer_demographics 
 ORDER BY cd_gender,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_demographics');

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 c_customer_sk ENCODING DELTARANGE_COMP, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING DELTAVAL, 
 c_birth_month ENCODING RLE, 
 c_birth_year ENCODING RLE
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_addr_sk, 
        c_birth_month, 
        c_birth_year
 FROM tpcds.customer 
 ORDER BY c_birth_month,
          c_birth_year,
          c_customer_sk
SEGMENTED BY MODULARHASH (c_current_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 c_customer_sk ENCODING DELTARANGE_COMP, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING DELTAVAL, 
 c_birth_month ENCODING RLE, 
 c_birth_year ENCODING RLE
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_addr_sk, 
        c_birth_month, 
        c_birth_year
 FROM tpcds.customer 
 ORDER BY c_birth_month,
          c_birth_year,
          c_customer_sk
SEGMENTED BY MODULARHASH (c_current_addr_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer');