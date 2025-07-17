
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.web_sales_DBD_1_seg_DBD_TPCDS_INC4_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC4),createtype(D)*/
(
 ws_order_number ENCODING DELTAVAL, 
 ws_ship_date_sk ENCODING RLE, 
 ws_ship_addr_sk ENCODING DELTAVAL, 
 ws_web_site_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE, 
 ws_ext_ship_cost ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_order_number, 
        ws_ship_date_sk, 
        ws_ship_addr_sk, 
        ws_web_site_sk, 
        ws_warehouse_sk, 
        ws_ext_ship_cost, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_ship_date_sk,
          ws_web_site_sk,
          ws_warehouse_sk,
          ws_order_number,
          ws_ext_ship_cost
SEGMENTED BY MODULARHASH (ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_1_seg_DBD_TPCDS_INC4_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC4),createtype(D)*/
(
 ws_order_number ENCODING DELTAVAL, 
 ws_ship_date_sk ENCODING RLE, 
 ws_ship_addr_sk ENCODING DELTAVAL, 
 ws_web_site_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE, 
 ws_ext_ship_cost ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_order_number, 
        ws_ship_date_sk, 
        ws_ship_addr_sk, 
        ws_web_site_sk, 
        ws_warehouse_sk, 
        ws_ext_ship_cost, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_ship_date_sk,
          ws_web_site_sk,
          ws_warehouse_sk,
          ws_order_number,
          ws_ext_ship_cost
SEGMENTED BY MODULARHASH (ws_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_site_DBD_2_rep_DBD_TPCDS_INC4 /*+createtype(D)*/
(
 web_site_sk ENCODING AUTO, 
 web_company_name ENCODING AUTO
)
AS
 SELECT web_site_sk, 
        web_company_name
 FROM tpcds.web_site 
 ORDER BY web_company_name,
          web_site_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_sales_DBD_23_seg_MC_TPCDS_COMP_b0 /*+basename(web_sales_DBD_23_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTAVAL,
 ws_order_number ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING DELTAVAL,
 ws_sold_time_sk ENCODING DELTAVAL,
 ws_ship_date_sk ENCODING DELTAVAL,
 ws_bill_customer_sk ENCODING DELTAVAL,
 ws_bill_cdemo_sk ENCODING DELTAVAL,
 ws_bill_hdemo_sk ENCODING DELTAVAL,
 ws_bill_addr_sk ENCODING DELTAVAL,
 ws_ship_customer_sk ENCODING DELTAVAL,
 ws_ship_cdemo_sk ENCODING DELTAVAL,
 ws_ship_hdemo_sk ENCODING DELTAVAL,
 ws_ship_addr_sk ENCODING DELTAVAL,
 ws_web_page_sk ENCODING DELTAVAL,
 ws_web_site_sk ENCODING RLE,
 ws_ship_mode_sk ENCODING RLE,
 ws_warehouse_sk ENCODING RLE,
 ws_promo_sk ENCODING DELTAVAL,
 ws_quantity ENCODING RLE,
 ws_wholesale_cost ENCODING DELTAVAL,
 ws_list_price ENCODING DELTAVAL,
 ws_sales_price ENCODING DELTAVAL,
 ws_ext_discount_amt ENCODING DELTARANGE_COMP,
 ws_ext_sales_price ENCODING DELTARANGE_COMP,
 ws_ext_wholesale_cost ENCODING DELTAVAL,
 ws_ext_list_price ENCODING DELTAVAL,
 ws_ext_tax ENCODING DELTARANGE_COMP,
 ws_coupon_amt ENCODING DELTARANGE_COMP,
 ws_ext_ship_cost ENCODING DELTARANGE_COMP,
 ws_net_paid ENCODING DELTARANGE_COMP,
 ws_net_paid_inc_tax ENCODING DELTARANGE_COMP,
 ws_net_paid_inc_ship ENCODING DELTARANGE_COMP,
 ws_net_paid_inc_ship_tax ENCODING DELTARANGE_COMP,
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_order_number,
        web_sales.ws_sold_date_sk,
        web_sales.ws_sold_time_sk,
        web_sales.ws_ship_date_sk,
        web_sales.ws_bill_customer_sk,
        web_sales.ws_bill_cdemo_sk,
        web_sales.ws_bill_hdemo_sk,
        web_sales.ws_bill_addr_sk,
        web_sales.ws_ship_customer_sk,
        web_sales.ws_ship_cdemo_sk,
        web_sales.ws_ship_hdemo_sk,
        web_sales.ws_ship_addr_sk,
        web_sales.ws_web_page_sk,
        web_sales.ws_web_site_sk,
        web_sales.ws_ship_mode_sk,
        web_sales.ws_warehouse_sk,
        web_sales.ws_promo_sk,
        web_sales.ws_quantity,
        web_sales.ws_wholesale_cost,
        web_sales.ws_list_price,
        web_sales.ws_sales_price,
        web_sales.ws_ext_discount_amt,
        web_sales.ws_ext_sales_price,
        web_sales.ws_ext_wholesale_cost,
        web_sales.ws_ext_list_price,
        web_sales.ws_ext_tax,
        web_sales.ws_coupon_amt,
        web_sales.ws_ext_ship_cost,
        web_sales.ws_net_paid,
        web_sales.ws_net_paid_inc_tax,
        web_sales.ws_net_paid_inc_ship,
        web_sales.ws_net_paid_inc_ship_tax,
        web_sales.ws_net_profit
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_warehouse_sk,
          web_sales.ws_ship_mode_sk,
          web_sales.ws_web_site_sk,
          web_sales.ws_quantity,
          web_sales.ws_coupon_amt
SEGMENTED BY hash(web_sales.ws_net_paid_inc_tax) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_23_seg_MC_TPCDS_COMP_b1 /*+basename(web_sales_DBD_23_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTAVAL,
 ws_order_number ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING DELTAVAL,
 ws_sold_time_sk ENCODING DELTAVAL,
 ws_ship_date_sk ENCODING DELTAVAL,
 ws_bill_customer_sk ENCODING DELTAVAL,
 ws_bill_cdemo_sk ENCODING DELTAVAL,
 ws_bill_hdemo_sk ENCODING DELTAVAL,
 ws_bill_addr_sk ENCODING DELTAVAL,
 ws_ship_customer_sk ENCODING DELTAVAL,
 ws_ship_cdemo_sk ENCODING DELTAVAL,
 ws_ship_hdemo_sk ENCODING DELTAVAL,
 ws_ship_addr_sk ENCODING DELTAVAL,
 ws_web_page_sk ENCODING DELTAVAL,
 ws_web_site_sk ENCODING RLE,
 ws_ship_mode_sk ENCODING RLE,
 ws_warehouse_sk ENCODING RLE,
 ws_promo_sk ENCODING DELTAVAL,
 ws_quantity ENCODING RLE,
 ws_wholesale_cost ENCODING DELTAVAL,
 ws_list_price ENCODING DELTAVAL,
 ws_sales_price ENCODING DELTAVAL,
 ws_ext_discount_amt ENCODING DELTARANGE_COMP,
 ws_ext_sales_price ENCODING DELTARANGE_COMP,
 ws_ext_wholesale_cost ENCODING DELTAVAL,
 ws_ext_list_price ENCODING DELTAVAL,
 ws_ext_tax ENCODING DELTARANGE_COMP,
 ws_coupon_amt ENCODING DELTARANGE_COMP,
 ws_ext_ship_cost ENCODING DELTARANGE_COMP,
 ws_net_paid ENCODING DELTARANGE_COMP,
 ws_net_paid_inc_tax ENCODING DELTARANGE_COMP,
 ws_net_paid_inc_ship ENCODING DELTARANGE_COMP,
 ws_net_paid_inc_ship_tax ENCODING DELTARANGE_COMP,
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_order_number,
        web_sales.ws_sold_date_sk,
        web_sales.ws_sold_time_sk,
        web_sales.ws_ship_date_sk,
        web_sales.ws_bill_customer_sk,
        web_sales.ws_bill_cdemo_sk,
        web_sales.ws_bill_hdemo_sk,
        web_sales.ws_bill_addr_sk,
        web_sales.ws_ship_customer_sk,
        web_sales.ws_ship_cdemo_sk,
        web_sales.ws_ship_hdemo_sk,
        web_sales.ws_ship_addr_sk,
        web_sales.ws_web_page_sk,
        web_sales.ws_web_site_sk,
        web_sales.ws_ship_mode_sk,
        web_sales.ws_warehouse_sk,
        web_sales.ws_promo_sk,
        web_sales.ws_quantity,
        web_sales.ws_wholesale_cost,
        web_sales.ws_list_price,
        web_sales.ws_sales_price,
        web_sales.ws_ext_discount_amt,
        web_sales.ws_ext_sales_price,
        web_sales.ws_ext_wholesale_cost,
        web_sales.ws_ext_list_price,
        web_sales.ws_ext_tax,
        web_sales.ws_coupon_amt,
        web_sales.ws_ext_ship_cost,
        web_sales.ws_net_paid,
        web_sales.ws_net_paid_inc_tax,
        web_sales.ws_net_paid_inc_ship,
        web_sales.ws_net_paid_inc_ship_tax,
        web_sales.ws_net_profit
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_warehouse_sk,
          web_sales.ws_ship_mode_sk,
          web_sales.ws_web_site_sk,
          web_sales.ws_quantity,
          web_sales.ws_coupon_amt
SEGMENTED BY hash(web_sales.ws_net_paid_inc_tax) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date_sk
SEGMENTED BY hash(date_dim.d_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date_sk
SEGMENTED BY hash(date_dim.d_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

