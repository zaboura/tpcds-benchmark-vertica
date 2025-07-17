

CREATE PROJECTION reason_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 r_reason_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT r_reason_sk
 FROM tpcds.reason 
 ORDER BY r_reason_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.reason');