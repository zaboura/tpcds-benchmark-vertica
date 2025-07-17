

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_dom ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_dom
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_dom,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_county ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_county
 FROM tpcds.store 
 ORDER BY s_county,
          s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');