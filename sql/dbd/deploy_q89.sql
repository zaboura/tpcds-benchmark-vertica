

CREATE PROJECTION item_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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

select refresh('tpcds.item');

CREATE PROJECTION store_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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

select refresh('tpcds.store');