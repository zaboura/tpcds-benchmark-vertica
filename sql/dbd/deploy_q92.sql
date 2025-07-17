

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ext_discount_amt
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_sold_date_sk,
          ws_ext_discount_amt
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ext_discount_amt
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_sold_date_sk,
          ws_ext_discount_amt
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');