

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cs_sold_date_sk ENCODING COMMONDELTA_COMP, 
 cs_ship_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ship_mode_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_date_sk, 
        cs_call_center_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_ship_mode_sk,
          cs_warehouse_sk,
          cs_sold_date_sk
SEGMENTED BY MODULARHASH (cs_ship_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cs_sold_date_sk ENCODING COMMONDELTA_COMP, 
 cs_ship_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ship_mode_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_date_sk, 
        cs_call_center_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_ship_mode_sk,
          cs_warehouse_sk,
          cs_sold_date_sk
SEGMENTED BY MODULARHASH (cs_ship_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');