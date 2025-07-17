
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTARANGE_COMP,
 ss_sold_date_sk ENCODING RLE,
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_ext_sales_price
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_sold_date_sk,
          store_sales.ss_item_sk,
          store_sales.ss_ext_sales_price
SEGMENTED BY hash(store_sales.ss_sold_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTARANGE_COMP,
 ss_sold_date_sk ENCODING RLE,
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_ext_sales_price
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_sold_date_sk,
          store_sales.ss_item_sk,
          store_sales.ss_ext_sales_price
SEGMENTED BY hash(store_sales.ss_sold_date_sk) ALL NODES OFFSET 1;



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

