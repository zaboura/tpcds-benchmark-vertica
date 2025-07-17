
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_dom ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_dom
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_dom,
          d_date_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.store_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_county ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_county
 FROM tpcds.store 
 ORDER BY s_county,
          s_store_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_DBD_7_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 c_customer_sk ENCODING DELTARANGE_COMP,
 c_customer_id ENCODING ZSTD_FAST_COMP,
 c_current_cdemo_sk ENCODING DELTAVAL,
 c_current_hdemo_sk ENCODING DELTAVAL,
 c_current_addr_sk ENCODING DELTAVAL,
 c_first_shipto_date_sk ENCODING DELTAVAL,
 c_first_sales_date_sk ENCODING DELTAVAL,
 c_salutation ENCODING RLE,
 c_first_name ENCODING ZSTD_FAST_COMP,
 c_last_name ENCODING ZSTD_FAST_COMP,
 c_preferred_cust_flag ENCODING RLE,
 c_birth_day ENCODING RLE,
 c_birth_month ENCODING RLE,
 c_birth_year ENCODING BLOCKDICT_COMP,
 c_birth_country ENCODING ZSTD_FAST_COMP,
 c_login ENCODING RLE,
 c_email_address ENCODING ZSTD_FAST_COMP,
 c_last_review_date ENCODING ZSTD_FAST_COMP
)
AS
 SELECT customer.c_customer_sk,
        customer.c_customer_id,
        customer.c_current_cdemo_sk,
        customer.c_current_hdemo_sk,
        customer.c_current_addr_sk,
        customer.c_first_shipto_date_sk,
        customer.c_first_sales_date_sk,
        customer.c_salutation,
        customer.c_first_name,
        customer.c_last_name,
        customer.c_preferred_cust_flag,
        customer.c_birth_day,
        customer.c_birth_month,
        customer.c_birth_year,
        customer.c_birth_country,
        customer.c_login,
        customer.c_email_address,
        customer.c_last_review_date
 FROM tpcds.customer
 ORDER BY customer.c_login,
          customer.c_preferred_cust_flag,
          customer.c_salutation,
          customer.c_birth_month,
          customer.c_birth_day,
          customer.c_customer_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.household_demographics_DBD_9_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 hd_demo_sk ENCODING COMMONDELTA_COMP,
 hd_income_band_sk ENCODING COMMONDELTA_COMP,
 hd_buy_potential ENCODING RLE,
 hd_dep_count ENCODING RLE,
 hd_vehicle_count ENCODING RLE
)
AS
 SELECT household_demographics.hd_demo_sk,
        household_demographics.hd_income_band_sk,
        household_demographics.hd_buy_potential,
        household_demographics.hd_dep_count,
        household_demographics.hd_vehicle_count
 FROM tpcds.household_demographics
 ORDER BY household_demographics.hd_buy_potential,
          household_demographics.hd_vehicle_count,
          household_demographics.hd_dep_count,
          household_demographics.hd_demo_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_17_seg_MC_TPCDS_COMP_b0 /*+basename(store_sales_DBD_17_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_ticket_number ENCODING DELTARANGE_COMP,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_sold_time_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING DELTAVAL,
 ss_cdemo_sk ENCODING DELTAVAL,
 ss_hdemo_sk ENCODING DELTAVAL,
 ss_addr_sk ENCODING DELTAVAL,
 ss_store_sk ENCODING RLE,
 ss_promo_sk ENCODING RLE,
 ss_quantity ENCODING RLE,
 ss_wholesale_cost ENCODING DELTAVAL,
 ss_list_price ENCODING DELTAVAL,
 ss_sales_price ENCODING DELTAVAL,
 ss_ext_discount_amt ENCODING ZSTD_FAST_COMP,
 ss_ext_sales_price ENCODING DELTAVAL,
 ss_ext_wholesale_cost ENCODING DELTAVAL,
 ss_ext_list_price ENCODING DELTAVAL,
 ss_ext_tax ENCODING ZSTD_FAST_COMP,
 ss_coupon_amt ENCODING ZSTD_FAST_COMP,
 ss_net_paid ENCODING DELTAVAL,
 ss_net_paid_inc_tax ENCODING DELTAVAL,
 ss_net_profit ENCODING DELTAVAL
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
 ORDER BY store_sales.ss_quantity,
          store_sales.ss_store_sk,
          store_sales.ss_promo_sk,
          store_sales.ss_ticket_number,
          store_sales.ss_ext_discount_amt
SEGMENTED BY hash(store_sales.ss_ticket_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_17_seg_MC_TPCDS_COMP_b1 /*+basename(store_sales_DBD_17_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_ticket_number ENCODING DELTARANGE_COMP,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_sold_time_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING DELTAVAL,
 ss_cdemo_sk ENCODING DELTAVAL,
 ss_hdemo_sk ENCODING DELTAVAL,
 ss_addr_sk ENCODING DELTAVAL,
 ss_store_sk ENCODING RLE,
 ss_promo_sk ENCODING RLE,
 ss_quantity ENCODING RLE,
 ss_wholesale_cost ENCODING DELTAVAL,
 ss_list_price ENCODING DELTAVAL,
 ss_sales_price ENCODING DELTAVAL,
 ss_ext_discount_amt ENCODING ZSTD_FAST_COMP,
 ss_ext_sales_price ENCODING DELTAVAL,
 ss_ext_wholesale_cost ENCODING DELTAVAL,
 ss_ext_list_price ENCODING DELTAVAL,
 ss_ext_tax ENCODING ZSTD_FAST_COMP,
 ss_coupon_amt ENCODING ZSTD_FAST_COMP,
 ss_net_paid ENCODING DELTAVAL,
 ss_net_paid_inc_tax ENCODING DELTAVAL,
 ss_net_profit ENCODING DELTAVAL
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
 ORDER BY store_sales.ss_quantity,
          store_sales.ss_store_sk,
          store_sales.ss_promo_sk,
          store_sales.ss_ticket_number,
          store_sales.ss_ext_discount_amt
SEGMENTED BY hash(store_sales.ss_ticket_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

