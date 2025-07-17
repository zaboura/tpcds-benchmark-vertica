

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq
 FROM tpcds.date_dim 
 ORDER BY d_month_seq,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION inventory_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(inventory_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 inv_item_sk ENCODING RLE, 
 inv_date_sk ENCODING RLE, 
 inv_quantity_on_hand ENCODING DELTAVAL
)
AS
 SELECT inv_item_sk, 
        inv_date_sk, 
        inv_quantity_on_hand
 FROM tpcds.inventory 
 ORDER BY inv_date_sk,
          inv_item_sk,
          inv_quantity_on_hand
SEGMENTED BY MODULARHASH (inv_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION inventory_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(inventory_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 inv_item_sk ENCODING RLE, 
 inv_date_sk ENCODING RLE, 
 inv_quantity_on_hand ENCODING DELTAVAL
)
AS
 SELECT inv_item_sk, 
        inv_date_sk, 
        inv_quantity_on_hand
 FROM tpcds.inventory 
 ORDER BY inv_date_sk,
          inv_item_sk,
          inv_quantity_on_hand
SEGMENTED BY MODULARHASH (inv_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.inventory');