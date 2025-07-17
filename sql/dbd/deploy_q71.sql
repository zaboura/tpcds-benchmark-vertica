

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_sold_time_sk ENCODING DELTAVAL, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_sold_time_sk ENCODING DELTAVAL, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_sold_time_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_sold_time_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');