
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
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_item_desc,
        item.i_current_price,
        item.i_class,
        item.i_category
 FROM tpcds.item
 ORDER BY item.i_category,
          item.i_class,
          item.i_current_price,
          item.i_item_id,
          item.i_item_desc
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq
 FROM tpcds.date_dim
 ORDER BY date_dim.d_month_seq,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_6_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_6_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTAVAL,
 ws_order_number ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING RLE,
 ws_quantity ENCODING RLE,
 ws_net_paid ENCODING DELTAVAL,
 ws_net_profit ENCODING DELTAVAL
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_order_number,
        web_sales.ws_sold_date_sk,
        web_sales.ws_quantity,
        web_sales.ws_net_paid,
        web_sales.ws_net_profit
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_quantity,
          web_sales.ws_sold_date_sk,
          web_sales.ws_order_number,
          web_sales.ws_net_paid
SEGMENTED BY hash(web_sales.ws_item_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_6_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_6_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTAVAL,
 ws_order_number ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING RLE,
 ws_quantity ENCODING RLE,
 ws_net_paid ENCODING DELTAVAL,
 ws_net_profit ENCODING DELTAVAL
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_order_number,
        web_sales.ws_sold_date_sk,
        web_sales.ws_quantity,
        web_sales.ws_net_paid,
        web_sales.ws_net_profit
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_quantity,
          web_sales.ws_sold_date_sk,
          web_sales.ws_order_number,
          web_sales.ws_net_paid
SEGMENTED BY hash(web_sales.ws_item_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

