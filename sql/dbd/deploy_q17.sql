

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_customer_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_quantity
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_quantity,
          cs_item_sk,
          cs_bill_customer_sk
SEGMENTED BY MODULARHASH (cs_item_sk, cs_bill_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_customer_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_quantity
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_quantity,
          cs_item_sk,
          cs_bill_customer_sk
SEGMENTED BY MODULARHASH (cs_item_sk, cs_bill_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION date_dim_DBD_2_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_quarter_name ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_quarter_name
 FROM tpcds.date_dim 
 ORDER BY d_quarter_name,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_return_quantity ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_return_quantity
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_return_quantity,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_return_quantity ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_return_quantity
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_return_quantity,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v1_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_quantity
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_quantity,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v1_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_quantity
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_quantity,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_5_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_state ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_state
 FROM tpcds.store 
 ORDER BY s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');