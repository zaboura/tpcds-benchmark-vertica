

CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_city ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ca_address_sk, 
        ca_city
 FROM tpcds.customer_address 
 ORDER BY ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING COMMONDELTA_COMP, 
 c_first_name ENCODING ZSTD_FAST_COMP, 
 c_last_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk, 
        c_first_name, 
        c_last_name
 FROM tpcds.customer 
 ORDER BY c_current_addr_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer');

CREATE PROJECTION date_dim_DBD_3_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_dow ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_dow
 FROM tpcds.date_dim 
 ORDER BY d_dow,
          d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_coupon_amt ENCODING ZSTD_FAST_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_coupon_amt, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_coupon_amt
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_coupon_amt ENCODING ZSTD_FAST_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_coupon_amt, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_coupon_amt
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_5_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 s_store_sk ENCODING AUTO, 
 s_city ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_city
 FROM tpcds.store 
 ORDER BY s_city,
          s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');