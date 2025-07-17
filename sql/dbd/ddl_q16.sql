
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.call_center_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 cc_call_center_sk ENCODING AUTO, 
 cc_county ENCODING ZSTD_FAST_COMP
)
AS
 SELECT cc_call_center_sk, 
        cc_county
 FROM tpcds.call_center 
 ORDER BY cc_county,
          cc_call_center_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_order_number ENCODING DELTAVAL, 
 cs_ship_date_sk ENCODING RLE, 
 cs_ship_addr_sk ENCODING DELTAVAL, 
 cs_call_center_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_ext_ship_cost ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_order_number, 
        cs_ship_date_sk, 
        cs_ship_addr_sk, 
        cs_call_center_sk, 
        cs_warehouse_sk, 
        cs_ext_ship_cost, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_warehouse_sk,
          cs_order_number,
          cs_ext_ship_cost
SEGMENTED BY MODULARHASH (cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_order_number ENCODING DELTAVAL, 
 cs_ship_date_sk ENCODING RLE, 
 cs_ship_addr_sk ENCODING DELTAVAL, 
 cs_call_center_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_ext_ship_cost ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_order_number, 
        cs_ship_date_sk, 
        cs_ship_addr_sk, 
        cs_call_center_sk, 
        cs_warehouse_sk, 
        cs_ext_ship_cost, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_warehouse_sk,
          cs_order_number,
          cs_ext_ship_cost
SEGMENTED BY MODULARHASH (cs_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date
 FROM tpcds.date_dim 
 ORDER BY d_date_sk
SEGMENTED BY HASH (d_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date
 FROM tpcds.date_dim 
 ORDER BY d_date_sk
SEGMENTED BY HASH (d_date_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.catalog_returns_DBD_3_seg_MC_TPCDS_COMP_b0 /*+basename(catalog_returns_DBD_3_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 cr_item_sk ENCODING DELTAVAL,
 cr_order_number ENCODING DELTARANGE_COMP,
 cr_returned_date_sk ENCODING DELTARANGE_COMP,
 cr_returned_time_sk ENCODING DELTAVAL,
 cr_refunded_customer_sk ENCODING DELTAVAL,
 cr_refunded_cdemo_sk ENCODING DELTAVAL,
 cr_refunded_hdemo_sk ENCODING DELTAVAL,
 cr_refunded_addr_sk ENCODING DELTAVAL,
 cr_returning_customer_sk ENCODING DELTAVAL,
 cr_returning_cdemo_sk ENCODING DELTAVAL,
 cr_returning_hdemo_sk ENCODING DELTAVAL,
 cr_returning_addr_sk ENCODING DELTAVAL,
 cr_call_center_sk ENCODING RLE,
 cr_catalog_page_sk ENCODING DELTARANGE_COMP,
 cr_ship_mode_sk ENCODING RLE,
 cr_warehouse_sk ENCODING RLE,
 cr_reason_sk ENCODING RLE,
 cr_return_quantity ENCODING BLOCKDICT_COMP,
 cr_return_amount ENCODING DELTARANGE_COMP,
 cr_return_tax ENCODING DELTARANGE_COMP,
 cr_return_amt_inc_tax ENCODING DELTARANGE_COMP,
 cr_fee ENCODING DELTAVAL,
 cr_return_ship_cost ENCODING DELTARANGE_COMP,
 cr_refunded_cash ENCODING DELTARANGE_COMP,
 cr_reversed_charge ENCODING DELTARANGE_COMP,
 cr_store_credit ENCODING DELTARANGE_COMP,
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_returns.cr_item_sk,
        catalog_returns.cr_order_number,
        catalog_returns.cr_returned_date_sk,
        catalog_returns.cr_returned_time_sk,
        catalog_returns.cr_refunded_customer_sk,
        catalog_returns.cr_refunded_cdemo_sk,
        catalog_returns.cr_refunded_hdemo_sk,
        catalog_returns.cr_refunded_addr_sk,
        catalog_returns.cr_returning_customer_sk,
        catalog_returns.cr_returning_cdemo_sk,
        catalog_returns.cr_returning_hdemo_sk,
        catalog_returns.cr_returning_addr_sk,
        catalog_returns.cr_call_center_sk,
        catalog_returns.cr_catalog_page_sk,
        catalog_returns.cr_ship_mode_sk,
        catalog_returns.cr_warehouse_sk,
        catalog_returns.cr_reason_sk,
        catalog_returns.cr_return_quantity,
        catalog_returns.cr_return_amount,
        catalog_returns.cr_return_tax,
        catalog_returns.cr_return_amt_inc_tax,
        catalog_returns.cr_fee,
        catalog_returns.cr_return_ship_cost,
        catalog_returns.cr_refunded_cash,
        catalog_returns.cr_reversed_charge,
        catalog_returns.cr_store_credit,
        catalog_returns.cr_net_loss
 FROM tpcds.catalog_returns
 ORDER BY catalog_returns.cr_warehouse_sk,
          catalog_returns.cr_ship_mode_sk,
          catalog_returns.cr_call_center_sk,
          catalog_returns.cr_reason_sk,
          catalog_returns.cr_order_number
SEGMENTED BY hash(catalog_returns.cr_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_returns_DBD_3_seg_MC_TPCDS_COMP_b1 /*+basename(catalog_returns_DBD_3_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 cr_item_sk ENCODING DELTAVAL,
 cr_order_number ENCODING DELTARANGE_COMP,
 cr_returned_date_sk ENCODING DELTARANGE_COMP,
 cr_returned_time_sk ENCODING DELTAVAL,
 cr_refunded_customer_sk ENCODING DELTAVAL,
 cr_refunded_cdemo_sk ENCODING DELTAVAL,
 cr_refunded_hdemo_sk ENCODING DELTAVAL,
 cr_refunded_addr_sk ENCODING DELTAVAL,
 cr_returning_customer_sk ENCODING DELTAVAL,
 cr_returning_cdemo_sk ENCODING DELTAVAL,
 cr_returning_hdemo_sk ENCODING DELTAVAL,
 cr_returning_addr_sk ENCODING DELTAVAL,
 cr_call_center_sk ENCODING RLE,
 cr_catalog_page_sk ENCODING DELTARANGE_COMP,
 cr_ship_mode_sk ENCODING RLE,
 cr_warehouse_sk ENCODING RLE,
 cr_reason_sk ENCODING RLE,
 cr_return_quantity ENCODING BLOCKDICT_COMP,
 cr_return_amount ENCODING DELTARANGE_COMP,
 cr_return_tax ENCODING DELTARANGE_COMP,
 cr_return_amt_inc_tax ENCODING DELTARANGE_COMP,
 cr_fee ENCODING DELTAVAL,
 cr_return_ship_cost ENCODING DELTARANGE_COMP,
 cr_refunded_cash ENCODING DELTARANGE_COMP,
 cr_reversed_charge ENCODING DELTARANGE_COMP,
 cr_store_credit ENCODING DELTARANGE_COMP,
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_returns.cr_item_sk,
        catalog_returns.cr_order_number,
        catalog_returns.cr_returned_date_sk,
        catalog_returns.cr_returned_time_sk,
        catalog_returns.cr_refunded_customer_sk,
        catalog_returns.cr_refunded_cdemo_sk,
        catalog_returns.cr_refunded_hdemo_sk,
        catalog_returns.cr_refunded_addr_sk,
        catalog_returns.cr_returning_customer_sk,
        catalog_returns.cr_returning_cdemo_sk,
        catalog_returns.cr_returning_hdemo_sk,
        catalog_returns.cr_returning_addr_sk,
        catalog_returns.cr_call_center_sk,
        catalog_returns.cr_catalog_page_sk,
        catalog_returns.cr_ship_mode_sk,
        catalog_returns.cr_warehouse_sk,
        catalog_returns.cr_reason_sk,
        catalog_returns.cr_return_quantity,
        catalog_returns.cr_return_amount,
        catalog_returns.cr_return_tax,
        catalog_returns.cr_return_amt_inc_tax,
        catalog_returns.cr_fee,
        catalog_returns.cr_return_ship_cost,
        catalog_returns.cr_refunded_cash,
        catalog_returns.cr_reversed_charge,
        catalog_returns.cr_store_credit,
        catalog_returns.cr_net_loss
 FROM tpcds.catalog_returns
 ORDER BY catalog_returns.cr_warehouse_sk,
          catalog_returns.cr_ship_mode_sk,
          catalog_returns.cr_call_center_sk,
          catalog_returns.cr_reason_sk,
          catalog_returns.cr_order_number
SEGMENTED BY hash(catalog_returns.cr_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_4_seg_MC_TPCDS_COMP_b0 /*+basename(catalog_sales_DBD_4_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 cs_item_sk ENCODING DELTAVAL,
 cs_order_number ENCODING DELTAVAL,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_sold_time_sk ENCODING DELTAVAL,
 cs_ship_date_sk ENCODING DELTAVAL,
 cs_bill_customer_sk ENCODING DELTAVAL,
 cs_bill_cdemo_sk ENCODING DELTAVAL,
 cs_bill_hdemo_sk ENCODING DELTAVAL,
 cs_bill_addr_sk ENCODING DELTAVAL,
 cs_ship_customer_sk ENCODING DELTAVAL,
 cs_ship_cdemo_sk ENCODING DELTAVAL,
 cs_ship_hdemo_sk ENCODING DELTAVAL,
 cs_ship_addr_sk ENCODING DELTAVAL,
 cs_call_center_sk ENCODING RLE,
 cs_catalog_page_sk ENCODING ZSTD_FAST_COMP,
 cs_ship_mode_sk ENCODING RLE,
 cs_warehouse_sk ENCODING RLE,
 cs_promo_sk ENCODING DELTAVAL,
 cs_quantity ENCODING RLE,
 cs_wholesale_cost ENCODING DELTAVAL,
 cs_list_price ENCODING DELTAVAL,
 cs_sales_price ENCODING DELTAVAL,
 cs_ext_discount_amt ENCODING DELTARANGE_COMP,
 cs_ext_sales_price ENCODING DELTARANGE_COMP,
 cs_ext_wholesale_cost ENCODING DELTAVAL,
 cs_ext_list_price ENCODING DELTAVAL,
 cs_ext_tax ENCODING DELTARANGE_COMP,
 cs_coupon_amt ENCODING DELTARANGE_COMP,
 cs_ext_ship_cost ENCODING DELTARANGE_COMP,
 cs_net_paid ENCODING DELTARANGE_COMP,
 cs_net_paid_inc_tax ENCODING DELTARANGE_COMP,
 cs_net_paid_inc_ship ENCODING DELTARANGE_COMP,
 cs_net_paid_inc_ship_tax ENCODING DELTARANGE_COMP,
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_order_number,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_sold_time_sk,
        catalog_sales.cs_ship_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_bill_cdemo_sk,
        catalog_sales.cs_bill_hdemo_sk,
        catalog_sales.cs_bill_addr_sk,
        catalog_sales.cs_ship_customer_sk,
        catalog_sales.cs_ship_cdemo_sk,
        catalog_sales.cs_ship_hdemo_sk,
        catalog_sales.cs_ship_addr_sk,
        catalog_sales.cs_call_center_sk,
        catalog_sales.cs_catalog_page_sk,
        catalog_sales.cs_ship_mode_sk,
        catalog_sales.cs_warehouse_sk,
        catalog_sales.cs_promo_sk,
        catalog_sales.cs_quantity,
        catalog_sales.cs_wholesale_cost,
        catalog_sales.cs_list_price,
        catalog_sales.cs_sales_price,
        catalog_sales.cs_ext_discount_amt,
        catalog_sales.cs_ext_sales_price,
        catalog_sales.cs_ext_wholesale_cost,
        catalog_sales.cs_ext_list_price,
        catalog_sales.cs_ext_tax,
        catalog_sales.cs_coupon_amt,
        catalog_sales.cs_ext_ship_cost,
        catalog_sales.cs_net_paid,
        catalog_sales.cs_net_paid_inc_tax,
        catalog_sales.cs_net_paid_inc_ship,
        catalog_sales.cs_net_paid_inc_ship_tax,
        catalog_sales.cs_net_profit
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_warehouse_sk,
          catalog_sales.cs_ship_mode_sk,
          catalog_sales.cs_call_center_sk,
          catalog_sales.cs_quantity,
          catalog_sales.cs_coupon_amt
SEGMENTED BY hash(catalog_sales.cs_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_4_seg_MC_TPCDS_COMP_b1 /*+basename(catalog_sales_DBD_4_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 cs_item_sk ENCODING DELTAVAL,
 cs_order_number ENCODING DELTAVAL,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_sold_time_sk ENCODING DELTAVAL,
 cs_ship_date_sk ENCODING DELTAVAL,
 cs_bill_customer_sk ENCODING DELTAVAL,
 cs_bill_cdemo_sk ENCODING DELTAVAL,
 cs_bill_hdemo_sk ENCODING DELTAVAL,
 cs_bill_addr_sk ENCODING DELTAVAL,
 cs_ship_customer_sk ENCODING DELTAVAL,
 cs_ship_cdemo_sk ENCODING DELTAVAL,
 cs_ship_hdemo_sk ENCODING DELTAVAL,
 cs_ship_addr_sk ENCODING DELTAVAL,
 cs_call_center_sk ENCODING RLE,
 cs_catalog_page_sk ENCODING ZSTD_FAST_COMP,
 cs_ship_mode_sk ENCODING RLE,
 cs_warehouse_sk ENCODING RLE,
 cs_promo_sk ENCODING DELTAVAL,
 cs_quantity ENCODING RLE,
 cs_wholesale_cost ENCODING DELTAVAL,
 cs_list_price ENCODING DELTAVAL,
 cs_sales_price ENCODING DELTAVAL,
 cs_ext_discount_amt ENCODING DELTARANGE_COMP,
 cs_ext_sales_price ENCODING DELTARANGE_COMP,
 cs_ext_wholesale_cost ENCODING DELTAVAL,
 cs_ext_list_price ENCODING DELTAVAL,
 cs_ext_tax ENCODING DELTARANGE_COMP,
 cs_coupon_amt ENCODING DELTARANGE_COMP,
 cs_ext_ship_cost ENCODING DELTARANGE_COMP,
 cs_net_paid ENCODING DELTARANGE_COMP,
 cs_net_paid_inc_tax ENCODING DELTARANGE_COMP,
 cs_net_paid_inc_ship ENCODING DELTARANGE_COMP,
 cs_net_paid_inc_ship_tax ENCODING DELTARANGE_COMP,
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_order_number,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_sold_time_sk,
        catalog_sales.cs_ship_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_bill_cdemo_sk,
        catalog_sales.cs_bill_hdemo_sk,
        catalog_sales.cs_bill_addr_sk,
        catalog_sales.cs_ship_customer_sk,
        catalog_sales.cs_ship_cdemo_sk,
        catalog_sales.cs_ship_hdemo_sk,
        catalog_sales.cs_ship_addr_sk,
        catalog_sales.cs_call_center_sk,
        catalog_sales.cs_catalog_page_sk,
        catalog_sales.cs_ship_mode_sk,
        catalog_sales.cs_warehouse_sk,
        catalog_sales.cs_promo_sk,
        catalog_sales.cs_quantity,
        catalog_sales.cs_wholesale_cost,
        catalog_sales.cs_list_price,
        catalog_sales.cs_sales_price,
        catalog_sales.cs_ext_discount_amt,
        catalog_sales.cs_ext_sales_price,
        catalog_sales.cs_ext_wholesale_cost,
        catalog_sales.cs_ext_list_price,
        catalog_sales.cs_ext_tax,
        catalog_sales.cs_coupon_amt,
        catalog_sales.cs_ext_ship_cost,
        catalog_sales.cs_net_paid,
        catalog_sales.cs_net_paid_inc_tax,
        catalog_sales.cs_net_paid_inc_ship,
        catalog_sales.cs_net_paid_inc_ship_tax,
        catalog_sales.cs_net_profit
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_warehouse_sk,
          catalog_sales.cs_ship_mode_sk,
          catalog_sales.cs_call_center_sk,
          catalog_sales.cs_quantity,
          catalog_sales.cs_coupon_amt
SEGMENTED BY hash(catalog_sales.cs_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 ca_address_sk ENCODING COMMONDELTA_COMP,
 ca_state ENCODING RLE
)
AS
 SELECT customer_address.ca_address_sk,
        customer_address.ca_state
 FROM tpcds.customer_address
 ORDER BY customer_address.ca_state,
          customer_address.ca_address_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

