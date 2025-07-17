

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_catalog_page_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_catalog_page_sk, 
        cs_promo_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_order_number,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_catalog_page_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_catalog_page_sk, 
        cs_promo_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_order_number,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_web_site_sk ENCODING RLE, 
 ws_promo_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_promo_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_web_site_sk,
          ws_order_number,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_web_site_sk ENCODING RLE, 
 ws_promo_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_promo_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_web_site_sk,
          ws_order_number,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');