

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_ext_sales_price,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_ext_sales_price,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');