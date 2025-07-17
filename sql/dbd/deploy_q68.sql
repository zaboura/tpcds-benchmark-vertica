

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2),createtype(D)*/
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

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2),createtype(D)*/
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

select refresh('tpcds.store_sales');