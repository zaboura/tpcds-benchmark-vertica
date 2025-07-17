
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.inventory_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(inventory_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.inventory_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(inventory_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.item_DBD_12_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_rec_start_date ENCODING RLE,
 i_rec_end_date ENCODING RLE,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING DELTARANGE_COMP,
 i_wholesale_cost ENCODING DELTARANGE_COMP,
 i_brand_id ENCODING BLOCKDICT_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_class_id ENCODING BLOCKDICT_COMP,
 i_class ENCODING ZSTD_FAST_COMP,
 i_category_id ENCODING RLE,
 i_category ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING DELTAVAL,
 i_manufact ENCODING ZSTD_FAST_COMP,
 i_size ENCODING RLE,
 i_formulation ENCODING ZSTD_FAST_COMP,
 i_color ENCODING ZSTD_FAST_COMP,
 i_units ENCODING ZSTD_FAST_COMP,
 i_container ENCODING RLE,
 i_manager_id ENCODING DELTAVAL,
 i_product_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_rec_start_date,
        item.i_rec_end_date,
        item.i_item_desc,
        item.i_current_price,
        item.i_wholesale_cost,
        item.i_brand_id,
        item.i_brand,
        item.i_class_id,
        item.i_class,
        item.i_category_id,
        item.i_category,
        item.i_manufact_id,
        item.i_manufact,
        item.i_size,
        item.i_formulation,
        item.i_color,
        item.i_units,
        item.i_container,
        item.i_manager_id,
        item.i_product_name
 FROM tpcds.item
 ORDER BY item.i_container,
          item.i_rec_end_date,
          item.i_rec_start_date,
          item.i_size,
          item.i_category_id,
          item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

