

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_customer_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_customer_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_sold_date_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_customer_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_customer_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_sold_date_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');