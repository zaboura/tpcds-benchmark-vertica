
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC2_v3 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_gmt_offset ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_gmt_offset
 FROM tpcds.customer_address 
 ORDER BY ca_gmt_offset,
          ca_address_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.promotion_DBD_13_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 p_promo_sk ENCODING COMMONDELTA_COMP,
 p_promo_id ENCODING ZSTD_FAST_COMP,
 p_start_date_sk ENCODING DELTAVAL,
 p_end_date_sk ENCODING DELTAVAL,
 p_item_sk ENCODING DELTAVAL,
 p_cost ENCODING RLE,
 p_response_target ENCODING RLE,
 p_promo_name ENCODING ZSTD_FAST_COMP,
 p_channel_dmail ENCODING ZSTD_FAST_COMP,
 p_channel_email ENCODING RLE,
 p_channel_catalog ENCODING RLE,
 p_channel_tv ENCODING RLE,
 p_channel_radio ENCODING RLE,
 p_channel_press ENCODING RLE,
 p_channel_event,
 p_channel_demo,
 p_channel_details ENCODING ZSTD_FAST_COMP,
 p_purpose ENCODING ZSTD_FAST_COMP,
 p_discount_active
)
AS
 SELECT promotion.p_promo_sk,
        promotion.p_promo_id,
        promotion.p_start_date_sk,
        promotion.p_end_date_sk,
        promotion.p_item_sk,
        promotion.p_cost,
        promotion.p_response_target,
        promotion.p_promo_name,
        promotion.p_channel_dmail,
        promotion.p_channel_email,
        promotion.p_channel_catalog,
        promotion.p_channel_tv,
        promotion.p_channel_radio,
        promotion.p_channel_press,
        promotion.p_channel_event,
        promotion.p_channel_demo,
        promotion.p_channel_details,
        promotion.p_purpose,
        promotion.p_discount_active
 FROM tpcds.promotion
 ORDER BY promotion.p_cost,
          promotion.p_response_target,
          promotion.p_channel_email,
          promotion.p_channel_catalog,
          promotion.p_channel_tv,
          promotion.p_channel_radio,
          promotion.p_channel_press,
          promotion.p_promo_id
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

CREATE PROJECTION tpcds.item_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_current_price ENCODING DELTARANGE_COMP,
 i_category ENCODING RLE
)
AS
 SELECT item.i_item_sk,
        item.i_current_price,
        item.i_category
 FROM tpcds.item
 ORDER BY item.i_category,
          item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 c_customer_sk ENCODING DELTAVAL,
 c_current_addr_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT customer.c_customer_sk,
        customer.c_current_addr_sk
 FROM tpcds.customer
 ORDER BY customer.c_current_addr_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/ 
(
 ss_item_sk ENCODING GCDDELTA,
 ss_sold_date_sk ENCODING RLE,
 ss_customer_sk ENCODING DELTAVAL,
 ss_store_sk ENCODING RLE,
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_customer_sk,
        store_sales.ss_store_sk,
        store_sales.ss_ext_sales_price
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_sold_date_sk,
          store_sales.ss_store_sk,
          store_sales.ss_customer_sk,
          store_sales.ss_ext_sales_price
SEGMENTED BY hash(store_sales.ss_sold_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/ 
(
 ss_item_sk ENCODING GCDDELTA,
 ss_sold_date_sk ENCODING RLE,
 ss_customer_sk ENCODING DELTAVAL,
 ss_store_sk ENCODING RLE,
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_customer_sk,
        store_sales.ss_store_sk,
        store_sales.ss_ext_sales_price
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_sold_date_sk,
          store_sales.ss_store_sk,
          store_sales.ss_customer_sk,
          store_sales.ss_ext_sales_price
SEGMENTED BY hash(store_sales.ss_sold_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_DBD_3_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 s_store_sk ENCODING DELTAVAL,
 s_store_id ENCODING ZSTD_FAST_COMP,
 s_store_name ENCODING RLE,
 s_gmt_offset ENCODING RLE
)
AS
 SELECT store.s_store_sk,
        store.s_store_id,
        store.s_store_name,
        store.s_gmt_offset
 FROM tpcds.store
 ORDER BY store.s_gmt_offset,
          store.s_store_name,
          store.s_store_id
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

