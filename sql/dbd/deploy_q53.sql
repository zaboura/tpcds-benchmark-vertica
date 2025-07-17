

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING RLE, 
 d_qoy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq, 
        d_qoy
 FROM tpcds.date_dim 
 ORDER BY d_month_seq,
          d_qoy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_class ENCODING ZSTD_FAST_COMP, 
 i_category ENCODING RLE, 
 i_manufact_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand, 
        i_class, 
        i_category, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_manufact_id,
          i_category,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_b0 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
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

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_b1 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
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