

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_ship_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_customer_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_ship_customer_sk
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_ship_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_customer_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_ship_customer_sk
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION customer_address_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_county ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_county
 FROM tpcds.customer_address 
 ORDER BY ca_county,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_cdemo_sk ENCODING COMMONDELTA_COMP, 
 c_current_addr_sk ENCODING DELTAVAL
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_current_cdemo_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer');

CREATE PROJECTION date_dim_DBD_4_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_moy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_moy
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION web_sales_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_bill_customer_sk
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_bill_customer_sk
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');