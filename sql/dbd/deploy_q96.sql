

CREATE PROJECTION household_demographics_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 hd_demo_sk ENCODING COMMONDELTA_COMP, 
 hd_dep_count ENCODING RLE
)
AS
 SELECT hd_demo_sk, 
        hd_dep_count
 FROM tpcds.household_demographics 
 ORDER BY hd_dep_count,
          hd_demo_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.household_demographics');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE
)
AS
 SELECT ss_sold_time_sk, 
        ss_hdemo_sk, 
        ss_store_sk
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_sold_time_sk
SEGMENTED BY MODULARHASH (ss_sold_time_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE
)
AS
 SELECT ss_sold_time_sk, 
        ss_hdemo_sk, 
        ss_store_sk
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_sold_time_sk
SEGMENTED BY MODULARHASH (ss_sold_time_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION time_dim_DBD_3_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 t_time_sk ENCODING COMMONDELTA_COMP, 
 t_hour ENCODING RLE, 
 t_minute ENCODING RLE
)
AS
 SELECT t_time_sk, 
        t_hour, 
        t_minute
 FROM tpcds.time_dim 
 ORDER BY t_hour,
          t_minute,
          t_time_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.time_dim');