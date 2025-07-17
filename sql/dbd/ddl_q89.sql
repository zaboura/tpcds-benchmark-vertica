
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.item_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_class ENCODING RLE, 
 i_category ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand, 
        i_class, 
        i_category
 FROM tpcds.item 
 ORDER BY i_category,
          i_class,
          i_item_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.store_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_name ENCODING ZSTD_FAST_COMP, 
 s_company_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_name, 
        s_company_name
 FROM tpcds.store 
 ORDER BY s_store_sk
UNSEGMENTED ALL NODES;

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

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING RLE,
 ss_store_sk ENCODING RLE,
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_store_sk,
        store_sales.ss_sales_price
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_store_sk,
          store_sales.ss_sold_date_sk,
          store_sales.ss_item_sk,
          store_sales.ss_sales_price
SEGMENTED BY hash(store_sales.ss_sold_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING RLE,
 ss_store_sk ENCODING RLE,
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_store_sk,
        store_sales.ss_sales_price
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_store_sk,
          store_sales.ss_sold_date_sk,
          store_sales.ss_item_sk,
          store_sales.ss_sales_price
SEGMENTED BY hash(store_sales.ss_sold_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

