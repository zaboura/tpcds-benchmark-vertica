
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.store_returns_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_returns_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.web_sales_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.web_sales_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.web_returns_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(web_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 wr_item_sk ENCODING RLE,
 wr_order_number ENCODING DELTAVAL,
 wr_returned_date_sk ENCODING DELTAVAL,
 wr_return_amt ENCODING DELTAVAL,
 wr_net_loss ENCODING DELTAVAL
)
AS
 SELECT web_returns.wr_item_sk,
        web_returns.wr_order_number,
        web_returns.wr_returned_date_sk,
        web_returns.wr_return_amt,
        web_returns.wr_net_loss
 FROM tpcds.web_returns
 ORDER BY web_returns.wr_item_sk,
          web_returns.wr_order_number
SEGMENTED BY hash(web_returns.wr_item_sk, web_returns.wr_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_returns_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(web_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 wr_item_sk ENCODING RLE,
 wr_order_number ENCODING DELTAVAL,
 wr_returned_date_sk ENCODING DELTAVAL,
 wr_return_amt ENCODING DELTAVAL,
 wr_net_loss ENCODING DELTAVAL
)
AS
 SELECT web_returns.wr_item_sk,
        web_returns.wr_order_number,
        web_returns.wr_returned_date_sk,
        web_returns.wr_return_amt,
        web_returns.wr_net_loss
 FROM tpcds.web_returns
 ORDER BY web_returns.wr_item_sk,
          web_returns.wr_order_number
SEGMENTED BY hash(web_returns.wr_item_sk, web_returns.wr_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_moy,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_4_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 cr_item_sk ENCODING RLE,
 cr_order_number ENCODING DELTAVAL,
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_returns.cr_item_sk,
        catalog_returns.cr_order_number,
        catalog_returns.cr_refunded_cash
 FROM tpcds.catalog_returns
 ORDER BY catalog_returns.cr_item_sk,
          catalog_returns.cr_order_number
SEGMENTED BY hash(catalog_returns.cr_item_sk, catalog_returns.cr_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 cr_item_sk ENCODING RLE,
 cr_order_number ENCODING DELTAVAL,
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_returns.cr_item_sk,
        catalog_returns.cr_order_number,
        catalog_returns.cr_refunded_cash
 FROM tpcds.catalog_returns
 ORDER BY catalog_returns.cr_item_sk,
          catalog_returns.cr_order_number
SEGMENTED BY hash(catalog_returns.cr_item_sk, catalog_returns.cr_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

