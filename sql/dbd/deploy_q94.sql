

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC4_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC4),createtype(D)*/
(
 ws_order_number ENCODING DELTAVAL, 
 ws_ship_date_sk ENCODING RLE, 
 ws_ship_addr_sk ENCODING DELTAVAL, 
 ws_web_site_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE, 
 ws_ext_ship_cost ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_order_number, 
        ws_ship_date_sk, 
        ws_ship_addr_sk, 
        ws_web_site_sk, 
        ws_warehouse_sk, 
        ws_ext_ship_cost, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_ship_date_sk,
          ws_web_site_sk,
          ws_warehouse_sk,
          ws_order_number,
          ws_ext_ship_cost
SEGMENTED BY MODULARHASH (ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC4_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC4),createtype(D)*/
(
 ws_order_number ENCODING DELTAVAL, 
 ws_ship_date_sk ENCODING RLE, 
 ws_ship_addr_sk ENCODING DELTAVAL, 
 ws_web_site_sk ENCODING RLE, 
 ws_warehouse_sk ENCODING RLE, 
 ws_ext_ship_cost ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_order_number, 
        ws_ship_date_sk, 
        ws_ship_addr_sk, 
        ws_web_site_sk, 
        ws_warehouse_sk, 
        ws_ext_ship_cost, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_ship_date_sk,
          ws_web_site_sk,
          ws_warehouse_sk,
          ws_order_number,
          ws_ext_ship_cost
SEGMENTED BY MODULARHASH (ws_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

CREATE PROJECTION web_site_DBD_2_rep_DBD_TPCDS_INC4 /*+createtype(D)*/
(
 web_site_sk ENCODING AUTO, 
 web_company_name ENCODING AUTO
)
AS
 SELECT web_site_sk, 
        web_company_name
 FROM tpcds.web_site 
 ORDER BY web_company_name,
          web_site_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.web_site');