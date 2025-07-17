

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_refunded_cash
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_refunded_cash
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_warehouse_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_warehouse_sk,
          cs_item_sk,
          cs_order_number
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_warehouse_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_warehouse_sk,
          cs_item_sk,
          cs_order_number
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');