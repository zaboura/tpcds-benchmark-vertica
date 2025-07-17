

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC1_v1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_qoy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_qoy
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');