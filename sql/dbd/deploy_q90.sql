

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

CREATE PROJECTION time_dim_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 t_time_sk ENCODING COMMONDELTA_COMP, 
 t_hour ENCODING RLE
)
AS
 SELECT t_time_sk, 
        t_hour
 FROM tpcds.time_dim 
 ORDER BY t_hour,
          t_time_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.time_dim');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 ws_sold_time_sk ENCODING DELTARANGE_COMP, 
 ws_ship_hdemo_sk ENCODING RLE, 
 ws_web_page_sk ENCODING DELTAVAL
)
AS
 SELECT ws_sold_time_sk, 
        ws_ship_hdemo_sk, 
        ws_web_page_sk
 FROM tpcds.web_sales 
 ORDER BY ws_ship_hdemo_sk,
          ws_sold_time_sk,
          ws_web_page_sk
SEGMENTED BY MODULARHASH (ws_sold_time_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 ws_sold_time_sk ENCODING DELTARANGE_COMP, 
 ws_ship_hdemo_sk ENCODING RLE, 
 ws_web_page_sk ENCODING DELTAVAL
)
AS
 SELECT ws_sold_time_sk, 
        ws_ship_hdemo_sk, 
        ws_web_page_sk
 FROM tpcds.web_sales 
 ORDER BY ws_ship_hdemo_sk,
          ws_sold_time_sk,
          ws_web_page_sk
SEGMENTED BY MODULARHASH (ws_sold_time_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');