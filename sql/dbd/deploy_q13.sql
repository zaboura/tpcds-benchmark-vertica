

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
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

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION store_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
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

select refresh('tpcds.store');