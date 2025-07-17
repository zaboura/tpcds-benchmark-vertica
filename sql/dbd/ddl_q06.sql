
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.customer_address_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
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

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
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

CREATE PROJECTION tpcds.item_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.store_sales_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.date_dim_DBD_8_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date_id ENCODING ZSTD_FAST_COMP,
 d_date ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_week_seq ENCODING COMMONDELTA_COMP,
 d_quarter_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING COMMONDELTA_COMP,
 d_dow ENCODING RLE,
 d_moy ENCODING COMMONDELTA_COMP,
 d_dom ENCODING COMMONDELTA_COMP,
 d_qoy ENCODING RLE,
 d_fy_year ENCODING COMMONDELTA_COMP,
 d_fy_quarter_seq ENCODING COMMONDELTA_COMP,
 d_fy_week_seq ENCODING COMMONDELTA_COMP,
 d_day_name ENCODING ZSTD_FAST_COMP,
 d_quarter_name ENCODING ZSTD_FAST_COMP,
 d_holiday ENCODING RLE,
 d_weekend ENCODING RLE,
 d_following_holiday ENCODING RLE,
 d_first_dom ENCODING COMMONDELTA_COMP,
 d_last_dom ENCODING COMMONDELTA_COMP,
 d_same_day_ly ENCODING COMMONDELTA_COMP,
 d_same_day_lq ENCODING COMMONDELTA_COMP,
 d_current_day ENCODING RLE,
 d_current_week ENCODING RLE,
 d_current_month ENCODING RLE,
 d_current_quarter ENCODING RLE,
 d_current_year ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date_id,
        date_dim.d_date,
        date_dim.d_month_seq,
        date_dim.d_week_seq,
        date_dim.d_quarter_seq,
        date_dim.d_year,
        date_dim.d_dow,
        date_dim.d_moy,
        date_dim.d_dom,
        date_dim.d_qoy,
        date_dim.d_fy_year,
        date_dim.d_fy_quarter_seq,
        date_dim.d_fy_week_seq,
        date_dim.d_day_name,
        date_dim.d_quarter_name,
        date_dim.d_holiday,
        date_dim.d_weekend,
        date_dim.d_following_holiday,
        date_dim.d_first_dom,
        date_dim.d_last_dom,
        date_dim.d_same_day_ly,
        date_dim.d_same_day_lq,
        date_dim.d_current_day,
        date_dim.d_current_week,
        date_dim.d_current_month,
        date_dim.d_current_quarter,
        date_dim.d_current_year
 FROM tpcds.date_dim
 ORDER BY date_dim.d_current_day,
          date_dim.d_current_week,
          date_dim.d_holiday,
          date_dim.d_weekend,
          date_dim.d_following_holiday,
          date_dim.d_current_month,
          date_dim.d_current_quarter,
          date_dim.d_current_year,
          date_dim.d_qoy,
          date_dim.d_dow,
          date_dim.d_date
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

