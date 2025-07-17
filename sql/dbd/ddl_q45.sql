
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(customer_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_customer_sk
SEGMENTED BY MODULARHASH (c_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.customer_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(customer_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_customer_sk
SEGMENTED BY MODULARHASH (c_customer_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_item_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_item_sk, 
        i_item_id
 FROM tpcds.item 
 ORDER BY i_item_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_bill_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_bill_customer_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_address_DBD_5_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
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
 SELECT customer_address.ca_address_sk,
        customer_address.ca_address_id,
        customer_address.ca_street_number,
        customer_address.ca_street_name,
        customer_address.ca_street_type,
        customer_address.ca_suite_number,
        customer_address.ca_city,
        customer_address.ca_county,
        customer_address.ca_state,
        customer_address.ca_zip,
        customer_address.ca_country,
        customer_address.ca_gmt_offset,
        customer_address.ca_location_type
 FROM tpcds.customer_address
 ORDER BY customer_address.ca_country,
          customer_address.ca_location_type,
          customer_address.ca_gmt_offset,
          customer_address.ca_street_type,
          customer_address.ca_state,
          customer_address.ca_address_id
UNSEGMENTED ALL NODES;



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

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC1_v1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_qoy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_qoy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

