

CREATE PROJECTION store_returns_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(store_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTARANGE_COMP, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(store_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTARANGE_COMP, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC_v1_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC_v1_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');