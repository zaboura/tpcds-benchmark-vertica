
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.household_demographics_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.time_dim_DBD_3_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.store_DBD_3_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 s_store_sk ENCODING DELTAVAL,
 s_store_id ENCODING ZSTD_FAST_COMP,
 s_store_name ENCODING RLE,
 s_gmt_offset ENCODING RLE
)
AS
 SELECT store.s_store_sk,
        store.s_store_id,
        store.s_store_name,
        store.s_gmt_offset
 FROM tpcds.store
 ORDER BY store.s_gmt_offset,
          store.s_store_name,
          store.s_store_id
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

