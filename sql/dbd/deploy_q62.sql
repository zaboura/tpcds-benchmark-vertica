

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_sold_date_sk ENCODING COMMONDELTA_COMP, 
 ws_ship_date_sk ENCODING COMMONDELTA_COMP, 
 ws_web_site_sk ENCODING RLE, 
 ws_ship_mode_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE
)
AS
 SELECT ws_sold_date_sk, 
        ws_ship_date_sk, 
        ws_web_site_sk, 
        ws_ship_mode_sk, 
        ws_warehouse_sk
 FROM tpcds.web_sales 
 ORDER BY ws_web_site_sk,
          ws_ship_mode_sk,
          ws_warehouse_sk,
          ws_sold_date_sk,
          ws_ship_date_sk
SEGMENTED BY MODULARHASH (ws_ship_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_sold_date_sk ENCODING COMMONDELTA_COMP, 
 ws_ship_date_sk ENCODING COMMONDELTA_COMP, 
 ws_web_site_sk ENCODING RLE, 
 ws_ship_mode_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE
)
AS
 SELECT ws_sold_date_sk, 
        ws_ship_date_sk, 
        ws_web_site_sk, 
        ws_ship_mode_sk, 
        ws_warehouse_sk
 FROM tpcds.web_sales 
 ORDER BY ws_web_site_sk,
          ws_ship_mode_sk,
          ws_warehouse_sk,
          ws_sold_date_sk,
          ws_ship_date_sk
SEGMENTED BY MODULARHASH (ws_ship_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

CREATE PROJECTION web_site_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 web_site_sk ENCODING COMMONDELTA_COMP, 
 web_name ENCODING AUTO
)
AS
 SELECT web_site_sk, 
        web_name
 FROM tpcds.web_site 
 ORDER BY web_site_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.web_site');