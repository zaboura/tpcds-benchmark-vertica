
select mark_design_ksafe(1);

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

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/ 
(
 cs_item_sk ENCODING GCDDELTA,
 cs_order_number ENCODING DELTARANGE_COMP,
 cs_sold_date_sk ENCODING RLE,
 cs_bill_customer_sk ENCODING DELTAVAL,
 cs_quantity ENCODING RLE,
 cs_wholesale_cost ENCODING DELTAVAL,
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_order_number,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_quantity,
        catalog_sales.cs_wholesale_cost,
        catalog_sales.cs_sales_price
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_quantity,
          catalog_sales.cs_order_number,
          catalog_sales.cs_bill_customer_sk
SEGMENTED BY hash(catalog_sales.cs_item_sk, catalog_sales.cs_order_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/ 
(
 cs_item_sk ENCODING GCDDELTA,
 cs_order_number ENCODING DELTARANGE_COMP,
 cs_sold_date_sk ENCODING RLE,
 cs_bill_customer_sk ENCODING DELTAVAL,
 cs_quantity ENCODING RLE,
 cs_wholesale_cost ENCODING DELTAVAL,
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT catalog_sales.cs_item_sk,
        catalog_sales.cs_order_number,
        catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_quantity,
        catalog_sales.cs_wholesale_cost,
        catalog_sales.cs_sales_price
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_quantity,
          catalog_sales.cs_order_number,
          catalog_sales.cs_bill_customer_sk
SEGMENTED BY hash(catalog_sales.cs_item_sk, catalog_sales.cs_order_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

