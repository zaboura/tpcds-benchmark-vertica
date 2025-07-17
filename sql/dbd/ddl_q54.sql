
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_customer_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_customer_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_sold_date_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_customer_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_customer_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_sold_date_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 1;

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

CREATE PROJECTION tpcds.item_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 i_item_sk ENCODING DELTAVAL,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING COMMONDELTA_COMP,
 i_class ENCODING RLE,
 i_category ENCODING RLE
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_item_desc,
        item.i_current_price,
        item.i_class,
        item.i_category
 FROM tpcds.item
 ORDER BY item.i_category,
          item.i_class,
          item.i_current_price,
          item.i_item_id,
          item.i_item_desc
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(customer_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 c_customer_sk ENCODING COMMONDELTA_COMP,
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT customer.c_customer_sk,
        customer.c_current_addr_sk
 FROM tpcds.customer
 ORDER BY customer.c_customer_sk
SEGMENTED BY hash(customer.c_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(customer_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 c_customer_sk ENCODING COMMONDELTA_COMP,
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT customer.c_customer_sk,
        customer.c_current_addr_sk
 FROM tpcds.customer
 ORDER BY customer.c_customer_sk
SEGMENTED BY hash(customer.c_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2),createtype(D)*/ 
(
 cs_item_sk ENCODING GCDDELTA,
 cs_sold_date_sk ENCODING RLE,
 cs_bill_customer_sk ENCODING DELTAVAL,
 cs_quantity ENCODING RLE
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_quantity
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_quantity,
          catalog_sales.cs_item_sk,
          catalog_sales.cs_bill_customer_sk
SEGMENTED BY hash(catalog_sales.cs_item_sk, catalog_sales.cs_bill_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2),createtype(D)*/ 
(
 cs_item_sk ENCODING GCDDELTA,
 cs_sold_date_sk ENCODING RLE,
 cs_bill_customer_sk ENCODING DELTAVAL,
 cs_quantity ENCODING RLE
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_quantity
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_quantity,
          catalog_sales.cs_item_sk,
          catalog_sales.cs_bill_customer_sk
SEGMENTED BY hash(catalog_sales.cs_item_sk, catalog_sales.cs_bill_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.customer_address_DBD_2_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/ 
(
 ca_address_sk ENCODING COMMONDELTA_COMP,
 ca_county ENCODING ZSTD_FAST_COMP,
 ca_state ENCODING RLE,
 ca_country ENCODING RLE
)
AS
 SELECT customer_address.ca_address_sk,
        customer_address.ca_county,
        customer_address.ca_state,
        customer_address.ca_country
 FROM tpcds.customer_address
 ORDER BY customer_address.ca_state,
          customer_address.ca_country,
          customer_address.ca_address_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq
 FROM tpcds.date_dim
 ORDER BY date_dim.d_month_seq,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTARANGE_COMP,
 ws_sold_date_sk ENCODING RLE,
 ws_bill_customer_sk ENCODING DELTAVAL,
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_sold_date_sk,
        web_sales.ws_bill_customer_sk,
        web_sales.ws_sales_price
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_sold_date_sk,
          web_sales.ws_item_sk,
          web_sales.ws_bill_customer_sk
SEGMENTED BY hash(web_sales.ws_bill_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTARANGE_COMP,
 ws_sold_date_sk ENCODING RLE,
 ws_bill_customer_sk ENCODING DELTAVAL,
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_sold_date_sk,
        web_sales.ws_bill_customer_sk,
        web_sales.ws_sales_price
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_sold_date_sk,
          web_sales.ws_item_sk,
          web_sales.ws_bill_customer_sk
SEGMENTED BY hash(web_sales.ws_bill_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

