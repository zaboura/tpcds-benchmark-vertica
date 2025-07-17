
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.call_center_DBD_1_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 cc_call_center_sk ENCODING AUTO, 
 cc_call_center_id ENCODING ZSTD_FAST_COMP, 
 cc_rec_start_date ENCODING COMMONDELTA_COMP, 
 cc_rec_end_date ENCODING BLOCKDICT_COMP, 
 cc_closed_date_sk ENCODING RLE, 
 cc_open_date_sk ENCODING AUTO, 
 cc_name ENCODING ZSTD_FAST_COMP, 
 cc_class ENCODING RLE, 
 cc_employees ENCODING AUTO, 
 cc_sq_ft ENCODING AUTO, 
 cc_hours ENCODING ZSTD_FAST_COMP, 
 cc_manager ENCODING ZSTD_FAST_COMP, 
 cc_mkt_id ENCODING AUTO, 
 cc_mkt_class ENCODING ZSTD_FAST_COMP, 
 cc_mkt_desc ENCODING ZSTD_FAST_COMP, 
 cc_market_manager ENCODING ZSTD_FAST_COMP, 
 cc_division ENCODING AUTO, 
 cc_division_name ENCODING AUTO, 
 cc_company ENCODING AUTO, 
 cc_company_name ENCODING AUTO, 
 cc_street_number ENCODING ZSTD_FAST_COMP, 
 cc_street_name ENCODING ZSTD_FAST_COMP, 
 cc_street_type ENCODING AUTO, 
 cc_suite_number ENCODING AUTO, 
 cc_city ENCODING ZSTD_FAST_COMP, 
 cc_county ENCODING ZSTD_FAST_COMP, 
 cc_state ENCODING ZSTD_FAST_COMP, 
 cc_zip ENCODING ZSTD_FAST_COMP, 
 cc_country ENCODING RLE, 
 cc_gmt_offset ENCODING RLE, 
 cc_tax_percentage ENCODING AUTO
)
AS
 SELECT cc_call_center_sk, 
        cc_call_center_id, 
        cc_rec_start_date, 
        cc_rec_end_date, 
        cc_closed_date_sk, 
        cc_open_date_sk, 
        cc_name, 
        cc_class, 
        cc_employees, 
        cc_sq_ft, 
        cc_hours, 
        cc_manager, 
        cc_mkt_id, 
        cc_mkt_class, 
        cc_mkt_desc, 
        cc_market_manager, 
        cc_division, 
        cc_division_name, 
        cc_company, 
        cc_company_name, 
        cc_street_number, 
        cc_street_name, 
        cc_street_type, 
        cc_suite_number, 
        cc_city, 
        cc_county, 
        cc_state, 
        cc_zip, 
        cc_country, 
        cc_gmt_offset, 
        cc_tax_percentage
 FROM tpcds.call_center 
 ORDER BY cc_closed_date_sk,
          cc_country,
          cc_class,
          cc_gmt_offset,
          cc_call_center_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.catalog_page_DBD_2_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 cp_catalog_page_sk ENCODING COMMONDELTA_COMP, 
 cp_catalog_page_id ENCODING ZSTD_FAST_COMP, 
 cp_start_date_sk ENCODING RLE, 
 cp_end_date_sk ENCODING RLE, 
 cp_department ENCODING RLE, 
 cp_catalog_number ENCODING RLE, 
 cp_catalog_page_number ENCODING COMMONDELTA_COMP, 
 cp_description ENCODING ZSTD_FAST_COMP, 
 cp_type ENCODING RLE
)
AS
 SELECT cp_catalog_page_sk, 
        cp_catalog_page_id, 
        cp_start_date_sk, 
        cp_end_date_sk, 
        cp_department, 
        cp_catalog_number, 
        cp_catalog_page_number, 
        cp_description, 
        cp_type
 FROM tpcds.catalog_page 
 ORDER BY cp_department,
          cp_type,
          cp_start_date_sk,
          cp_catalog_page_id
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.catalog_returns_DBD_3_seg_MC_TPCDS_COMP_v1_b0 /*+basename(catalog_returns_DBD_3_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_returned_date_sk, 
        cr_returned_time_sk, 
        cr_refunded_customer_sk, 
        cr_refunded_cdemo_sk, 
        cr_refunded_hdemo_sk, 
        cr_refunded_addr_sk, 
        cr_returning_customer_sk, 
        cr_returning_cdemo_sk, 
        cr_returning_hdemo_sk, 
        cr_returning_addr_sk, 
        cr_call_center_sk, 
        cr_catalog_page_sk, 
        cr_ship_mode_sk, 
        cr_warehouse_sk, 
        cr_reason_sk, 
        cr_return_quantity, 
        cr_return_amount, 
        cr_return_tax, 
        cr_return_amt_inc_tax, 
        cr_fee, 
        cr_return_ship_cost, 
        cr_refunded_cash, 
        cr_reversed_charge, 
        cr_store_credit, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_warehouse_sk,
          cr_ship_mode_sk,
          cr_call_center_sk,
          cr_reason_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_returns_DBD_3_seg_MC_TPCDS_COMP_v1_b1 /*+basename(catalog_returns_DBD_3_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_returned_date_sk, 
        cr_returned_time_sk, 
        cr_refunded_customer_sk, 
        cr_refunded_cdemo_sk, 
        cr_refunded_hdemo_sk, 
        cr_refunded_addr_sk, 
        cr_returning_customer_sk, 
        cr_returning_cdemo_sk, 
        cr_returning_hdemo_sk, 
        cr_returning_addr_sk, 
        cr_call_center_sk, 
        cr_catalog_page_sk, 
        cr_ship_mode_sk, 
        cr_warehouse_sk, 
        cr_reason_sk, 
        cr_return_quantity, 
        cr_return_amount, 
        cr_return_tax, 
        cr_return_amt_inc_tax, 
        cr_fee, 
        cr_return_ship_cost, 
        cr_refunded_cash, 
        cr_reversed_charge, 
        cr_store_credit, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_warehouse_sk,
          cr_ship_mode_sk,
          cr_call_center_sk,
          cr_reason_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.catalog_sales_DBD_4_seg_MC_TPCDS_COMP_v1_b0 /*+basename(catalog_sales_DBD_4_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ship_date_sk, 
        cs_bill_customer_sk, 
        cs_bill_cdemo_sk, 
        cs_bill_hdemo_sk, 
        cs_bill_addr_sk, 
        cs_ship_customer_sk, 
        cs_ship_cdemo_sk, 
        cs_ship_hdemo_sk, 
        cs_ship_addr_sk, 
        cs_call_center_sk, 
        cs_catalog_page_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk, 
        cs_promo_sk, 
        cs_quantity, 
        cs_wholesale_cost, 
        cs_list_price, 
        cs_sales_price, 
        cs_ext_discount_amt, 
        cs_ext_sales_price, 
        cs_ext_wholesale_cost, 
        cs_ext_list_price, 
        cs_ext_tax, 
        cs_coupon_amt, 
        cs_ext_ship_cost, 
        cs_net_paid, 
        cs_net_paid_inc_tax, 
        cs_net_paid_inc_ship, 
        cs_net_paid_inc_ship_tax, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_warehouse_sk,
          cs_ship_mode_sk,
          cs_call_center_sk,
          cs_quantity,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_4_seg_MC_TPCDS_COMP_v1_b1 /*+basename(catalog_sales_DBD_4_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ship_date_sk, 
        cs_bill_customer_sk, 
        cs_bill_cdemo_sk, 
        cs_bill_hdemo_sk, 
        cs_bill_addr_sk, 
        cs_ship_customer_sk, 
        cs_ship_cdemo_sk, 
        cs_ship_hdemo_sk, 
        cs_ship_addr_sk, 
        cs_call_center_sk, 
        cs_catalog_page_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk, 
        cs_promo_sk, 
        cs_quantity, 
        cs_wholesale_cost, 
        cs_list_price, 
        cs_sales_price, 
        cs_ext_discount_amt, 
        cs_ext_sales_price, 
        cs_ext_wholesale_cost, 
        cs_ext_list_price, 
        cs_ext_tax, 
        cs_coupon_amt, 
        cs_ext_ship_cost, 
        cs_net_paid, 
        cs_net_paid_inc_tax, 
        cs_net_paid_inc_ship, 
        cs_net_paid_inc_ship_tax, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_warehouse_sk,
          cs_ship_mode_sk,
          cs_call_center_sk,
          cs_quantity,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_address_DBD_5_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 ca_address_sk ENCODING DELTAVAL, 
 ca_address_id ENCODING ZSTD_FAST_COMP, 
 ca_street_number ENCODING ZSTD_FAST_COMP, 
 ca_street_name ENCODING ZSTD_FAST_COMP, 
 ca_street_type ENCODING RLE, 
 ca_suite_number ENCODING ZSTD_FAST_COMP, 
 ca_city ENCODING ZSTD_FAST_COMP, 
 ca_county ENCODING ZSTD_FAST_COMP, 
 ca_state ENCODING RLE, 
 ca_zip ENCODING ZSTD_FAST_COMP, 
 ca_country ENCODING RLE, 
 ca_gmt_offset ENCODING RLE, 
 ca_location_type ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_address_id, 
        ca_street_number, 
        ca_street_name, 
        ca_street_type, 
        ca_suite_number, 
        ca_city, 
        ca_county, 
        ca_state, 
        ca_zip, 
        ca_country, 
        ca_gmt_offset, 
        ca_location_type
 FROM tpcds.customer_address 
 ORDER BY ca_country,
          ca_location_type,
          ca_gmt_offset,
          ca_street_type,
          ca_state,
          ca_address_id
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_demographics_DBD_6_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
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
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_marital_status, 
        cd_education_status, 
        cd_purchase_estimate, 
        cd_credit_rating, 
        cd_dep_count, 
        cd_dep_employed_count, 
        cd_dep_college_count
 FROM tpcds.customer_demographics 
 ORDER BY cd_gender,
          cd_credit_rating,
          cd_marital_status,
          cd_education_status,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count,
          cd_demo_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_DBD_7_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
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
 SELECT c_customer_sk, 
        c_customer_id, 
        c_current_cdemo_sk, 
        c_current_hdemo_sk, 
        c_current_addr_sk, 
        c_first_shipto_date_sk, 
        c_first_sales_date_sk, 
        c_salutation, 
        c_first_name, 
        c_last_name, 
        c_preferred_cust_flag, 
        c_birth_day, 
        c_birth_month, 
        c_birth_year, 
        c_birth_country, 
        c_login, 
        c_email_address, 
        c_last_review_date
 FROM tpcds.customer 
 ORDER BY c_login,
          c_preferred_cust_flag,
          c_salutation,
          c_birth_month,
          c_birth_day,
          c_customer_id
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.date_dim_DBD_8_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
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
 SELECT d_date_sk, 
        d_date_id, 
        d_date, 
        d_month_seq, 
        d_week_seq, 
        d_quarter_seq, 
        d_year, 
        d_dow, 
        d_moy, 
        d_dom, 
        d_qoy, 
        d_fy_year, 
        d_fy_quarter_seq, 
        d_fy_week_seq, 
        d_day_name, 
        d_quarter_name, 
        d_holiday, 
        d_weekend, 
        d_following_holiday, 
        d_first_dom, 
        d_last_dom, 
        d_same_day_ly, 
        d_same_day_lq, 
        d_current_day, 
        d_current_week, 
        d_current_month, 
        d_current_quarter, 
        d_current_year
 FROM tpcds.date_dim 
 ORDER BY d_current_day,
          d_current_week,
          d_holiday,
          d_weekend,
          d_following_holiday,
          d_current_month,
          d_current_quarter,
          d_current_year,
          d_qoy,
          d_dow,
          d_date
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.household_demographics_DBD_9_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 hd_demo_sk ENCODING COMMONDELTA_COMP, 
 hd_income_band_sk ENCODING COMMONDELTA_COMP, 
 hd_buy_potential ENCODING RLE, 
 hd_dep_count ENCODING RLE, 
 hd_vehicle_count ENCODING RLE
)
AS
 SELECT hd_demo_sk, 
        hd_income_band_sk, 
        hd_buy_potential, 
        hd_dep_count, 
        hd_vehicle_count
 FROM tpcds.household_demographics 
 ORDER BY hd_buy_potential,
          hd_vehicle_count,
          hd_dep_count,
          hd_demo_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.income_band_DBD_10_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 ib_income_band_sk ENCODING COMMONDELTA_COMP, 
 ib_lower_bound ENCODING COMMONDELTA_COMP, 
 ib_upper_bound ENCODING COMMONDELTA_COMP
)
AS
 SELECT ib_income_band_sk, 
        ib_lower_bound, 
        ib_upper_bound
 FROM tpcds.income_band 
 ORDER BY ib_upper_bound
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.inventory_DBD_11_seg_MC_TPCDS_COMP_v1_b0 /*+basename(inventory_DBD_11_seg_MC_TPCDS_COMP_v1),createtype(D)*/
(
 inv_item_sk ENCODING DELTARANGE_COMP, 
 inv_date_sk ENCODING RLE, 
 inv_warehouse_sk ENCODING RLE, 
 inv_quantity_on_hand ENCODING RLE
)
AS
 SELECT inv_item_sk, 
        inv_date_sk, 
        inv_warehouse_sk, 
        inv_quantity_on_hand
 FROM tpcds.inventory 
 ORDER BY inv_warehouse_sk,
          inv_date_sk,
          inv_quantity_on_hand,
          inv_item_sk
SEGMENTED BY MODULARHASH (inv_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.inventory_DBD_11_seg_MC_TPCDS_COMP_v1_b1 /*+basename(inventory_DBD_11_seg_MC_TPCDS_COMP_v1),createtype(D)*/
(
 inv_item_sk ENCODING DELTARANGE_COMP, 
 inv_date_sk ENCODING RLE, 
 inv_warehouse_sk ENCODING RLE, 
 inv_quantity_on_hand ENCODING RLE
)
AS
 SELECT inv_item_sk, 
        inv_date_sk, 
        inv_warehouse_sk, 
        inv_quantity_on_hand
 FROM tpcds.inventory 
 ORDER BY inv_warehouse_sk,
          inv_date_sk,
          inv_quantity_on_hand,
          inv_item_sk
SEGMENTED BY MODULARHASH (inv_item_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.item_DBD_12_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
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
 SELECT i_item_sk, 
        i_item_id, 
        i_rec_start_date, 
        i_rec_end_date, 
        i_item_desc, 
        i_current_price, 
        i_wholesale_cost, 
        i_brand_id, 
        i_brand, 
        i_class_id, 
        i_class, 
        i_category_id, 
        i_category, 
        i_manufact_id, 
        i_manufact, 
        i_size, 
        i_formulation, 
        i_color, 
        i_units, 
        i_container, 
        i_manager_id, 
        i_product_name
 FROM tpcds.item 
 ORDER BY i_container,
          i_rec_end_date,
          i_rec_start_date,
          i_size,
          i_category_id,
          i_item_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.promotion_DBD_13_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
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
 p_channel_event ENCODING AUTO, 
 p_channel_demo ENCODING AUTO, 
 p_channel_details ENCODING ZSTD_FAST_COMP, 
 p_purpose ENCODING ZSTD_FAST_COMP, 
 p_discount_active ENCODING AUTO
)
AS
 SELECT p_promo_sk, 
        p_promo_id, 
        p_start_date_sk, 
        p_end_date_sk, 
        p_item_sk, 
        p_cost, 
        p_response_target, 
        p_promo_name, 
        p_channel_dmail, 
        p_channel_email, 
        p_channel_catalog, 
        p_channel_tv, 
        p_channel_radio, 
        p_channel_press, 
        p_channel_event, 
        p_channel_demo, 
        p_channel_details, 
        p_purpose, 
        p_discount_active
 FROM tpcds.promotion 
 ORDER BY p_cost,
          p_response_target,
          p_channel_email,
          p_channel_catalog,
          p_channel_tv,
          p_channel_radio,
          p_channel_press,
          p_promo_id
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.reason_DBD_14_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 r_reason_sk ENCODING COMMONDELTA_COMP, 
 r_reason_id ENCODING ZSTD_FAST_COMP, 
 r_reason_desc ENCODING ZSTD_FAST_COMP
)
AS
 SELECT r_reason_sk, 
        r_reason_id, 
        r_reason_desc
 FROM tpcds.reason 
 ORDER BY r_reason_id
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.ship_mode_DBD_15_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 sm_ship_mode_sk ENCODING AUTO, 
 sm_ship_mode_id ENCODING ZSTD_FAST_COMP, 
 sm_type ENCODING AUTO, 
 sm_code ENCODING ZSTD_FAST_COMP, 
 sm_carrier ENCODING ZSTD_FAST_COMP, 
 sm_contract ENCODING ZSTD_FAST_COMP
)
AS
 SELECT sm_ship_mode_sk, 
        sm_ship_mode_id, 
        sm_type, 
        sm_code, 
        sm_carrier, 
        sm_contract
 FROM tpcds.ship_mode 
 ORDER BY sm_contract
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.store_returns_DBD_16_seg_MC_TPCDS_COMP_v1_b0 /*+basename(store_returns_DBD_16_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_return_time_sk, 
        sr_customer_sk, 
        sr_cdemo_sk, 
        sr_hdemo_sk, 
        sr_addr_sk, 
        sr_store_sk, 
        sr_reason_sk, 
        sr_return_quantity, 
        sr_return_amt, 
        sr_return_tax, 
        sr_return_amt_inc_tax, 
        sr_fee, 
        sr_return_ship_cost, 
        sr_refunded_cash, 
        sr_reversed_charge, 
        sr_store_credit, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_reason_sk,
          sr_return_quantity,
          sr_store_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_returns_DBD_16_seg_MC_TPCDS_COMP_v1_b1 /*+basename(store_returns_DBD_16_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_return_time_sk, 
        sr_customer_sk, 
        sr_cdemo_sk, 
        sr_hdemo_sk, 
        sr_addr_sk, 
        sr_store_sk, 
        sr_reason_sk, 
        sr_return_quantity, 
        sr_return_amt, 
        sr_return_tax, 
        sr_return_amt_inc_tax, 
        sr_fee, 
        sr_return_ship_cost, 
        sr_refunded_cash, 
        sr_reversed_charge, 
        sr_store_credit, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_reason_sk,
          sr_return_quantity,
          sr_store_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_ticket_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_sales_DBD_17_seg_MC_TPCDS_COMP_v1_b0 /*+basename(store_sales_DBD_17_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 ORDER BY ss_quantity,
          ss_store_sk,
          ss_promo_sk,
          ss_ticket_number,
          ss_ext_discount_amt
SEGMENTED BY MODULARHASH (ss_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_17_seg_MC_TPCDS_COMP_v1_b1 /*+basename(store_sales_DBD_17_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 ORDER BY ss_quantity,
          ss_store_sk,
          ss_promo_sk,
          ss_ticket_number,
          ss_ext_discount_amt
SEGMENTED BY MODULARHASH (ss_ticket_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_DBD_18_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP, 
 s_rec_start_date ENCODING ZSTD_FAST_COMP, 
 s_rec_end_date ENCODING ZSTD_FAST_COMP, 
 s_closed_date_sk ENCODING ZSTD_FAST_COMP, 
 s_store_name ENCODING ZSTD_FAST_COMP, 
 s_number_employees ENCODING DELTAVAL, 
 s_floor_space ENCODING ZSTD_FAST_COMP, 
 s_hours ENCODING ZSTD_FAST_COMP, 
 s_manager ENCODING ZSTD_FAST_COMP, 
 s_market_id ENCODING DELTAVAL, 
 s_geography_class ENCODING RLE, 
 s_market_desc ENCODING ZSTD_FAST_COMP, 
 s_market_manager ENCODING ZSTD_FAST_COMP, 
 s_division_id ENCODING RLE, 
 s_division_name ENCODING RLE, 
 s_company_id ENCODING RLE, 
 s_company_name ENCODING RLE, 
 s_street_number ENCODING ZSTD_FAST_COMP, 
 s_street_name ENCODING ZSTD_FAST_COMP, 
 s_street_type ENCODING ZSTD_FAST_COMP, 
 s_suite_number ENCODING ZSTD_FAST_COMP, 
 s_city ENCODING ZSTD_FAST_COMP, 
 s_county ENCODING ZSTD_FAST_COMP, 
 s_state ENCODING ZSTD_FAST_COMP, 
 s_zip ENCODING ZSTD_FAST_COMP, 
 s_country ENCODING RLE, 
 s_gmt_offset ENCODING BLOCKDICT_COMP, 
 s_tax_precentage ENCODING DELTAVAL
)
AS
 SELECT s_store_sk, 
        s_store_id, 
        s_rec_start_date, 
        s_rec_end_date, 
        s_closed_date_sk, 
        s_store_name, 
        s_number_employees, 
        s_floor_space, 
        s_hours, 
        s_manager, 
        s_market_id, 
        s_geography_class, 
        s_market_desc, 
        s_market_manager, 
        s_division_id, 
        s_division_name, 
        s_company_id, 
        s_company_name, 
        s_street_number, 
        s_street_name, 
        s_street_type, 
        s_suite_number, 
        s_city, 
        s_county, 
        s_state, 
        s_zip, 
        s_country, 
        s_gmt_offset, 
        s_tax_precentage
 FROM tpcds.store 
 ORDER BY s_geography_class,
          s_division_id,
          s_division_name,
          s_company_id,
          s_company_name,
          s_country,
          s_store_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.time_dim_DBD_19_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 t_time_sk ENCODING COMMONDELTA_COMP, 
 t_time_id ENCODING ZSTD_FAST_COMP, 
 t_time ENCODING COMMONDELTA_COMP, 
 t_hour ENCODING RLE, 
 t_minute ENCODING RLE, 
 t_second ENCODING COMMONDELTA_COMP, 
 t_am_pm ENCODING RLE, 
 t_shift ENCODING RLE, 
 t_sub_shift ENCODING RLE, 
 t_meal_time ENCODING RLE
)
AS
 SELECT t_time_sk, 
        t_time_id, 
        t_time, 
        t_hour, 
        t_minute, 
        t_second, 
        t_am_pm, 
        t_shift, 
        t_sub_shift, 
        t_meal_time
 FROM tpcds.time_dim 
 ORDER BY t_am_pm,
          t_shift,
          t_sub_shift,
          t_meal_time,
          t_hour,
          t_time
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.warehouse_DBD_20_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 w_warehouse_sk ENCODING AUTO, 
 w_warehouse_id ENCODING AUTO, 
 w_warehouse_name ENCODING ZSTD_FAST_COMP, 
 w_warehouse_sq_ft ENCODING AUTO, 
 w_street_number ENCODING ZSTD_FAST_COMP, 
 w_street_name ENCODING ZSTD_FAST_COMP, 
 w_street_type ENCODING AUTO, 
 w_suite_number ENCODING AUTO, 
 w_city ENCODING ZSTD_FAST_COMP, 
 w_county ENCODING ZSTD_FAST_COMP, 
 w_state ENCODING AUTO, 
 w_zip ENCODING ZSTD_FAST_COMP, 
 w_country ENCODING RLE, 
 w_gmt_offset ENCODING BLOCKDICT_COMP
)
AS
 SELECT w_warehouse_sk, 
        w_warehouse_id, 
        w_warehouse_name, 
        w_warehouse_sq_ft, 
        w_street_number, 
        w_street_name, 
        w_street_type, 
        w_suite_number, 
        w_city, 
        w_county, 
        w_state, 
        w_zip, 
        w_country, 
        w_gmt_offset
 FROM tpcds.warehouse 
 ORDER BY w_country,
          w_zip
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_page_DBD_21_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 wp_web_page_sk ENCODING COMMONDELTA_COMP, 
 wp_web_page_id ENCODING ZSTD_FAST_COMP, 
 wp_rec_start_date ENCODING RLE, 
 wp_rec_end_date ENCODING RLE, 
 wp_creation_date_sk ENCODING ZSTD_FAST_COMP, 
 wp_access_date_sk ENCODING DELTAVAL, 
 wp_autogen_flag ENCODING RLE, 
 wp_customer_sk ENCODING DELTARANGE_COMP, 
 wp_url ENCODING RLE, 
 wp_type ENCODING ZSTD_FAST_COMP, 
 wp_char_count ENCODING DELTAVAL, 
 wp_link_count ENCODING DELTAVAL, 
 wp_image_count ENCODING DELTAVAL, 
 wp_max_ad_count ENCODING BLOCKDICT_COMP
)
AS
 SELECT wp_web_page_sk, 
        wp_web_page_id, 
        wp_rec_start_date, 
        wp_rec_end_date, 
        wp_creation_date_sk, 
        wp_access_date_sk, 
        wp_autogen_flag, 
        wp_customer_sk, 
        wp_url, 
        wp_type, 
        wp_char_count, 
        wp_link_count, 
        wp_image_count, 
        wp_max_ad_count
 FROM tpcds.web_page 
 ORDER BY wp_url,
          wp_autogen_flag,
          wp_rec_end_date,
          wp_rec_start_date,
          wp_web_page_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_returns_DBD_22_seg_MC_TPCDS_COMP_v1_b0 /*+basename(web_returns_DBD_22_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_returned_date_sk, 
        wr_returned_time_sk, 
        wr_refunded_customer_sk, 
        wr_refunded_cdemo_sk, 
        wr_refunded_hdemo_sk, 
        wr_refunded_addr_sk, 
        wr_returning_customer_sk, 
        wr_returning_cdemo_sk, 
        wr_returning_hdemo_sk, 
        wr_returning_addr_sk, 
        wr_web_page_sk, 
        wr_reason_sk, 
        wr_return_quantity, 
        wr_return_amt, 
        wr_return_tax, 
        wr_return_amt_inc_tax, 
        wr_fee, 
        wr_return_ship_cost, 
        wr_refunded_cash, 
        wr_reversed_charge, 
        wr_account_credit, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_reason_sk,
          wr_return_quantity,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_returns_DBD_22_seg_MC_TPCDS_COMP_v1_b1 /*+basename(web_returns_DBD_22_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_returned_date_sk, 
        wr_returned_time_sk, 
        wr_refunded_customer_sk, 
        wr_refunded_cdemo_sk, 
        wr_refunded_hdemo_sk, 
        wr_refunded_addr_sk, 
        wr_returning_customer_sk, 
        wr_returning_cdemo_sk, 
        wr_returning_hdemo_sk, 
        wr_returning_addr_sk, 
        wr_web_page_sk, 
        wr_reason_sk, 
        wr_return_quantity, 
        wr_return_amt, 
        wr_return_tax, 
        wr_return_amt_inc_tax, 
        wr_fee, 
        wr_return_ship_cost, 
        wr_refunded_cash, 
        wr_reversed_charge, 
        wr_account_credit, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_reason_sk,
          wr_return_quantity,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_sales_DBD_23_seg_MC_TPCDS_COMP_v1_b0 /*+basename(web_sales_DBD_23_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ship_date_sk, 
        ws_bill_customer_sk, 
        ws_bill_cdemo_sk, 
        ws_bill_hdemo_sk, 
        ws_bill_addr_sk, 
        ws_ship_customer_sk, 
        ws_ship_cdemo_sk, 
        ws_ship_hdemo_sk, 
        ws_ship_addr_sk, 
        ws_web_page_sk, 
        ws_web_site_sk, 
        ws_ship_mode_sk, 
        ws_warehouse_sk, 
        ws_promo_sk, 
        ws_quantity, 
        ws_wholesale_cost, 
        ws_list_price, 
        ws_sales_price, 
        ws_ext_discount_amt, 
        ws_ext_sales_price, 
        ws_ext_wholesale_cost, 
        ws_ext_list_price, 
        ws_ext_tax, 
        ws_coupon_amt, 
        ws_ext_ship_cost, 
        ws_net_paid, 
        ws_net_paid_inc_tax, 
        ws_net_paid_inc_ship, 
        ws_net_paid_inc_ship_tax, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_warehouse_sk,
          ws_ship_mode_sk,
          ws_web_site_sk,
          ws_quantity,
          ws_coupon_amt
SEGMENTED BY MODULARHASH (ws_net_paid_inc_tax) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_23_seg_MC_TPCDS_COMP_v1_b1 /*+basename(web_sales_DBD_23_seg_MC_TPCDS_COMP_v1),createtype(D)*/
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
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ship_date_sk, 
        ws_bill_customer_sk, 
        ws_bill_cdemo_sk, 
        ws_bill_hdemo_sk, 
        ws_bill_addr_sk, 
        ws_ship_customer_sk, 
        ws_ship_cdemo_sk, 
        ws_ship_hdemo_sk, 
        ws_ship_addr_sk, 
        ws_web_page_sk, 
        ws_web_site_sk, 
        ws_ship_mode_sk, 
        ws_warehouse_sk, 
        ws_promo_sk, 
        ws_quantity, 
        ws_wholesale_cost, 
        ws_list_price, 
        ws_sales_price, 
        ws_ext_discount_amt, 
        ws_ext_sales_price, 
        ws_ext_wholesale_cost, 
        ws_ext_list_price, 
        ws_ext_tax, 
        ws_coupon_amt, 
        ws_ext_ship_cost, 
        ws_net_paid, 
        ws_net_paid_inc_tax, 
        ws_net_paid_inc_ship, 
        ws_net_paid_inc_ship_tax, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_warehouse_sk,
          ws_ship_mode_sk,
          ws_web_site_sk,
          ws_quantity,
          ws_coupon_amt
SEGMENTED BY MODULARHASH (ws_net_paid_inc_tax) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_site_DBD_24_rep_MC_TPCDS_COMP_v1 /*+createtype(D)*/
(
 web_site_sk ENCODING AUTO, 
 web_site_id ENCODING AUTO, 
 web_rec_start_date ENCODING AUTO, 
 web_rec_end_date ENCODING BLOCKDICT_COMP, 
 web_name ENCODING AUTO, 
 web_open_date_sk ENCODING AUTO, 
 web_close_date_sk ENCODING DELTAVAL, 
 web_class ENCODING RLE, 
 web_manager ENCODING ZSTD_FAST_COMP, 
 web_mkt_id ENCODING AUTO, 
 web_mkt_class ENCODING ZSTD_FAST_COMP, 
 web_mkt_desc ENCODING ZSTD_FAST_COMP, 
 web_market_manager ENCODING ZSTD_FAST_COMP, 
 web_company_id ENCODING AUTO, 
 web_company_name ENCODING AUTO, 
 web_street_number ENCODING ZSTD_FAST_COMP, 
 web_street_name ENCODING ZSTD_FAST_COMP, 
 web_street_type ENCODING ZSTD_FAST_COMP, 
 web_suite_number ENCODING AUTO, 
 web_city ENCODING ZSTD_FAST_COMP, 
 web_county ENCODING ZSTD_FAST_COMP, 
 web_state ENCODING ZSTD_FAST_COMP, 
 web_zip ENCODING ZSTD_FAST_COMP, 
 web_country ENCODING RLE, 
 web_gmt_offset ENCODING RLE, 
 web_tax_percentage ENCODING AUTO
)
AS
 SELECT web_site_sk, 
        web_site_id, 
        web_rec_start_date, 
        web_rec_end_date, 
        web_name, 
        web_open_date_sk, 
        web_close_date_sk, 
        web_class, 
        web_manager, 
        web_mkt_id, 
        web_mkt_class, 
        web_mkt_desc, 
        web_market_manager, 
        web_company_id, 
        web_company_name, 
        web_street_number, 
        web_street_name, 
        web_street_type, 
        web_suite_number, 
        web_city, 
        web_county, 
        web_state, 
        web_zip, 
        web_country, 
        web_gmt_offset, 
        web_tax_percentage
 FROM tpcds.web_site 
 ORDER BY web_class,
          web_country,
          web_gmt_offset,
          web_street_name
UNSEGMENTED ALL NODES;


select mark_design_ksafe(1);

