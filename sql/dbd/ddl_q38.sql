
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_DBD_1_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_first_name ENCODING ZSTD_FAST_COMP, 
 c_last_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT c_customer_sk, 
        c_first_name, 
        c_last_name
 FROM tpcds.customer 
 ORDER BY c_customer_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_date, 
        d_month_seq
 FROM tpcds.date_dim 
 ORDER BY d_month_seq,
          d_date
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_DBD_7_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 c_customer_sk ENCODING DELTARANGE_COMP,
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
 SELECT customer.c_customer_sk,
        customer.c_customer_id,
        customer.c_current_cdemo_sk,
        customer.c_current_hdemo_sk,
        customer.c_current_addr_sk,
        customer.c_first_shipto_date_sk,
        customer.c_first_sales_date_sk,
        customer.c_salutation,
        customer.c_first_name,
        customer.c_last_name,
        customer.c_preferred_cust_flag,
        customer.c_birth_day,
        customer.c_birth_month,
        customer.c_birth_year,
        customer.c_birth_country,
        customer.c_login,
        customer.c_email_address,
        customer.c_last_review_date
 FROM tpcds.customer
 ORDER BY customer.c_login,
          customer.c_preferred_cust_flag,
          customer.c_salutation,
          customer.c_birth_month,
          customer.c_birth_day,
          customer.c_customer_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING RLE
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_customer_sk
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_customer_sk,
          store_sales.ss_item_sk,
          store_sales.ss_sold_date_sk
SEGMENTED BY hash(store_sales.ss_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING RLE
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_customer_sk
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_customer_sk,
          store_sales.ss_item_sk,
          store_sales.ss_sold_date_sk
SEGMENTED BY hash(store_sales.ss_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ws_sold_date_sk ENCODING RLE,
 ws_bill_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_sold_date_sk,
        web_sales.ws_bill_customer_sk
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_sold_date_sk,
          web_sales.ws_bill_customer_sk
SEGMENTED BY hash(web_sales.ws_sold_date_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.web_sales_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ws_sold_date_sk ENCODING RLE,
 ws_bill_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT web_sales.ws_sold_date_sk,
        web_sales.ws_bill_customer_sk
 FROM tpcds.web_sales
 ORDER BY web_sales.ws_sold_date_sk,
          web_sales.ws_bill_customer_sk
SEGMENTED BY hash(web_sales.ws_sold_date_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1),createtype(D)*/ 
(
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_bill_customer_sk ENCODING RLE,
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_sales_price
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_bill_customer_sk,
          catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_sales_price
SEGMENTED BY hash(catalog_sales.cs_bill_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1),createtype(D)*/ 
(
 cs_sold_date_sk ENCODING DELTAVAL,
 cs_bill_customer_sk ENCODING RLE,
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT catalog_sales.cs_sold_date_sk,
        catalog_sales.cs_bill_customer_sk,
        catalog_sales.cs_sales_price
 FROM tpcds.catalog_sales
 ORDER BY catalog_sales.cs_bill_customer_sk,
          catalog_sales.cs_sold_date_sk,
          catalog_sales.cs_sales_price
SEGMENTED BY hash(catalog_sales.cs_bill_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

