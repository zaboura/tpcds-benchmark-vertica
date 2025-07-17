
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_address_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_address_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_state ENCODING ZSTD_FAST_COMP, 
 ca_country ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state, 
        ca_country
 FROM tpcds.customer_address 
 ORDER BY ca_country,
          ca_address_sk
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.customer_address_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_address_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_state ENCODING ZSTD_FAST_COMP, 
 ca_country ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state, 
        ca_country
 FROM tpcds.customer_address 
 ORDER BY ca_country,
          ca_address_sk
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_demographics_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_marital_status,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.customer_demographics_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_marital_status,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.reason_DBD_14_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 r_reason_sk ENCODING COMMONDELTA_COMP,
 r_reason_id ENCODING ZSTD_FAST_COMP,
 r_reason_desc ENCODING ZSTD_FAST_COMP
)
AS
 SELECT reason.r_reason_sk,
        reason.r_reason_id,
        reason.r_reason_desc
 FROM tpcds.reason
 ORDER BY reason.r_reason_id
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_returns_DBD_22_seg_MC_TPCDS_COMP_b0 /*+basename(web_returns_DBD_22_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 wr_item_sk ENCODING DELTAVAL,
 wr_order_number ENCODING DELTARANGE_COMP,
 wr_returned_date_sk ENCODING DELTAVAL,
 wr_returned_time_sk ENCODING DELTAVAL,
 wr_refunded_customer_sk ENCODING DELTAVAL,
 wr_refunded_cdemo_sk ENCODING DELTAVAL,
 wr_refunded_hdemo_sk ENCODING DELTAVAL,
 wr_refunded_addr_sk ENCODING DELTAVAL,
 wr_returning_customer_sk ENCODING DELTAVAL,
 wr_returning_cdemo_sk ENCODING DELTAVAL,
 wr_returning_hdemo_sk ENCODING DELTAVAL,
 wr_returning_addr_sk ENCODING DELTAVAL,
 wr_web_page_sk ENCODING DELTAVAL,
 wr_reason_sk ENCODING RLE,
 wr_return_quantity ENCODING RLE,
 wr_return_amt ENCODING DELTAVAL,
 wr_return_tax ENCODING ZSTD_FAST_COMP,
 wr_return_amt_inc_tax ENCODING DELTAVAL,
 wr_fee ENCODING DELTAVAL,
 wr_return_ship_cost ENCODING DELTAVAL,
 wr_refunded_cash ENCODING DELTARANGE_COMP,
 wr_reversed_charge ENCODING DELTARANGE_COMP,
 wr_account_credit ENCODING DELTARANGE_COMP,
 wr_net_loss ENCODING DELTAVAL
)
AS
 SELECT web_returns.wr_item_sk,
        web_returns.wr_order_number,
        web_returns.wr_returned_date_sk,
        web_returns.wr_returned_time_sk,
        web_returns.wr_refunded_customer_sk,
        web_returns.wr_refunded_cdemo_sk,
        web_returns.wr_refunded_hdemo_sk,
        web_returns.wr_refunded_addr_sk,
        web_returns.wr_returning_customer_sk,
        web_returns.wr_returning_cdemo_sk,
        web_returns.wr_returning_hdemo_sk,
        web_returns.wr_returning_addr_sk,
        web_returns.wr_web_page_sk,
        web_returns.wr_reason_sk,
        web_returns.wr_return_quantity,
        web_returns.wr_return_amt,
        web_returns.wr_return_tax,
        web_returns.wr_return_amt_inc_tax,
        web_returns.wr_fee,
        web_returns.wr_return_ship_cost,
        web_returns.wr_refunded_cash,
        web_returns.wr_reversed_charge,
        web_returns.wr_account_credit,
        web_returns.wr_net_loss
 FROM tpcds.web_returns
 ORDER BY web_returns.wr_reason_sk,
          web_returns.wr_return_quantity,
          web_returns.wr_order_number
SEGMENTED BY hash(web_returns.wr_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_returns_DBD_22_seg_MC_TPCDS_COMP_b1 /*+basename(web_returns_DBD_22_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 wr_item_sk ENCODING DELTAVAL,
 wr_order_number ENCODING DELTARANGE_COMP,
 wr_returned_date_sk ENCODING DELTAVAL,
 wr_returned_time_sk ENCODING DELTAVAL,
 wr_refunded_customer_sk ENCODING DELTAVAL,
 wr_refunded_cdemo_sk ENCODING DELTAVAL,
 wr_refunded_hdemo_sk ENCODING DELTAVAL,
 wr_refunded_addr_sk ENCODING DELTAVAL,
 wr_returning_customer_sk ENCODING DELTAVAL,
 wr_returning_cdemo_sk ENCODING DELTAVAL,
 wr_returning_hdemo_sk ENCODING DELTAVAL,
 wr_returning_addr_sk ENCODING DELTAVAL,
 wr_web_page_sk ENCODING DELTAVAL,
 wr_reason_sk ENCODING RLE,
 wr_return_quantity ENCODING RLE,
 wr_return_amt ENCODING DELTAVAL,
 wr_return_tax ENCODING ZSTD_FAST_COMP,
 wr_return_amt_inc_tax ENCODING DELTAVAL,
 wr_fee ENCODING DELTAVAL,
 wr_return_ship_cost ENCODING DELTAVAL,
 wr_refunded_cash ENCODING DELTARANGE_COMP,
 wr_reversed_charge ENCODING DELTARANGE_COMP,
 wr_account_credit ENCODING DELTARANGE_COMP,
 wr_net_loss ENCODING DELTAVAL
)
AS
 SELECT web_returns.wr_item_sk,
        web_returns.wr_order_number,
        web_returns.wr_returned_date_sk,
        web_returns.wr_returned_time_sk,
        web_returns.wr_refunded_customer_sk,
        web_returns.wr_refunded_cdemo_sk,
        web_returns.wr_refunded_hdemo_sk,
        web_returns.wr_refunded_addr_sk,
        web_returns.wr_returning_customer_sk,
        web_returns.wr_returning_cdemo_sk,
        web_returns.wr_returning_hdemo_sk,
        web_returns.wr_returning_addr_sk,
        web_returns.wr_web_page_sk,
        web_returns.wr_reason_sk,
        web_returns.wr_return_quantity,
        web_returns.wr_return_amt,
        web_returns.wr_return_tax,
        web_returns.wr_return_amt_inc_tax,
        web_returns.wr_fee,
        web_returns.wr_return_ship_cost,
        web_returns.wr_refunded_cash,
        web_returns.wr_reversed_charge,
        web_returns.wr_account_credit,
        web_returns.wr_net_loss
 FROM tpcds.web_returns
 ORDER BY web_returns.wr_reason_sk,
          web_returns.wr_return_quantity,
          web_returns.wr_order_number
SEGMENTED BY hash(web_returns.wr_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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

CREATE PROJECTION tpcds.web_page_DBD_3_rep_DBD_TPCDS_INC3 /*+createtype(D)*/ 
(
 wp_web_page_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT web_page.wp_web_page_sk
 FROM tpcds.web_page
 ORDER BY web_page.wp_web_page_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

