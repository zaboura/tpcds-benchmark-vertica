

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_day_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_day_name
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_3_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 s_store_sk ENCODING DELTAVAL, 
 s_store_id ENCODING ZSTD_FAST_COMP, 
 s_store_name ENCODING RLE, 
 s_gmt_offset ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_store_id, 
        s_store_name, 
        s_gmt_offset
 FROM tpcds.store 
 ORDER BY s_gmt_offset,
          s_store_name,
          s_store_id
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');