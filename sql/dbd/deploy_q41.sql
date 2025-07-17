

CREATE PROJECTION item_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(item_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 i_category ENCODING ZSTD_FAST_COMP, 
 i_manufact_id ENCODING DELTAVAL, 
 i_manufact ENCODING ZSTD_FAST_COMP, 
 i_size ENCODING ZSTD_FAST_COMP, 
 i_color ENCODING ZSTD_FAST_COMP, 
 i_units ENCODING ZSTD_FAST_COMP, 
 i_product_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_category, 
        i_manufact_id, 
        i_manufact, 
        i_size, 
        i_color, 
        i_units, 
        i_product_name
 FROM tpcds.item 
 ORDER BY i_product_name
SEGMENTED BY MODULARHASH (i_manufact) ALL NODES OFFSET 0;

CREATE PROJECTION item_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(item_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 i_category ENCODING ZSTD_FAST_COMP, 
 i_manufact_id ENCODING DELTAVAL, 
 i_manufact ENCODING ZSTD_FAST_COMP, 
 i_size ENCODING ZSTD_FAST_COMP, 
 i_color ENCODING ZSTD_FAST_COMP, 
 i_units ENCODING ZSTD_FAST_COMP, 
 i_product_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_category, 
        i_manufact_id, 
        i_manufact, 
        i_size, 
        i_color, 
        i_units, 
        i_product_name
 FROM tpcds.item 
 ORDER BY i_product_name
SEGMENTED BY MODULARHASH (i_manufact) ALL NODES OFFSET 1;

select refresh('tpcds.item');