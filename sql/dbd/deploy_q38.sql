

CREATE PROJECTION customer_DBD_1_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
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

select refresh('tpcds.customer');

CREATE PROJECTION date_dim_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
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

select refresh('tpcds.date_dim');