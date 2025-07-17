
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

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

