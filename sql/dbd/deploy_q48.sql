

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_cdemo_sk ENCODING DELTAVAL, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING COMMONDELTA_COMP, 
 ss_sales_price ENCODING RLE, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_sold_date_sk, 
        ss_cdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sales_price,
          ss_cdemo_sk,
          ss_addr_sk
SEGMENTED BY MODULARHASH (ss_cdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_cdemo_sk ENCODING DELTAVAL, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING COMMONDELTA_COMP, 
 ss_sales_price ENCODING RLE, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_sold_date_sk, 
        ss_cdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sales_price,
          ss_cdemo_sk,
          ss_addr_sk
SEGMENTED BY MODULARHASH (ss_cdemo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');