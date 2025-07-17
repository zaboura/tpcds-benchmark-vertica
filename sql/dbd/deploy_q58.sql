

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2_v2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP, 
 d_week_seq ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date, 
        d_week_seq
 FROM tpcds.date_dim 
 ORDER BY d_date,
          d_date_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION date_dim_DBD_5_seg_DBD_TPCDS_INC2_b0 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date
 FROM tpcds.date_dim 
 ORDER BY d_date_sk
SEGMENTED BY HASH (d_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION date_dim_DBD_5_seg_DBD_TPCDS_INC2_b1 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date
 FROM tpcds.date_dim 
 ORDER BY d_date_sk
SEGMENTED BY HASH (d_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.date_dim');