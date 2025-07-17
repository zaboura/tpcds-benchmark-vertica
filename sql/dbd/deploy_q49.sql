

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cr_item_sk ENCODING DELTAVAL, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_quantity ENCODING BLOCKDICT_COMP, 
 cr_return_amount ENCODING RLE
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_quantity, 
        cr_return_amount
 FROM tpcds.catalog_returns 
 ORDER BY cr_return_amount,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cr_item_sk ENCODING DELTAVAL, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_quantity ENCODING BLOCKDICT_COMP, 
 cr_return_amount ENCODING RLE
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_quantity, 
        cr_return_amount
 FROM tpcds.catalog_returns 
 ORDER BY cr_return_amount,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_order_number ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE, 
 cs_net_paid ENCODING DELTAVAL, 
 cs_net_profit ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_quantity, 
        cs_net_paid, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_quantity,
          cs_item_sk,
          cs_order_number,
          cs_net_paid
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_order_number ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE, 
 cs_net_paid ENCODING DELTAVAL, 
 cs_net_profit ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_quantity, 
        cs_net_paid, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_quantity,
          cs_item_sk,
          cs_order_number,
          cs_net_paid
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 sr_item_sk ENCODING DELTAVAL, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_return_quantity ENCODING BLOCKDICT_COMP, 
 sr_return_amt ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_return_quantity, 
        sr_return_amt
 FROM tpcds.store_returns 
 ORDER BY sr_return_amt,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 sr_item_sk ENCODING DELTAVAL, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_return_quantity ENCODING BLOCKDICT_COMP, 
 sr_return_amt ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_return_quantity, 
        sr_return_amt
 FROM tpcds.store_returns 
 ORDER BY sr_return_amt,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING RLE, 
 ss_net_paid ENCODING DELTAVAL, 
 ss_net_profit ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_quantity, 
        ss_net_paid, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_net_profit,
          ss_quantity,
          ss_ticket_number,
          ss_net_paid
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING RLE, 
 ss_net_paid ENCODING DELTAVAL, 
 ss_net_profit ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_quantity, 
        ss_net_paid, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_net_profit,
          ss_quantity,
          ss_ticket_number,
          ss_net_paid
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION web_returns_DBD_5_seg_DBD_TPCDS_INC2_b0 /*+basename(web_returns_DBD_5_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 wr_item_sk ENCODING DELTAVAL, 
 wr_order_number ENCODING DELTAVAL, 
 wr_return_quantity ENCODING BLOCKDICT_COMP, 
 wr_return_amt ENCODING RLE
)
AS
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_return_quantity, 
        wr_return_amt
 FROM tpcds.web_returns 
 ORDER BY wr_return_amt,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_item_sk, wr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_returns_DBD_5_seg_DBD_TPCDS_INC2_b1 /*+basename(web_returns_DBD_5_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 wr_item_sk ENCODING DELTAVAL, 
 wr_order_number ENCODING DELTAVAL, 
 wr_return_quantity ENCODING BLOCKDICT_COMP, 
 wr_return_amt ENCODING RLE
)
AS
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_return_quantity, 
        wr_return_amt
 FROM tpcds.web_returns 
 ORDER BY wr_return_amt,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_item_sk, wr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_returns');

CREATE PROJECTION web_sales_DBD_6_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_6_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING RLE, 
 ws_quantity ENCODING RLE, 
 ws_net_paid ENCODING DELTAVAL, 
 ws_net_profit ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_quantity, 
        ws_net_paid, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_quantity,
          ws_sold_date_sk,
          ws_order_number,
          ws_net_paid
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_6_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_6_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING RLE, 
 ws_quantity ENCODING RLE, 
 ws_net_paid ENCODING DELTAVAL, 
 ws_net_profit ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_quantity, 
        ws_net_paid, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_quantity,
          ws_sold_date_sk,
          ws_order_number,
          ws_net_paid
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');