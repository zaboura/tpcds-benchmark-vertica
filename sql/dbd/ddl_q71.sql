
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_sold_time_sk ENCODING DELTAVAL, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_sold_time_sk ENCODING DELTAVAL, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_sold_time_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_sold_time_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.time_dim_DBD_19_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 t_time_sk ENCODING COMMONDELTA_COMP,
 t_time_id ENCODING ZSTD_FAST_COMP,
 t_time ENCODING COMMONDELTA_COMP,
 t_hour ENCODING RLE,
 t_minute ENCODING RLE,
 t_second ENCODING COMMONDELTA_COMP,
 t_am_pm ENCODING RLE,
 t_shift ENCODING RLE,
 t_sub_shift ENCODING RLE,
 t_meal_time ENCODING RLE
)
AS
 SELECT time_dim.t_time_sk,
        time_dim.t_time_id,
        time_dim.t_time,
        time_dim.t_hour,
        time_dim.t_minute,
        time_dim.t_second,
        time_dim.t_am_pm,
        time_dim.t_shift,
        time_dim.t_sub_shift,
        time_dim.t_meal_time
 FROM tpcds.time_dim
 ORDER BY time_dim.t_am_pm,
          time_dim.t_shift,
          time_dim.t_sub_shift,
          time_dim.t_meal_time,
          time_dim.t_hour,
          time_dim.t_time
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_moy,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.item_DBD_3_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/ 
(
 i_item_sk ENCODING DELTAVAL,
 i_brand_id ENCODING ZSTD_FAST_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING DELTAVAL,
 i_manufact ENCODING ZSTD_FAST_COMP,
 i_manager_id ENCODING RLE
)
AS
 SELECT item.i_item_sk,
        item.i_brand_id,
        item.i_brand,
        item.i_manufact_id,
        item.i_manufact,
        item.i_manager_id
 FROM tpcds.item
 ORDER BY item.i_manager_id,
          item.i_brand,
          item.i_brand_id,
          item.i_manufact_id,
          item.i_manufact
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

