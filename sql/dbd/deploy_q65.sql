

CREATE PROJECTION store_DBD_1_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_name
 FROM tpcds.store 
 ORDER BY s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');