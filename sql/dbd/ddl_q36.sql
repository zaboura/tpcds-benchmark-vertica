
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_ext_sales_price,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_ext_sales_price,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

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

CREATE PROJECTION tpcds.store_DBD_5_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 s_store_sk ENCODING COMMONDELTA_COMP,
 s_state ENCODING ZSTD_FAST_COMP
)
AS
 SELECT store.s_store_sk,
        store.s_state
 FROM tpcds.store
 ORDER BY store.s_store_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

