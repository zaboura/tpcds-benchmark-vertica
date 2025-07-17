
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_customer_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_customer_sk,
          cs_sold_date_sk,
          cs_sales_price
SEGMENTED BY MODULARHASH (cs_bill_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_customer_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_customer_sk,
          cs_sold_date_sk,
          cs_sales_price
SEGMENTED BY MODULARHASH (cs_bill_customer_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_address_DBD_2_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_state ENCODING ZSTD_FAST_COMP, 
 ca_zip ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state, 
        ca_zip
 FROM tpcds.customer_address 
 ORDER BY ca_zip,
          ca_address_sk
UNSEGMENTED ALL NODES;

CREATE PROJECTION tpcds.customer_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(customer_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_customer_sk
SEGMENTED BY MODULARHASH (c_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.customer_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(customer_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 c_customer_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_customer_sk
SEGMENTED BY MODULARHASH (c_customer_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_qoy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_qoy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_qoy,
          date_dim.d_year,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

