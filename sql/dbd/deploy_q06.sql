

CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_state ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state
 FROM tpcds.customer_address 
 ORDER BY ca_state,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_moy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq, 
        d_year, 
        d_moy
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_moy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION item_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_current_price ENCODING DELTARANGE_COMP, 
 i_category ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_current_price, 
        i_category
 FROM tpcds.item 
 ORDER BY i_category,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_item_sk,
          ss_sold_date_sk
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_item_sk,
          ss_sold_date_sk
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');