

CREATE PROJECTION web_returns_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(web_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 wr_item_sk ENCODING RLE, 
 wr_order_number ENCODING DELTAVAL, 
 wr_returned_date_sk ENCODING DELTAVAL, 
 wr_return_amt ENCODING DELTAVAL, 
 wr_net_loss ENCODING DELTAVAL
)
AS
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_returned_date_sk, 
        wr_return_amt, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_item_sk,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_item_sk, wr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_returns_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(web_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 wr_item_sk ENCODING RLE, 
 wr_order_number ENCODING DELTAVAL, 
 wr_returned_date_sk ENCODING DELTAVAL, 
 wr_return_amt ENCODING DELTAVAL, 
 wr_net_loss ENCODING DELTAVAL
)
AS
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_returned_date_sk, 
        wr_return_amt, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_item_sk,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_item_sk, wr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_returns');

CREATE PROJECTION web_sales_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(web_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_web_site_sk ENCODING BLOCKDICT_COMP, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_order_number
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(web_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_web_site_sk ENCODING BLOCKDICT_COMP, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_order_number
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');