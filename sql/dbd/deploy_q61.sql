

CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC2_v3 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_gmt_offset ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_gmt_offset
 FROM tpcds.customer_address 
 ORDER BY ca_gmt_offset,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');