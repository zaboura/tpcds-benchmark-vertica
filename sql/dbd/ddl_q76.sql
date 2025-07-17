
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ship_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ship_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ship_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ship_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_category ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_item_sk, 
        i_category
 FROM tpcds.item 
 ORDER BY i_item_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ship_customer_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ship_customer_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_ship_customer_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ship_customer_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ship_customer_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_ship_customer_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.date_dim_DBD_8_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date_id ENCODING ZSTD_FAST_COMP,
 d_date ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_week_seq ENCODING COMMONDELTA_COMP,
 d_quarter_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING COMMONDELTA_COMP,
 d_dow ENCODING RLE,
 d_moy ENCODING COMMONDELTA_COMP,
 d_dom ENCODING COMMONDELTA_COMP,
 d_qoy ENCODING RLE,
 d_fy_year ENCODING COMMONDELTA_COMP,
 d_fy_quarter_seq ENCODING COMMONDELTA_COMP,
 d_fy_week_seq ENCODING COMMONDELTA_COMP,
 d_day_name ENCODING ZSTD_FAST_COMP,
 d_quarter_name ENCODING ZSTD_FAST_COMP,
 d_holiday ENCODING RLE,
 d_weekend ENCODING RLE,
 d_following_holiday ENCODING RLE,
 d_first_dom ENCODING COMMONDELTA_COMP,
 d_last_dom ENCODING COMMONDELTA_COMP,
 d_same_day_ly ENCODING COMMONDELTA_COMP,
 d_same_day_lq ENCODING COMMONDELTA_COMP,
 d_current_day ENCODING RLE,
 d_current_week ENCODING RLE,
 d_current_month ENCODING RLE,
 d_current_quarter ENCODING RLE,
 d_current_year ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date_id,
        date_dim.d_date,
        date_dim.d_month_seq,
        date_dim.d_week_seq,
        date_dim.d_quarter_seq,
        date_dim.d_year,
        date_dim.d_dow,
        date_dim.d_moy,
        date_dim.d_dom,
        date_dim.d_qoy,
        date_dim.d_fy_year,
        date_dim.d_fy_quarter_seq,
        date_dim.d_fy_week_seq,
        date_dim.d_day_name,
        date_dim.d_quarter_name,
        date_dim.d_holiday,
        date_dim.d_weekend,
        date_dim.d_following_holiday,
        date_dim.d_first_dom,
        date_dim.d_last_dom,
        date_dim.d_same_day_ly,
        date_dim.d_same_day_lq,
        date_dim.d_current_day,
        date_dim.d_current_week,
        date_dim.d_current_month,
        date_dim.d_current_quarter,
        date_dim.d_current_year
 FROM tpcds.date_dim
 ORDER BY date_dim.d_current_day,
          date_dim.d_current_week,
          date_dim.d_holiday,
          date_dim.d_weekend,
          date_dim.d_following_holiday,
          date_dim.d_current_month,
          date_dim.d_current_quarter,
          date_dim.d_current_year,
          date_dim.d_qoy,
          date_dim.d_dow,
          date_dim.d_date
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.item_DBD_12_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_rec_start_date ENCODING RLE,
 i_rec_end_date ENCODING RLE,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING DELTARANGE_COMP,
 i_wholesale_cost ENCODING DELTARANGE_COMP,
 i_brand_id ENCODING BLOCKDICT_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_class_id ENCODING BLOCKDICT_COMP,
 i_class ENCODING ZSTD_FAST_COMP,
 i_category_id ENCODING RLE,
 i_category ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING DELTAVAL,
 i_manufact ENCODING ZSTD_FAST_COMP,
 i_size ENCODING RLE,
 i_formulation ENCODING ZSTD_FAST_COMP,
 i_color ENCODING ZSTD_FAST_COMP,
 i_units ENCODING ZSTD_FAST_COMP,
 i_container ENCODING RLE,
 i_manager_id ENCODING DELTAVAL,
 i_product_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_rec_start_date,
        item.i_rec_end_date,
        item.i_item_desc,
        item.i_current_price,
        item.i_wholesale_cost,
        item.i_brand_id,
        item.i_brand,
        item.i_class_id,
        item.i_class,
        item.i_category_id,
        item.i_category,
        item.i_manufact_id,
        item.i_manufact,
        item.i_size,
        item.i_formulation,
        item.i_color,
        item.i_units,
        item.i_container,
        item.i_manager_id,
        item.i_product_name
 FROM tpcds.item
 ORDER BY item.i_container,
          item.i_rec_end_date,
          item.i_rec_start_date,
          item.i_size,
          item.i_category_id,
          item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.item_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_current_price ENCODING DELTARANGE_COMP,
 i_category ENCODING RLE
)
AS
 SELECT item.i_item_sk,
        item.i_current_price,
        item.i_category
 FROM tpcds.item
 ORDER BY item.i_category,
          item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_qoy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_qoy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_qoy,
          date_dim.d_year,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING RLE,
 ss_store_sk ENCODING RLE,
 ss_ext_sales_price ENCODING DELTARANGE_COMP,
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_store_sk,
        store_sales.ss_ext_sales_price,
        store_sales.ss_net_profit
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_store_sk,
          store_sales.ss_sold_date_sk,
          store_sales.ss_ext_sales_price,
          store_sales.ss_net_profit
SEGMENTED BY hash(store_sales.ss_item_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING RLE,
 ss_store_sk ENCODING RLE,
 ss_ext_sales_price ENCODING DELTARANGE_COMP,
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_store_sk,
        store_sales.ss_ext_sales_price,
        store_sales.ss_net_profit
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_store_sk,
          store_sales.ss_sold_date_sk,
          store_sales.ss_ext_sales_price,
          store_sales.ss_net_profit
SEGMENTED BY hash(store_sales.ss_item_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

