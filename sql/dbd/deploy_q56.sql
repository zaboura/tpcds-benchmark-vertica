

CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_gmt_offset ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_gmt_offset
 FROM tpcds.customer_address 
 ORDER BY ca_gmt_offset,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');