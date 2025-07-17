
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_catalog_page_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_catalog_page_sk, 
        cs_promo_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_order_number,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_catalog_page_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_catalog_page_sk, 
        cs_promo_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_order_number,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_web_site_sk ENCODING RLE, 
 ws_promo_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_promo_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_web_site_sk,
          ws_order_number,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_web_site_sk ENCODING RLE, 
 ws_promo_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_promo_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_web_site_sk,
          ws_order_number,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.catalog_page_DBD_2_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
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
 SELECT catalog_page.cp_catalog_page_sk,
        catalog_page.cp_catalog_page_id,
        catalog_page.cp_start_date_sk,
        catalog_page.cp_end_date_sk,
        catalog_page.cp_department,
        catalog_page.cp_catalog_number,
        catalog_page.cp_catalog_page_number,
        catalog_page.cp_description,
        catalog_page.cp_type
 FROM tpcds.catalog_page
 ORDER BY catalog_page.cp_department,
          catalog_page.cp_type,
          catalog_page.cp_start_date_sk,
          catalog_page.cp_catalog_page_id
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

CREATE PROJECTION tpcds.store_DBD_18_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
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
 SELECT store.s_store_sk,
        store.s_store_id,
        store.s_rec_start_date,
        store.s_rec_end_date,
        store.s_closed_date_sk,
        store.s_store_name,
        store.s_number_employees,
        store.s_floor_space,
        store.s_hours,
        store.s_manager,
        store.s_market_id,
        store.s_geography_class,
        store.s_market_desc,
        store.s_market_manager,
        store.s_division_id,
        store.s_division_name,
        store.s_company_id,
        store.s_company_name,
        store.s_street_number,
        store.s_street_name,
        store.s_street_type,
        store.s_suite_number,
        store.s_city,
        store.s_county,
        store.s_state,
        store.s_zip,
        store.s_country,
        store.s_gmt_offset,
        store.s_tax_precentage
 FROM tpcds.store
 ORDER BY store.s_geography_class,
          store.s_division_id,
          store.s_division_name,
          store.s_company_id,
          store.s_company_name,
          store.s_country,
          store.s_store_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_site_DBD_24_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 web_site_sk,
 web_site_id,
 web_rec_start_date,
 web_rec_end_date ENCODING BLOCKDICT_COMP,
 web_name,
 web_open_date_sk,
 web_close_date_sk ENCODING DELTAVAL,
 web_class ENCODING RLE,
 web_manager ENCODING ZSTD_FAST_COMP,
 web_mkt_id,
 web_mkt_class ENCODING ZSTD_FAST_COMP,
 web_mkt_desc ENCODING ZSTD_FAST_COMP,
 web_market_manager ENCODING ZSTD_FAST_COMP,
 web_company_id,
 web_company_name,
 web_street_number ENCODING ZSTD_FAST_COMP,
 web_street_name ENCODING ZSTD_FAST_COMP,
 web_street_type ENCODING ZSTD_FAST_COMP,
 web_suite_number,
 web_city ENCODING ZSTD_FAST_COMP,
 web_county ENCODING ZSTD_FAST_COMP,
 web_state ENCODING ZSTD_FAST_COMP,
 web_zip ENCODING ZSTD_FAST_COMP,
 web_country ENCODING RLE,
 web_gmt_offset ENCODING RLE,
 web_tax_percentage
)
AS
 SELECT web_site.web_site_sk,
        web_site.web_site_id,
        web_site.web_rec_start_date,
        web_site.web_rec_end_date,
        web_site.web_name,
        web_site.web_open_date_sk,
        web_site.web_close_date_sk,
        web_site.web_class,
        web_site.web_manager,
        web_site.web_mkt_id,
        web_site.web_mkt_class,
        web_site.web_mkt_desc,
        web_site.web_market_manager,
        web_site.web_company_id,
        web_site.web_company_name,
        web_site.web_street_number,
        web_site.web_street_name,
        web_site.web_street_type,
        web_site.web_suite_number,
        web_site.web_city,
        web_site.web_county,
        web_site.web_state,
        web_site.web_zip,
        web_site.web_country,
        web_site.web_gmt_offset,
        web_site.web_tax_percentage
 FROM tpcds.web_site
 ORDER BY web_site.web_class,
          web_site.web_country,
          web_site.web_gmt_offset,
          web_site.web_street_name
UNSEGMENTED ALL NODES;



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

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC1_v1 /*+createtype(D)*/ 
(
 i_item_sk ENCODING DELTAVAL,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING RLE,
 i_manufact_id ENCODING DELTAVAL
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_item_desc,
        item.i_current_price,
        item.i_manufact_id
 FROM tpcds.item
 ORDER BY item.i_current_price,
          item.i_item_id,
          item.i_item_desc
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

