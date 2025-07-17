

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_customer_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE, 
 cs_wholesale_cost ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_quantity, 
        cs_wholesale_cost, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_quantity,
          cs_order_number,
          cs_bill_customer_sk
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_customer_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE, 
 cs_wholesale_cost ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_quantity, 
        cs_wholesale_cost, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_quantity,
          cs_order_number,
          cs_bill_customer_sk
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION store_returns_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_item_sk ENCODING RLE, 
 sr_ticket_number ENCODING DELTAVAL
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number
 FROM tpcds.store_returns 
 ORDER BY sr_item_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_item_sk ENCODING RLE, 
 sr_ticket_number ENCODING DELTAVAL
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number
 FROM tpcds.store_returns 
 ORDER BY sr_item_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING RLE, 
 ss_wholesale_cost ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_quantity, 
        ss_wholesale_cost, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_quantity,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING RLE, 
 ss_wholesale_cost ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_quantity, 
        ss_wholesale_cost, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_quantity,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION web_sales_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_quantity ENCODING RLE, 
 ws_wholesale_cost ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_quantity, 
        ws_wholesale_cost, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_quantity,
          ws_order_number,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_quantity ENCODING RLE, 
 ws_wholesale_cost ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_quantity, 
        ws_wholesale_cost, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_quantity,
          ws_order_number,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');