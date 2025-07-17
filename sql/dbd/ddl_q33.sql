
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_category ENCODING RLE, 
 i_manufact_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_category, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_category,
          i_manufact_id,
          i_item_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC1_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_sales_DBD_3_seg_DBD_TPCDS_INC1_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.web_sales_DBD_4_seg_DBD_TPCDS_INC1_b0 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_bill_addr_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_addr_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_bill_addr_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.web_sales_DBD_4_seg_DBD_TPCDS_INC1_b1 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_bill_addr_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_addr_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_bill_addr_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 1;

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

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 i_item_sk ENCODING DELTARANGE_COMP,
 i_brand_id ENCODING ZSTD_FAST_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING RLE
)
AS
 SELECT item.i_item_sk,
        item.i_brand_id,
        item.i_brand,
        item.i_manufact_id
 FROM tpcds.item
 ORDER BY item.i_manufact_id,
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


select mark_design_ksafe(1);

