
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC2_v4 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP, 
 d_week_seq ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_date, 
        d_week_seq, 
        d_year
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

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

CREATE PROJECTION tpcds.customer_demographics_DBD_6_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 cd_demo_sk ENCODING COMMONDELTA_COMP,
 cd_gender ENCODING RLE,
 cd_marital_status ENCODING RLE,
 cd_education_status ENCODING RLE,
 cd_purchase_estimate ENCODING COMMONDELTA_COMP,
 cd_credit_rating ENCODING RLE,
 cd_dep_count ENCODING RLE,
 cd_dep_employed_count ENCODING RLE,
 cd_dep_college_count ENCODING RLE
)
AS
 SELECT customer_demographics.cd_demo_sk,
        customer_demographics.cd_gender,
        customer_demographics.cd_marital_status,
        customer_demographics.cd_education_status,
        customer_demographics.cd_purchase_estimate,
        customer_demographics.cd_credit_rating,
        customer_demographics.cd_dep_count,
        customer_demographics.cd_dep_employed_count,
        customer_demographics.cd_dep_college_count
 FROM tpcds.customer_demographics
 ORDER BY customer_demographics.cd_gender,
          customer_demographics.cd_credit_rating,
          customer_demographics.cd_marital_status,
          customer_demographics.cd_education_status,
          customer_demographics.cd_dep_count,
          customer_demographics.cd_dep_employed_count,
          customer_demographics.cd_dep_college_count,
          customer_demographics.cd_demo_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_8_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date_id ENCODING ZSTD_FAST_COMP,
 d_date ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_week_seq ENCODING COMMONDELTA_COMP,
 d_quarter_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING COMMONDELTA_COMP,
 d_dow ENCODING RLE,
 d_moy ENCODING COMMONDELTA_COMP,
 d_dom ENCODING COMMONDELTA_COMP,
 d_qoy ENCODING RLE,
 d_fy_year ENCODING COMMONDELTA_COMP,
 d_fy_quarter_seq ENCODING COMMONDELTA_COMP,
 d_fy_week_seq ENCODING COMMONDELTA_COMP,
 d_day_name ENCODING ZSTD_FAST_COMP,
 d_quarter_name ENCODING ZSTD_FAST_COMP,
 d_holiday ENCODING RLE,
 d_weekend ENCODING RLE,
 d_following_holiday ENCODING RLE,
 d_first_dom ENCODING COMMONDELTA_COMP,
 d_last_dom ENCODING COMMONDELTA_COMP,
 d_same_day_ly ENCODING COMMONDELTA_COMP,
 d_same_day_lq ENCODING COMMONDELTA_COMP,
 d_current_day ENCODING RLE,
 d_current_week ENCODING RLE,
 d_current_month ENCODING RLE,
 d_current_quarter ENCODING RLE,
 d_current_year ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date_id,
        date_dim.d_date,
        date_dim.d_month_seq,
        date_dim.d_week_seq,
        date_dim.d_quarter_seq,
        date_dim.d_year,
        date_dim.d_dow,
        date_dim.d_moy,
        date_dim.d_dom,
        date_dim.d_qoy,
        date_dim.d_fy_year,
        date_dim.d_fy_quarter_seq,
        date_dim.d_fy_week_seq,
        date_dim.d_day_name,
        date_dim.d_quarter_name,
        date_dim.d_holiday,
        date_dim.d_weekend,
        date_dim.d_following_holiday,
        date_dim.d_first_dom,
        date_dim.d_last_dom,
        date_dim.d_same_day_ly,
        date_dim.d_same_day_lq,
        date_dim.d_current_day,
        date_dim.d_current_week,
        date_dim.d_current_month,
        date_dim.d_current_quarter,
        date_dim.d_current_year
 FROM tpcds.date_dim
 ORDER BY date_dim.d_current_day,
          date_dim.d_current_week,
          date_dim.d_holiday,
          date_dim.d_weekend,
          date_dim.d_following_holiday,
          date_dim.d_current_month,
          date_dim.d_current_quarter,
          date_dim.d_current_year,
          date_dim.d_qoy,
          date_dim.d_dow,
          date_dim.d_date
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

CREATE PROJECTION tpcds.inventory_DBD_11_seg_MC_TPCDS_COMP_b0 /*+basename(inventory_DBD_11_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 inv_item_sk ENCODING DELTARANGE_COMP,
 inv_date_sk ENCODING RLE,
 inv_warehouse_sk ENCODING RLE,
 inv_quantity_on_hand ENCODING RLE
)
AS
 SELECT inventory.inv_item_sk,
        inventory.inv_date_sk,
        inventory.inv_warehouse_sk,
        inventory.inv_quantity_on_hand
 FROM tpcds.inventory
 ORDER BY inventory.inv_warehouse_sk,
          inventory.inv_date_sk,
          inventory.inv_quantity_on_hand,
          inventory.inv_item_sk
SEGMENTED BY hash(inventory.inv_item_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.inventory_DBD_11_seg_MC_TPCDS_COMP_b1 /*+basename(inventory_DBD_11_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 inv_item_sk ENCODING DELTARANGE_COMP,
 inv_date_sk ENCODING RLE,
 inv_warehouse_sk ENCODING RLE,
 inv_quantity_on_hand ENCODING RLE
)
AS
 SELECT inventory.inv_item_sk,
        inventory.inv_date_sk,
        inventory.inv_warehouse_sk,
        inventory.inv_quantity_on_hand
 FROM tpcds.inventory
 ORDER BY inventory.inv_warehouse_sk,
          inventory.inv_date_sk,
          inventory.inv_quantity_on_hand,
          inventory.inv_item_sk
SEGMENTED BY hash(inventory.inv_item_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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

CREATE PROJECTION tpcds.warehouse_DBD_20_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 w_warehouse_sk,
 w_warehouse_id,
 w_warehouse_name ENCODING ZSTD_FAST_COMP,
 w_warehouse_sq_ft,
 w_street_number ENCODING ZSTD_FAST_COMP,
 w_street_name ENCODING ZSTD_FAST_COMP,
 w_street_type,
 w_suite_number,
 w_city ENCODING ZSTD_FAST_COMP,
 w_county ENCODING ZSTD_FAST_COMP,
 w_state,
 w_zip ENCODING ZSTD_FAST_COMP,
 w_country ENCODING RLE,
 w_gmt_offset ENCODING BLOCKDICT_COMP
)
AS
 SELECT warehouse.w_warehouse_sk,
        warehouse.w_warehouse_id,
        warehouse.w_warehouse_name,
        warehouse.w_warehouse_sq_ft,
        warehouse.w_street_number,
        warehouse.w_street_name,
        warehouse.w_street_type,
        warehouse.w_suite_number,
        warehouse.w_city,
        warehouse.w_county,
        warehouse.w_state,
        warehouse.w_zip,
        warehouse.w_country,
        warehouse.w_gmt_offset
 FROM tpcds.warehouse
 ORDER BY warehouse.w_country,
          warehouse.w_zip
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

