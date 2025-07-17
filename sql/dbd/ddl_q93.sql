
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.reason_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_returns_DBD_16_seg_MC_TPCDS_COMP_b0 /*+basename(store_returns_DBD_16_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 sr_item_sk ENCODING DELTAVAL,
 sr_ticket_number ENCODING DELTARANGE_COMP,
 sr_returned_date_sk ENCODING DELTAVAL,
 sr_return_time_sk ENCODING DELTAVAL,
 sr_customer_sk ENCODING DELTAVAL,
 sr_cdemo_sk ENCODING DELTAVAL,
 sr_hdemo_sk ENCODING DELTAVAL,
 sr_addr_sk ENCODING DELTAVAL,
 sr_store_sk ENCODING RLE,
 sr_reason_sk ENCODING RLE,
 sr_return_quantity ENCODING RLE,
 sr_return_amt ENCODING DELTARANGE_COMP,
 sr_return_tax ENCODING DELTARANGE_COMP,
 sr_return_amt_inc_tax ENCODING DELTARANGE_COMP,
 sr_fee ENCODING DELTAVAL,
 sr_return_ship_cost ENCODING DELTARANGE_COMP,
 sr_refunded_cash ENCODING DELTARANGE_COMP,
 sr_reversed_charge ENCODING DELTARANGE_COMP,
 sr_store_credit ENCODING DELTARANGE_COMP,
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT store_returns.sr_item_sk,
        store_returns.sr_ticket_number,
        store_returns.sr_returned_date_sk,
        store_returns.sr_return_time_sk,
        store_returns.sr_customer_sk,
        store_returns.sr_cdemo_sk,
        store_returns.sr_hdemo_sk,
        store_returns.sr_addr_sk,
        store_returns.sr_store_sk,
        store_returns.sr_reason_sk,
        store_returns.sr_return_quantity,
        store_returns.sr_return_amt,
        store_returns.sr_return_tax,
        store_returns.sr_return_amt_inc_tax,
        store_returns.sr_fee,
        store_returns.sr_return_ship_cost,
        store_returns.sr_refunded_cash,
        store_returns.sr_reversed_charge,
        store_returns.sr_store_credit,
        store_returns.sr_net_loss
 FROM tpcds.store_returns
 ORDER BY store_returns.sr_reason_sk,
          store_returns.sr_return_quantity,
          store_returns.sr_store_sk,
          store_returns.sr_ticket_number
SEGMENTED BY hash(store_returns.sr_ticket_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_returns_DBD_16_seg_MC_TPCDS_COMP_b1 /*+basename(store_returns_DBD_16_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 sr_item_sk ENCODING DELTAVAL,
 sr_ticket_number ENCODING DELTARANGE_COMP,
 sr_returned_date_sk ENCODING DELTAVAL,
 sr_return_time_sk ENCODING DELTAVAL,
 sr_customer_sk ENCODING DELTAVAL,
 sr_cdemo_sk ENCODING DELTAVAL,
 sr_hdemo_sk ENCODING DELTAVAL,
 sr_addr_sk ENCODING DELTAVAL,
 sr_store_sk ENCODING RLE,
 sr_reason_sk ENCODING RLE,
 sr_return_quantity ENCODING RLE,
 sr_return_amt ENCODING DELTARANGE_COMP,
 sr_return_tax ENCODING DELTARANGE_COMP,
 sr_return_amt_inc_tax ENCODING DELTARANGE_COMP,
 sr_fee ENCODING DELTAVAL,
 sr_return_ship_cost ENCODING DELTARANGE_COMP,
 sr_refunded_cash ENCODING DELTARANGE_COMP,
 sr_reversed_charge ENCODING DELTARANGE_COMP,
 sr_store_credit ENCODING DELTARANGE_COMP,
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT store_returns.sr_item_sk,
        store_returns.sr_ticket_number,
        store_returns.sr_returned_date_sk,
        store_returns.sr_return_time_sk,
        store_returns.sr_customer_sk,
        store_returns.sr_cdemo_sk,
        store_returns.sr_hdemo_sk,
        store_returns.sr_addr_sk,
        store_returns.sr_store_sk,
        store_returns.sr_reason_sk,
        store_returns.sr_return_quantity,
        store_returns.sr_return_amt,
        store_returns.sr_return_tax,
        store_returns.sr_return_amt_inc_tax,
        store_returns.sr_fee,
        store_returns.sr_return_ship_cost,
        store_returns.sr_refunded_cash,
        store_returns.sr_reversed_charge,
        store_returns.sr_store_credit,
        store_returns.sr_net_loss
 FROM tpcds.store_returns
 ORDER BY store_returns.sr_reason_sk,
          store_returns.sr_return_quantity,
          store_returns.sr_store_sk,
          store_returns.sr_ticket_number
SEGMENTED BY hash(store_returns.sr_ticket_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

