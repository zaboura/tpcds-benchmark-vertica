
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING DELTAVAL, 
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

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING DELTAVAL, 
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

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1),createtype(D)*/ 
(
 cs_item_sk ENCODING DELTAVAL,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_bill_addr_sk ENCODING RLE,
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_addr_sk,
        catalog_sales.cs_ext_sales_price
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_bill_addr_sk,
          catalog_sales.cs_item_sk,
          catalog_sales.cs_ext_sales_price
SEGMENTED BY hash(catalog_sales.cs_item_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_v1),createtype(D)*/ 
(
 cs_item_sk ENCODING DELTAVAL,
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_bill_addr_sk ENCODING RLE,
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_addr_sk,
        catalog_sales.cs_ext_sales_price
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_bill_addr_sk,
          catalog_sales.cs_item_sk,
          catalog_sales.cs_ext_sales_price
SEGMENTED BY hash(catalog_sales.cs_item_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_4_seg_DBD_TPCDS_INC1_b0 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC1),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING DELTAVAL,
 ws_bill_addr_sk ENCODING RLE,
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_sold_date_sk,
        web_sales.ws_bill_addr_sk,
        web_sales.ws_ext_sales_price
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_bill_addr_sk,
          web_sales.ws_item_sk,
          web_sales.ws_ext_sales_price
SEGMENTED BY hash(web_sales.ws_item_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_4_seg_DBD_TPCDS_INC1_b1 /*+basename(web_sales_DBD_4_seg_DBD_TPCDS_INC1),createtype(D)*/ 
(
 ws_item_sk ENCODING DELTAVAL,
 ws_sold_date_sk ENCODING DELTAVAL,
 ws_bill_addr_sk ENCODING RLE,
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_item_sk,
        web_sales.ws_sold_date_sk,
        web_sales.ws_bill_addr_sk,
        web_sales.ws_ext_sales_price
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_bill_addr_sk,
          web_sales.ws_item_sk,
          web_sales.ws_ext_sales_price
SEGMENTED BY hash(web_sales.ws_item_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_item_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT item.i_item_sk,
        item.i_item_id
 FROM tpcds.item
 ORDER BY item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

