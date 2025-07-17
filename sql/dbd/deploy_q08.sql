

CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_zip ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_zip
 FROM tpcds.customer_address 
 ORDER BY ca_zip,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION date_dim_DBD_2_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
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
 ORDER BY d_qoy,
          d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC_v1_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC_v1_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_store_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');