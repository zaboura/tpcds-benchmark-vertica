
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_v3_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v3),createtype(D)*/
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

CREATE PROJECTION tpcds.item_DBD_12_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_rec_start_date ENCODING RLE,
 i_rec_end_date ENCODING RLE,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING DELTARANGE_COMP,
 i_wholesale_cost ENCODING DELTARANGE_COMP,
 i_brand_id ENCODING BLOCKDICT_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_class_id ENCODING BLOCKDICT_COMP,
 i_class ENCODING ZSTD_FAST_COMP,
 i_category_id ENCODING RLE,
 i_category ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING DELTAVAL,
 i_manufact ENCODING ZSTD_FAST_COMP,
 i_size ENCODING RLE,
 i_formulation ENCODING ZSTD_FAST_COMP,
 i_color ENCODING ZSTD_FAST_COMP,
 i_units ENCODING ZSTD_FAST_COMP,
 i_container ENCODING RLE,
 i_manager_id ENCODING DELTAVAL,
 i_product_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_rec_start_date,
        item.i_rec_end_date,
        item.i_item_desc,
        item.i_current_price,
        item.i_wholesale_cost,
        item.i_brand_id,
        item.i_brand,
        item.i_class_id,
        item.i_class,
        item.i_category_id,
        item.i_category,
        item.i_manufact_id,
        item.i_manufact,
        item.i_size,
        item.i_formulation,
        item.i_color,
        item.i_units,
        item.i_container,
        item.i_manager_id,
        item.i_product_name
 FROM tpcds.item
 ORDER BY item.i_container,
          item.i_rec_end_date,
          item.i_rec_start_date,
          item.i_size,
          item.i_category_id,
          item.i_item_sk
UNSEGMENTED ALL NODES;



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

CREATE PROJECTION tpcds.store_DBD_5_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 s_store_sk ENCODING COMMONDELTA_COMP,
 s_state ENCODING ZSTD_FAST_COMP
)
AS
 SELECT store.s_store_sk,
        store.s_state
 FROM tpcds.store
 ORDER BY store.s_store_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_merge_b1 /*+basename(store_sales_merge),createtype(D)*/ 
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



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_demographics_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 cd_demo_sk ENCODING COMMONDELTA_COMP,
 cd_gender ENCODING RLE,
 cd_marital_status ENCODING RLE,
 cd_education_status ENCODING RLE
)
AS
 SELECT customer_demographics.cd_demo_sk,
        customer_demographics.cd_gender,
        customer_demographics.cd_marital_status,
        customer_demographics.cd_education_status
 FROM tpcds.customer_demographics
 ORDER BY customer_demographics.cd_education_status,
          customer_demographics.cd_gender,
          customer_demographics.cd_marital_status,
          customer_demographics.cd_demo_sk
SEGMENTED BY hash(customer_demographics.cd_demo_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_demographics_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 cd_demo_sk ENCODING COMMONDELTA_COMP,
 cd_gender ENCODING RLE,
 cd_marital_status ENCODING RLE,
 cd_education_status ENCODING RLE
)
AS
 SELECT customer_demographics.cd_demo_sk,
        customer_demographics.cd_gender,
        customer_demographics.cd_marital_status,
        customer_demographics.cd_education_status
 FROM tpcds.customer_demographics
 ORDER BY customer_demographics.cd_education_status,
          customer_demographics.cd_gender,
          customer_demographics.cd_marital_status,
          customer_demographics.cd_demo_sk
SEGMENTED BY hash(customer_demographics.cd_demo_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

