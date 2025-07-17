

CREATE PROJECTION customer_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
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