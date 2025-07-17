

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');