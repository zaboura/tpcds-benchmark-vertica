

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE
)
AS
 SELECT ss_item_sk
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE
)
AS
 SELECT ss_item_sk
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');