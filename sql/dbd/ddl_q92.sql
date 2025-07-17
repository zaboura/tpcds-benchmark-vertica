
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.web_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ext_discount_amt
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_sold_date_sk,
          ws_ext_discount_amt
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ext_discount_amt
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_sold_date_sk,
          ws_ext_discount_amt
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 i_item_sk ENCODING DELTARANGE_COMP,
 i_brand_id ENCODING ZSTD_FAST_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING RLE
)
AS
 SELECT item.i_item_sk,
        item.i_brand_id,
        item.i_brand,
        item.i_manufact_id
 FROM tpcds.item
 ORDER BY item.i_manufact_id,
          item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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


select mark_design_ksafe(1);

