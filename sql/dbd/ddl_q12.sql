
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.item_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 i_item_sk ENCODING DELTAVAL, 
 i_item_id ENCODING ZSTD_FAST_COMP, 
 i_item_desc ENCODING ZSTD_FAST_COMP, 
 i_current_price ENCODING COMMONDELTA_COMP, 
 i_class ENCODING RLE, 
 i_category ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_item_id, 
        i_item_desc, 
        i_current_price, 
        i_class, 
        i_category
 FROM tpcds.item 
 ORDER BY i_category,
          i_class,
          i_current_price,
          i_item_id,
          i_item_desc
UNSEGMENTED ALL NODES;

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

CREATE PROJECTION tpcds.web_sales_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(web_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ws_item_sk ENCODING RLE,
 ws_order_number ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING DELTAVAL,
 ws_web_site_sk ENCODING BLOCKDICT_COMP,
 ws_ext_sales_price ENCODING DELTARANGE_COMP,
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_order_number,
        web_sales.ws_sold_date_sk,
        web_sales.ws_web_site_sk,
        web_sales.ws_ext_sales_price,
        web_sales.ws_net_profit
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_item_sk,
          web_sales.ws_order_number
SEGMENTED BY hash(web_sales.ws_item_sk, web_sales.ws_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(web_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ws_item_sk ENCODING RLE,
 ws_order_number ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING DELTAVAL,
 ws_web_site_sk ENCODING BLOCKDICT_COMP,
 ws_ext_sales_price ENCODING DELTARANGE_COMP,
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_order_number,
        web_sales.ws_sold_date_sk,
        web_sales.ws_web_site_sk,
        web_sales.ws_ext_sales_price,
        web_sales.ws_net_profit
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_item_sk,
          web_sales.ws_order_number
SEGMENTED BY hash(web_sales.ws_item_sk, web_sales.ws_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

