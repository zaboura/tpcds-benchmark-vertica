

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ship_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ship_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ship_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ship_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_category ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_item_sk, 
        i_category
 FROM tpcds.item 
 ORDER BY i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ship_customer_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ship_customer_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_ship_customer_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ship_customer_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ship_customer_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_ship_customer_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');