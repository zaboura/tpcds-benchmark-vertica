

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_discount_amt
 FROM tpcds.catalog_sales 
 ORDER BY cs_item_sk,
          cs_sold_date_sk,
          cs_ext_discount_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_discount_amt
 FROM tpcds.catalog_sales 
 ORDER BY cs_item_sk,
          cs_sold_date_sk,
          cs_ext_discount_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');