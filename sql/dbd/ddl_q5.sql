
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_returns_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(store_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTARANGE_COMP, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_returns_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(store_returns_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTARANGE_COMP, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC_v1_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC_v1_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 1;

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

CREATE PROJECTION tpcds.date_dim_DBD_4_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/ 
(
 cs_item_sk ENCODING DELTAVAL,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_bill_customer_sk ENCODING RLE,
 cs_bill_cdemo_sk ENCODING DELTAVAL,
 cs_quantity ENCODING DELTAVAL,
 cs_list_price ENCODING DELTAVAL,
 cs_sales_price ENCODING DELTAVAL,
 cs_coupon_amt ENCODING DELTARANGE_COMP,
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_bill_cdemo_sk,
        catalog_sales.cs_quantity,
        catalog_sales.cs_list_price,
        catalog_sales.cs_sales_price,
        catalog_sales.cs_coupon_amt,
        catalog_sales.cs_net_profit
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_bill_customer_sk,
          catalog_sales.cs_coupon_amt
SEGMENTED BY hash(catalog_sales.cs_sold_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/ 
(
 cs_item_sk ENCODING DELTAVAL,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_bill_customer_sk ENCODING RLE,
 cs_bill_cdemo_sk ENCODING DELTAVAL,
 cs_quantity ENCODING DELTAVAL,
 cs_list_price ENCODING DELTAVAL,
 cs_sales_price ENCODING DELTAVAL,
 cs_coupon_amt ENCODING DELTARANGE_COMP,
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_bill_cdemo_sk,
        catalog_sales.cs_quantity,
        catalog_sales.cs_list_price,
        catalog_sales.cs_sales_price,
        catalog_sales.cs_coupon_amt,
        catalog_sales.cs_net_profit
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_bill_customer_sk,
          catalog_sales.cs_coupon_amt
SEGMENTED BY hash(catalog_sales.cs_sold_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

