
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cr_returned_date_sk ENCODING RLE, 
 cr_call_center_sk ENCODING RLE, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_returned_date_sk, 
        cr_call_center_sk, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_call_center_sk,
          cr_returned_date_sk,
          cr_return_amount,
          cr_net_loss
SEGMENTED BY MODULARHASH (cr_returned_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cr_returned_date_sk ENCODING RLE, 
 cr_call_center_sk ENCODING RLE, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_returned_date_sk, 
        cr_call_center_sk, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_call_center_sk,
          cr_returned_date_sk,
          cr_return_amount,
          cr_net_loss
SEGMENTED BY MODULARHASH (cr_returned_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_call_center_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_call_center_sk,
          cs_sold_date_sk,
          cs_ext_sales_price,
          cs_net_profit
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_call_center_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_call_center_sk,
          cs_sold_date_sk,
          cs_ext_sales_price,
          cs_net_profit
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_returns_DBD_6_seg_DBD_TPCDS_INC3_b0 /*+basename(store_returns_DBD_6_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_store_sk ENCODING RLE, 
 sr_returned_date_sk ENCODING RLE, 
 sr_return_amt ENCODING DELTARANGE_COMP, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_store_sk, 
        sr_returned_date_sk, 
        sr_return_amt, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_store_sk,
          sr_returned_date_sk
SEGMENTED BY HASH (sr_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_returns_DBD_6_seg_DBD_TPCDS_INC3_b1 /*+basename(store_returns_DBD_6_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_store_sk ENCODING RLE, 
 sr_returned_date_sk ENCODING RLE, 
 sr_return_amt ENCODING DELTARANGE_COMP, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_store_sk, 
        sr_returned_date_sk, 
        sr_return_amt, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_store_sk,
          sr_returned_date_sk
SEGMENTED BY HASH (sr_store_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_DBD_7_seg_DBD_TPCDS_INC3_b0 /*+basename(store_DBD_7_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_DBD_7_seg_DBD_TPCDS_INC3_b1 /*+basename(store_DBD_7_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_page_DBD_3_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 wp_web_page_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT wp_web_page_sk
 FROM tpcds.web_page 
 ORDER BY wp_web_page_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_returns_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(web_returns_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 wr_returned_date_sk ENCODING DELTAVAL, 
 wr_web_page_sk ENCODING RLE, 
 wr_return_amt ENCODING DELTARANGE_COMP, 
 wr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT wr_returned_date_sk, 
        wr_web_page_sk, 
        wr_return_amt, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_web_page_sk,
          wr_return_amt
SEGMENTED BY MODULARHASH (wr_returned_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_returns_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(web_returns_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 wr_returned_date_sk ENCODING DELTAVAL, 
 wr_web_page_sk ENCODING RLE, 
 wr_return_amt ENCODING DELTARANGE_COMP, 
 wr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT wr_returned_date_sk, 
        wr_web_page_sk, 
        wr_return_amt, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_web_page_sk,
          wr_return_amt
SEGMENTED BY MODULARHASH (wr_returned_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_sales_DBD_5_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_web_page_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_web_page_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_web_page_sk,
          ws_sold_date_sk,
          ws_ext_sales_price,
          ws_net_profit
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_5_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_web_page_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_web_page_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_web_page_sk,
          ws_sold_date_sk,
          ws_ext_sales_price,
          ws_net_profit
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date_sk
SEGMENTED BY hash(date_dim.d_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date_sk
SEGMENTED BY hash(date_dim.d_date_sk) ALL NODES OFFSET 1;



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

