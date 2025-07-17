

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v3_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v3),createtype(D)*/
(
 ss_item_sk ENCODING AUTO, 
 ss_ticket_number ENCODING AUTO, 
 ss_sold_date_sk ENCODING AUTO, 
 ss_sold_time_sk ENCODING AUTO, 
 ss_customer_sk ENCODING AUTO, 
 ss_cdemo_sk ENCODING AUTO, 
 ss_hdemo_sk ENCODING AUTO, 
 ss_addr_sk ENCODING AUTO, 
 ss_store_sk ENCODING AUTO, 
 ss_promo_sk ENCODING AUTO, 
 ss_quantity ENCODING AUTO, 
 ss_wholesale_cost ENCODING AUTO, 
 ss_list_price ENCODING AUTO, 
 ss_sales_price ENCODING AUTO, 
 ss_ext_discount_amt ENCODING AUTO, 
 ss_ext_sales_price ENCODING AUTO, 
 ss_ext_wholesale_cost ENCODING AUTO, 
 ss_ext_list_price ENCODING AUTO, 
 ss_ext_tax ENCODING AUTO, 
 ss_coupon_amt ENCODING AUTO, 
 ss_net_paid ENCODING AUTO, 
 ss_net_paid_inc_tax ENCODING AUTO, 
 ss_net_profit ENCODING AUTO
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_customer_sk, 
        ss_cdemo_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_promo_sk, 
        ss_quantity, 
        ss_wholesale_cost, 
        ss_list_price, 
        ss_sales_price, 
        ss_ext_discount_amt, 
        ss_ext_sales_price, 
        ss_ext_wholesale_cost, 
        ss_ext_list_price, 
        ss_ext_tax, 
        ss_coupon_amt, 
        ss_net_paid, 
        ss_net_paid_inc_tax, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_item_sk,
          ss_ticket_number,
          ss_sold_date_sk,
          ss_store_sk
SEGMENTED BY HASH (ss_customer_sk, ss_item_sk, ss_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_merge_b1 /*+basename(store_sales_merge),createtype(D)*/ 
(
 ss_item_sk,
 ss_ticket_number,
 ss_sold_date_sk,
 ss_sold_time_sk,
 ss_customer_sk,
 ss_cdemo_sk,
 ss_hdemo_sk,
 ss_addr_sk,
 ss_store_sk,
 ss_promo_sk,
 ss_quantity,
 ss_wholesale_cost,
 ss_list_price,
 ss_sales_price,
 ss_ext_discount_amt,
 ss_ext_sales_price,
 ss_ext_wholesale_cost,
 ss_ext_list_price,
 ss_ext_tax,
 ss_coupon_amt,
 ss_net_paid,
 ss_net_paid_inc_tax,
 ss_net_profit
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_ticket_number,
        store_sales.ss_sold_date_sk,
        store_sales.ss_sold_time_sk,
        store_sales.ss_customer_sk,
        store_sales.ss_cdemo_sk,
        store_sales.ss_hdemo_sk,
        store_sales.ss_addr_sk,
        store_sales.ss_store_sk,
        store_sales.ss_promo_sk,
        store_sales.ss_quantity,
        store_sales.ss_wholesale_cost,
        store_sales.ss_list_price,
        store_sales.ss_sales_price,
        store_sales.ss_ext_discount_amt,
        store_sales.ss_ext_sales_price,
        store_sales.ss_ext_wholesale_cost,
        store_sales.ss_ext_list_price,
        store_sales.ss_ext_tax,
        store_sales.ss_coupon_amt,
        store_sales.ss_net_paid,
        store_sales.ss_net_paid_inc_tax,
        store_sales.ss_net_profit
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_customer_sk,
          store_sales.ss_item_sk,
          store_sales.ss_ticket_number,
          store_sales.ss_sold_date_sk,
          store_sales.ss_store_sk
SEGMENTED BY hash(store_sales.ss_customer_sk, store_sales.ss_item_sk, store_sales.ss_ticket_number) ALL NODES OFFSET 1;



select refresh('tpcds.store_sales');