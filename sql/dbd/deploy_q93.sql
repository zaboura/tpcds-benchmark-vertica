

CREATE PROJECTION reason_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 r_reason_sk ENCODING COMMONDELTA_COMP, 
 r_reason_desc ENCODING ZSTD_FAST_COMP
)
AS
 SELECT r_reason_sk, 
        r_reason_desc
 FROM tpcds.reason 
 ORDER BY r_reason_desc,
          r_reason_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.reason');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_customer_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk,
          ss_ticket_number
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_customer_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk,
          ss_ticket_number
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');