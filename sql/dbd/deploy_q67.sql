

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2_v3 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING RLE, 
 d_year ENCODING COMMONDELTA_COMP, 
 d_moy ENCODING RLE, 
 d_qoy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq, 
        d_year, 
        d_moy, 
        d_qoy
 FROM tpcds.date_dim 
 ORDER BY d_month_seq,
          d_qoy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_quantity,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_quantity,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
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

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
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