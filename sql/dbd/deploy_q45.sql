

CREATE PROJECTION customer_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(customer_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_customer_sk
SEGMENTED BY MODULARHASH (c_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(customer_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_customer_sk
SEGMENTED BY MODULARHASH (c_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_item_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_item_sk, 
        i_item_id
 FROM tpcds.item 
 ORDER BY i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_bill_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_bill_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');