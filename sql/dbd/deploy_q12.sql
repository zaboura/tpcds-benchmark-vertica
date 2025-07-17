

CREATE PROJECTION item_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
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

select refresh('tpcds.item');