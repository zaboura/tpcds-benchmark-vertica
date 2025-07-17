
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING GCDDELTA,
 ss_sold_date_sk ENCODING RLE,
 ss_cdemo_sk ENCODING DELTAVAL,
 ss_promo_sk ENCODING RLE,
 ss_quantity ENCODING DELTAVAL,
 ss_list_price ENCODING DELTAVAL,
 ss_sales_price ENCODING DELTAVAL,
 ss_coupon_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_cdemo_sk,
        store_sales.ss_promo_sk,
        store_sales.ss_quantity,
        store_sales.ss_list_price,
        store_sales.ss_sales_price,
        store_sales.ss_coupon_amt
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_sold_date_sk,
          store_sales.ss_promo_sk,
          store_sales.ss_cdemo_sk,
          store_sales.ss_coupon_amt
SEGMENTED BY hash(store_sales.ss_item_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 ss_item_sk ENCODING GCDDELTA,
 ss_sold_date_sk ENCODING RLE,
 ss_cdemo_sk ENCODING DELTAVAL,
 ss_promo_sk ENCODING RLE,
 ss_quantity ENCODING DELTAVAL,
 ss_list_price ENCODING DELTAVAL,
 ss_sales_price ENCODING DELTAVAL,
 ss_coupon_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_sold_date_sk,
        store_sales.ss_cdemo_sk,
        store_sales.ss_promo_sk,
        store_sales.ss_quantity,
        store_sales.ss_list_price,
        store_sales.ss_sales_price,
        store_sales.ss_coupon_amt
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_sold_date_sk,
          store_sales.ss_promo_sk,
          store_sales.ss_cdemo_sk,
          store_sales.ss_coupon_amt
SEGMENTED BY hash(store_sales.ss_item_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date,
        date_dim.d_month_seq
 FROM tpcds.date_dim
 ORDER BY date_dim.d_month_seq,
          date_dim.d_date
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

