
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.inventory_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(inventory_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
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

CREATE PROJECTION tpcds.inventory_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(inventory_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
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

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC1_v1 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/ 
(
 cs_item_sk ENCODING RLE,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_ext_discount_amt
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_item_sk,
          catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_ext_discount_amt
SEGMENTED BY hash(catalog_sales.cs_sold_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/ 
(
 cs_item_sk ENCODING RLE,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_ext_discount_amt
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_item_sk,
          catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_ext_discount_amt
SEGMENTED BY hash(catalog_sales.cs_sold_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

