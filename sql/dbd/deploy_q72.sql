

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2_v4 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP, 
 d_week_seq ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_date, 
        d_week_seq, 
        d_year
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');