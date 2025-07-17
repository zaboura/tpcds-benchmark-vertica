

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_category ENCODING RLE, 
 i_manufact_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_category, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_category,
          i_manufact_id,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC1_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC1_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION web_sales_DBD_4_seg_DBD_TPCDS_INC1_b0 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_bill_addr_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_addr_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_bill_addr_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_4_seg_DBD_TPCDS_INC1_b1 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_bill_addr_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_addr_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_bill_addr_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');