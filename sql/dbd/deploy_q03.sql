

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING COMMONDELTA_COMP, 
 d_moy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_moy
 FROM tpcds.date_dim 
 ORDER BY d_moy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_brand_id ENCODING ZSTD_FAST_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_manufact_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand_id, 
        i_brand, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_manufact_id,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');