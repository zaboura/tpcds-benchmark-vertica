

CREATE PROJECTION call_center_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 cc_call_center_sk ENCODING AUTO, 
 cc_county ENCODING ZSTD_FAST_COMP
)
AS
 SELECT cc_call_center_sk, 
        cc_county
 FROM tpcds.call_center 
 ORDER BY cc_county,
          cc_call_center_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.call_center');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_order_number ENCODING DELTAVAL, 
 cs_ship_date_sk ENCODING RLE, 
 cs_ship_addr_sk ENCODING DELTAVAL, 
 cs_call_center_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_ext_ship_cost ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_order_number, 
        cs_ship_date_sk, 
        cs_ship_addr_sk, 
        cs_call_center_sk, 
        cs_warehouse_sk, 
        cs_ext_ship_cost, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_warehouse_sk,
          cs_order_number,
          cs_ext_ship_cost
SEGMENTED BY MODULARHASH (cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cs_order_number ENCODING DELTAVAL, 
 cs_ship_date_sk ENCODING RLE, 
 cs_ship_addr_sk ENCODING DELTAVAL, 
 cs_call_center_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_ext_ship_cost ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_order_number, 
        cs_ship_date_sk, 
        cs_ship_addr_sk, 
        cs_call_center_sk, 
        cs_warehouse_sk, 
        cs_ext_ship_cost, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_warehouse_sk,
          cs_order_number,
          cs_ext_ship_cost
SEGMENTED BY MODULARHASH (cs_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION date_dim_DBD_5_seg_DBD_TPCDS_INC_b0 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION date_dim_DBD_5_seg_DBD_TPCDS_INC_b1 /*+basename(date_dim_DBD_5_seg_DBD_TPCDS_INC),createtype(D)*/
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