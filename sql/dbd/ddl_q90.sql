
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

CREATE PROJECTION tpcds.time_dim_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
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

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
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

CREATE PROJECTION tpcds.web_page_DBD_21_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 wp_web_page_sk ENCODING COMMONDELTA_COMP,
 wp_web_page_id ENCODING ZSTD_FAST_COMP,
 wp_rec_start_date ENCODING RLE,
 wp_rec_end_date ENCODING RLE,
 wp_creation_date_sk ENCODING ZSTD_FAST_COMP,
 wp_access_date_sk ENCODING DELTAVAL,
 wp_autogen_flag ENCODING RLE,
 wp_customer_sk ENCODING DELTARANGE_COMP,
 wp_url ENCODING RLE,
 wp_type ENCODING ZSTD_FAST_COMP,
 wp_char_count ENCODING DELTAVAL,
 wp_link_count ENCODING DELTAVAL,
 wp_image_count ENCODING DELTAVAL,
 wp_max_ad_count ENCODING BLOCKDICT_COMP
)
AS
 SELECT web_page.wp_web_page_sk,
        web_page.wp_web_page_id,
        web_page.wp_rec_start_date,
        web_page.wp_rec_end_date,
        web_page.wp_creation_date_sk,
        web_page.wp_access_date_sk,
        web_page.wp_autogen_flag,
        web_page.wp_customer_sk,
        web_page.wp_url,
        web_page.wp_type,
        web_page.wp_char_count,
        web_page.wp_link_count,
        web_page.wp_image_count,
        web_page.wp_max_ad_count
 FROM tpcds.web_page
 ORDER BY web_page.wp_url,
          web_page.wp_autogen_flag,
          web_page.wp_rec_end_date,
          web_page.wp_rec_start_date,
          web_page.wp_web_page_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

