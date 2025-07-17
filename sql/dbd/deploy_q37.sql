

CREATE PROJECTION inventory_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(inventory_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 inv_item_sk ENCODING DELTARANGE_COMP, 
 inv_date_sk ENCODING RLE, 
 inv_quantity_on_hand ENCODING RLE
)
AS
 SELECT inv_item_sk, 
        inv_date_sk, 
        inv_quantity_on_hand
 FROM tpcds.inventory 
 ORDER BY inv_date_sk,
          inv_quantity_on_hand,
          inv_item_sk
SEGMENTED BY MODULARHASH (inv_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION inventory_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(inventory_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 inv_item_sk ENCODING DELTARANGE_COMP, 
 inv_date_sk ENCODING RLE, 
 inv_quantity_on_hand ENCODING RLE
)
AS
 SELECT inv_item_sk, 
        inv_date_sk, 
        inv_quantity_on_hand
 FROM tpcds.inventory 
 ORDER BY inv_date_sk,
          inv_quantity_on_hand,
          inv_item_sk
SEGMENTED BY MODULARHASH (inv_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.inventory');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC1_v1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTAVAL, 
 i_item_id ENCODING ZSTD_FAST_COMP, 
 i_item_desc ENCODING ZSTD_FAST_COMP, 
 i_current_price ENCODING RLE, 
 i_manufact_id ENCODING DELTAVAL
)
AS
 SELECT i_item_sk, 
        i_item_id, 
        i_item_desc, 
        i_current_price, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_current_price,
          i_item_id,
          i_item_desc
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');