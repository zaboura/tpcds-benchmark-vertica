

CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
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

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
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

select refresh('tpcds.customer');

CREATE PROJECTION item_DBD_3_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
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

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/
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

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/
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

select refresh('tpcds.store_sales');