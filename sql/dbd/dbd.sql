SELECT DESIGNER_DROP_DESIGN('MC_TPCDS_COMP', true);
SELECT DESIGNER_CREATE_DESIGN('MC_TPCDS_COMP');
SELECT DESIGNER_SET_DESIGN_TYPE('MC_TPCDS_COMP', 'COMPREHENSIVE');
SELECT DESIGNER_SET_OPTIMIZATION_OBJECTIVE('MC_TPCDS_COMP', 'QUERY');
SELECT DESIGNER_ADD_DESIGN_TABLES('MC_TPCDS_COMP', 'tpcds.*', true);

SELECT DESIGNER_RUN_POPULATE_DESIGN_AND_DEPLOY(
    'MC_TPCDS_COMP',                              -- Design name
    '$PDM_PATH',      -- Optimized DDL
    '$DEPLOY_PATH',   -- Deployment script
    true,                                           -- Analyze stats before designing PDM
    true,                                           -- Deploy
    false,                                          -- Drop workspace after deploying
    false                                           -- Continue after errors
);
SELECT DESIGNER_WAIT_FOR_DESIGN('MC_TPCDS_COMP');



-- Q03
CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING COMMONDELTA_COMP, 
 d_moy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_moy
 FROM tpcds.date_dim 
 ORDER BY d_moy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_brand_id ENCODING ZSTD_FAST_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_manufact_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand_id, 
        i_brand, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_manufact_id,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q06


CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_state ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state
 FROM tpcds.customer_address 
 ORDER BY ca_state,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_moy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq, 
        d_year, 
        d_moy
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_moy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION item_DBD_3_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_current_price ENCODING DELTARANGE_COMP, 
 i_category ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_current_price, 
        i_category
 FROM tpcds.item 
 ORDER BY i_category,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_item_sk,
          ss_sold_date_sk
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_item_sk,
          ss_sold_date_sk
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q07

CREATE PROJECTION customer_demographics_DBD_1_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_education_status,
          cd_gender,
          cd_marital_status,
          cd_demo_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_demographics');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_sold_date_sk ENCODING RLE, 
 ss_cdemo_sk ENCODING DELTAVAL, 
 ss_promo_sk ENCODING RLE, 
 ss_quantity ENCODING DELTAVAL, 
 ss_list_price ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL, 
 ss_coupon_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_cdemo_sk, 
        ss_promo_sk, 
        ss_quantity, 
        ss_list_price, 
        ss_sales_price, 
        ss_coupon_amt
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_promo_sk,
          ss_cdemo_sk,
          ss_coupon_amt
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_sold_date_sk ENCODING RLE, 
 ss_cdemo_sk ENCODING DELTAVAL, 
 ss_promo_sk ENCODING RLE, 
 ss_quantity ENCODING DELTAVAL, 
 ss_list_price ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL, 
 ss_coupon_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_cdemo_sk, 
        ss_promo_sk, 
        ss_quantity, 
        ss_list_price, 
        ss_sales_price, 
        ss_coupon_amt
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_promo_sk,
          ss_cdemo_sk,
          ss_coupon_amt
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q08



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

-- Q09
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

-- Q10  


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

-- Q11








-- Q12  
--no need to deploy


-- Q13
--no need to deploy

-- Q14
--no need to deploy

-- Q15


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1),createtype(D)*/
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

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v1),createtype(D)*/
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

select refresh('tpcds.catalog_sales');

CREATE PROJECTION customer_address_DBD_2_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
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

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(customer_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION customer_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(customer_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
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

select refresh('tpcds.customer');

-- Q16


-- Q17


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_customer_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_quantity
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_quantity,
          cs_item_sk,
          cs_bill_customer_sk
SEGMENTED BY MODULARHASH (cs_item_sk, cs_bill_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_customer_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_quantity
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_quantity,
          cs_item_sk,
          cs_bill_customer_sk
SEGMENTED BY MODULARHASH (cs_item_sk, cs_bill_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION date_dim_DBD_2_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_quarter_name ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_quarter_name
 FROM tpcds.date_dim 
 ORDER BY d_quarter_name,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_return_quantity ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_return_quantity
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_return_quantity,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 sr_item_sk ENCODING GCDDELTA, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_returned_date_sk ENCODING RLE, 
 sr_customer_sk ENCODING DELTAVAL, 
 sr_return_quantity ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_returned_date_sk, 
        sr_customer_sk, 
        sr_return_quantity
 FROM tpcds.store_returns 
 ORDER BY sr_returned_date_sk,
          sr_return_quantity,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number, sr_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v1_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_quantity
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_quantity,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v1_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v1),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_quantity
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_quantity,
          ss_ticket_number,
          ss_customer_sk
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number, ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_5_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_state ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_state
 FROM tpcds.store 
 ORDER BY s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');

-- Q18


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_customer_sk ENCODING RLE, 
 cs_bill_cdemo_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING DELTAVAL, 
 cs_list_price ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL, 
 cs_coupon_amt ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_bill_cdemo_sk, 
        cs_quantity, 
        cs_list_price, 
        cs_sales_price, 
        cs_coupon_amt, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_customer_sk,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_bill_customer_sk ENCODING RLE, 
 cs_bill_cdemo_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING DELTAVAL, 
 cs_list_price ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL, 
 cs_coupon_amt ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_customer_sk, 
        cs_bill_cdemo_sk, 
        cs_quantity, 
        cs_list_price, 
        cs_sales_price, 
        cs_coupon_amt, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_bill_customer_sk,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION customer_address_DBD_2_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_county ENCODING ZSTD_FAST_COMP, 
 ca_state ENCODING RLE, 
 ca_country ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_county, 
        ca_state, 
        ca_country
 FROM tpcds.customer_address 
 ORDER BY ca_state,
          ca_country,
          ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_education_status ENCODING RLE, 
 cd_dep_count ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_education_status, 
        cd_dep_count
 FROM tpcds.customer_demographics 
 ORDER BY cd_gender,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_education_status ENCODING RLE, 
 cd_dep_count ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_education_status, 
        cd_dep_count
 FROM tpcds.customer_demographics 
 ORDER BY cd_gender,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_demographics');

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 c_customer_sk ENCODING DELTARANGE_COMP, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING DELTAVAL, 
 c_birth_month ENCODING RLE, 
 c_birth_year ENCODING RLE
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_addr_sk, 
        c_birth_month, 
        c_birth_year
 FROM tpcds.customer 
 ORDER BY c_birth_month,
          c_birth_year,
          c_customer_sk
SEGMENTED BY MODULARHASH (c_current_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
(
 c_customer_sk ENCODING DELTARANGE_COMP, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING DELTAVAL, 
 c_birth_month ENCODING RLE, 
 c_birth_year ENCODING RLE
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_addr_sk, 
        c_birth_month, 
        c_birth_year
 FROM tpcds.customer 
 ORDER BY c_birth_month,
          c_birth_year,
          c_customer_sk
SEGMENTED BY MODULARHASH (c_current_addr_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer');

-- Q19


CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_zip ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ca_address_sk, 
        ca_zip
 FROM tpcds.customer_address 
 ORDER BY ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_current_addr_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer');

CREATE PROJECTION item_DBD_3_rep_DBD_TPCDS_INC_v1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTAVAL, 
 i_brand_id ENCODING ZSTD_FAST_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_manufact_id ENCODING DELTAVAL, 
 i_manufact ENCODING ZSTD_FAST_COMP, 
 i_manager_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand_id, 
        i_brand, 
        i_manufact_id, 
        i_manufact, 
        i_manager_id
 FROM tpcds.item 
 ORDER BY i_manager_id,
          i_brand,
          i_brand_id,
          i_manufact_id,
          i_manufact
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_customer_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC_v2_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC_v2),createtype(D)*/
(
 ss_item_sk ENCODING GCDDELTA, 
 ss_sold_date_sk ENCODING RLE, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_store_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_store_sk,
          ss_customer_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q20


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v4),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

-- Q21
--no need to deploy

-- Q22
--no need to deploy

-- Q23
--no need to deploy

-- Q24


-- Q25


-- Q26


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_cdemo_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_quantity ENCODING DELTAVAL, 
 cs_list_price ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL, 
 cs_coupon_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_cdemo_sk, 
        cs_promo_sk, 
        cs_quantity, 
        cs_list_price, 
        cs_sales_price, 
        cs_coupon_amt
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_bill_cdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_sold_date_sk ENCODING RLE, 
 cs_bill_cdemo_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_quantity ENCODING DELTAVAL, 
 cs_list_price ENCODING DELTAVAL, 
 cs_sales_price ENCODING DELTAVAL, 
 cs_coupon_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_bill_cdemo_sk, 
        cs_promo_sk, 
        cs_quantity, 
        cs_list_price, 
        cs_sales_price, 
        cs_coupon_amt
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_coupon_amt
SEGMENTED BY MODULARHASH (cs_bill_cdemo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION customer_demographics_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_education_status,
          cd_gender,
          cd_marital_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_demographics_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_gender ENCODING RLE, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_gender, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_education_status,
          cd_gender,
          cd_marital_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_demographics');

-- Q27
--no need to deploy

-- Q28
--no need to deploy

-- Q29


-- Q30


-- Q31


-- Q32

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_discount_amt
 FROM tpcds.catalog_sales 
 ORDER BY cs_item_sk,
          cs_sold_date_sk,
          cs_ext_discount_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ext_discount_amt
 FROM tpcds.catalog_sales 
 ORDER BY cs_item_sk,
          cs_sold_date_sk,
          cs_ext_discount_amt
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

-- Q33


-- Q34

CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_dom ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_dom
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_dom,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_DBD_2_rep_DBD_TPCDS_INC1 /*+createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_county ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_county
 FROM tpcds.store 
 ORDER BY s_county,
          s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');
-- Q35
-- no need to deploy

-- Q36


CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_ext_sales_price,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_ext_sales_price,
          ss_net_profit
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q37
-- no need to deploy

-- Q38


-- Q39


-- Q40


CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_refunded_cash
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_refunded_cash ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_refunded_cash
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_warehouse_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_warehouse_sk,
          cs_item_sk,
          cs_order_number
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE, 
 cs_sales_price ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_warehouse_sk, 
        cs_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_warehouse_sk,
          cs_item_sk,
          cs_order_number
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

-- Q41
-- no need to deploy

-- Q42
-- no need to deploy

-- Q43


CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_day_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_day_name
 FROM tpcds.date_dim 
 ORDER BY d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_3_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 s_store_sk ENCODING DELTAVAL, 
 s_store_id ENCODING ZSTD_FAST_COMP, 
 s_store_name ENCODING RLE, 
 s_gmt_offset ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_store_id, 
        s_store_name, 
        s_gmt_offset
 FROM tpcds.store 
 ORDER BY s_gmt_offset,
          s_store_name,
          s_store_id
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');

-- Q44


-- Q45


CREATE PROJECTION customer_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(customer_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
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

CREATE PROJECTION customer_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(customer_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
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

select refresh('tpcds.customer');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_item_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_item_sk, 
        i_item_id
 FROM tpcds.item 
 ORDER BY i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_bill_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_bill_customer_sk ENCODING DELTAVAL, 
 ws_sales_price ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_bill_customer_sk, 
        ws_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_bill_customer_sk
SEGMENTED BY MODULARHASH (ws_bill_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

-- Q46



CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_city ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ca_address_sk, 
        ca_city
 FROM tpcds.customer_address 
 ORDER BY ca_address_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING COMMONDELTA_COMP, 
 c_first_name ENCODING ZSTD_FAST_COMP, 
 c_last_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT c_customer_sk, 
        c_current_addr_sk, 
        c_first_name, 
        c_last_name
 FROM tpcds.customer 
 ORDER BY c_current_addr_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.customer');

CREATE PROJECTION date_dim_DBD_3_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_year ENCODING RLE, 
 d_dow ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_year, 
        d_dow
 FROM tpcds.date_dim 
 ORDER BY d_dow,
          d_year,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_coupon_amt ENCODING ZSTD_FAST_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_coupon_amt, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_coupon_amt
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_coupon_amt ENCODING ZSTD_FAST_COMP, 
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_coupon_amt, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_coupon_amt
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_5_rep_DBD_TPCDS_INC2 /*+createtype(D)*/
(
 s_store_sk ENCODING AUTO, 
 s_city ENCODING RLE
)
AS
 SELECT s_store_sk, 
        s_city
 FROM tpcds.store 
 ORDER BY s_city,
          s_store_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.store');
-- Q47


-- Q48


-- Q49


CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cr_item_sk ENCODING DELTAVAL, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_quantity ENCODING BLOCKDICT_COMP, 
 cr_return_amount ENCODING RLE
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_quantity, 
        cr_return_amount
 FROM tpcds.catalog_returns 
 ORDER BY cr_return_amount,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cr_item_sk ENCODING DELTAVAL, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_quantity ENCODING BLOCKDICT_COMP, 
 cr_return_amount ENCODING RLE
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_quantity, 
        cr_return_amount
 FROM tpcds.catalog_returns 
 ORDER BY cr_return_amount,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_order_number ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE, 
 cs_net_paid ENCODING DELTAVAL, 
 cs_net_profit ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_quantity, 
        cs_net_paid, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_quantity,
          cs_item_sk,
          cs_order_number,
          cs_net_paid
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 cs_item_sk ENCODING RLE, 
 cs_order_number ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_quantity ENCODING RLE, 
 cs_net_paid ENCODING DELTAVAL, 
 cs_net_profit ENCODING DELTAVAL
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_quantity, 
        cs_net_paid, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_quantity,
          cs_item_sk,
          cs_order_number,
          cs_net_paid
SEGMENTED BY MODULARHASH (cs_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 sr_item_sk ENCODING DELTAVAL, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_return_quantity ENCODING BLOCKDICT_COMP, 
 sr_return_amt ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_return_quantity, 
        sr_return_amt
 FROM tpcds.store_returns 
 ORDER BY sr_return_amt,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 sr_item_sk ENCODING DELTAVAL, 
 sr_ticket_number ENCODING DELTAVAL, 
 sr_return_quantity ENCODING BLOCKDICT_COMP, 
 sr_return_amt ENCODING RLE
)
AS
 SELECT sr_item_sk, 
        sr_ticket_number, 
        sr_return_quantity, 
        sr_return_amt
 FROM tpcds.store_returns 
 ORDER BY sr_return_amt,
          sr_ticket_number
SEGMENTED BY MODULARHASH (sr_item_sk, sr_ticket_number) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING RLE, 
 ss_net_paid ENCODING DELTAVAL, 
 ss_net_profit ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_quantity, 
        ss_net_paid, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_net_profit,
          ss_quantity,
          ss_ticket_number,
          ss_net_paid
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING RLE, 
 ss_net_paid ENCODING DELTAVAL, 
 ss_net_profit ENCODING RLE
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_sold_date_sk, 
        ss_quantity, 
        ss_net_paid, 
        ss_net_profit
 FROM tpcds.store_sales 
 ORDER BY ss_net_profit,
          ss_quantity,
          ss_ticket_number,
          ss_net_paid
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION web_returns_DBD_5_seg_DBD_TPCDS_INC2_b0 /*+basename(web_returns_DBD_5_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 wr_item_sk ENCODING DELTAVAL, 
 wr_order_number ENCODING DELTAVAL, 
 wr_return_quantity ENCODING BLOCKDICT_COMP, 
 wr_return_amt ENCODING RLE
)
AS
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_return_quantity, 
        wr_return_amt
 FROM tpcds.web_returns 
 ORDER BY wr_return_amt,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_item_sk, wr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_returns_DBD_5_seg_DBD_TPCDS_INC2_b1 /*+basename(web_returns_DBD_5_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 wr_item_sk ENCODING DELTAVAL, 
 wr_order_number ENCODING DELTAVAL, 
 wr_return_quantity ENCODING BLOCKDICT_COMP, 
 wr_return_amt ENCODING RLE
)
AS
 SELECT wr_item_sk, 
        wr_order_number, 
        wr_return_quantity, 
        wr_return_amt
 FROM tpcds.web_returns 
 ORDER BY wr_return_amt,
          wr_order_number
SEGMENTED BY MODULARHASH (wr_item_sk, wr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_returns');

CREATE PROJECTION web_sales_DBD_6_seg_DBD_TPCDS_INC2_b0 /*+basename(web_sales_DBD_6_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING RLE, 
 ws_quantity ENCODING RLE, 
 ws_net_paid ENCODING DELTAVAL, 
 ws_net_profit ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_quantity, 
        ws_net_paid, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_quantity,
          ws_sold_date_sk,
          ws_order_number,
          ws_net_paid
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_6_seg_DBD_TPCDS_INC2_b1 /*+basename(web_sales_DBD_6_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_order_number ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING RLE, 
 ws_quantity ENCODING RLE, 
 ws_net_paid ENCODING DELTAVAL, 
 ws_net_profit ENCODING DELTAVAL
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_quantity, 
        ws_net_paid, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_quantity,
          ws_sold_date_sk,
          ws_order_number,
          ws_net_paid
SEGMENTED BY MODULARHASH (ws_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

-- Q50

-- Q51

-- Q52
--no need to do anything

-- Q53


CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING RLE, 
 d_qoy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq, 
        d_qoy
 FROM tpcds.date_dim 
 ORDER BY d_month_seq,
          d_qoy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
(
 i_item_sk ENCODING DELTARANGE_COMP, 
 i_brand ENCODING ZSTD_FAST_COMP, 
 i_class ENCODING ZSTD_FAST_COMP, 
 i_category ENCODING RLE, 
 i_manufact_id ENCODING RLE
)
AS
 SELECT i_item_sk, 
        i_brand, 
        i_class, 
        i_category, 
        i_manufact_id
 FROM tpcds.item 
 ORDER BY i_manufact_id,
          i_category,
          i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC2_b0 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_3_seg_DBD_TPCDS_INC2_b1 /*+basename(store_sales_DBD_3_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_b0 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_b1 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store');
-- Q54


CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_customer_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_customer_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_sold_date_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_sold_date_sk ENCODING DELTARANGE_COMP, 
 ss_customer_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ss_sold_date_sk, 
        ss_customer_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_customer_sk,
          ss_sold_date_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_customer_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');
-- Q55
--no need to do anything
-- Q56


CREATE PROJECTION customer_address_DBD_1_rep_DBD_TPCDS_INC2_v1 /*+createtype(D)*/
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

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_addr_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_addr_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_addr_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');
-- Q57

-- Q58 
--no need to do anything

-- Q59

-- Q60
--no need to do anything
-- Q61
--no need to do anything
-- Q62


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
-- Q63
--no need to do anything

-- Q64
--no need to do anything
-- Q65

-- Q66
--no need to do anything
-- Q67


CREATE PROJECTION date_dim_DBD_1_rep_DBD_TPCDS_INC2_v3 /*+createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_month_seq ENCODING RLE, 
 d_year ENCODING COMMONDELTA_COMP, 
 d_moy ENCODING RLE, 
 d_qoy ENCODING RLE
)
AS
 SELECT d_date_sk, 
        d_month_seq, 
        d_year, 
        d_moy, 
        d_qoy
 FROM tpcds.date_dim 
 ORDER BY d_month_seq,
          d_qoy,
          d_date_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.date_dim');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_quantity,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v3),createtype(D)*/
(
 ss_item_sk ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE, 
 ss_quantity ENCODING RLE, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_store_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_store_sk,
          ss_sold_date_sk,
          ss_quantity,
          ss_item_sk,
          ss_sales_price
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_DBD_4_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(store_DBD_4_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store');
-- Q68


CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL, 
 ss_ext_list_price ENCODING DELTAVAL, 
 ss_ext_tax ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_ext_list_price, 
        ss_ext_tax
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC2_v2),createtype(D)*/
(
 ss_ticket_number ENCODING DELTAVAL, 
 ss_sold_date_sk ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_addr_sk ENCODING DELTAVAL, 
 ss_store_sk ENCODING RLE, 
 ss_ext_sales_price ENCODING DELTAVAL, 
 ss_ext_list_price ENCODING DELTAVAL, 
 ss_ext_tax ENCODING ZSTD_FAST_COMP
)
AS
 SELECT ss_ticket_number, 
        ss_sold_date_sk, 
        ss_customer_sk, 
        ss_hdemo_sk, 
        ss_addr_sk, 
        ss_store_sk, 
        ss_ext_sales_price, 
        ss_ext_list_price, 
        ss_ext_tax
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_ticket_number,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_addr_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q69
--no need to do anything
-- Q70
--no need to do anything
-- Q71


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_sold_time_sk ENCODING DELTAVAL, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC2),createtype(D)*/
(
 cs_item_sk ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_sold_time_sk ENCODING DELTAVAL, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_sold_time_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC2_v4),createtype(D)*/
(
 ss_item_sk ENCODING DELTARANGE_COMP, 
 ss_sold_date_sk ENCODING RLE, 
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_ext_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_sold_date_sk, 
        ss_sold_time_sk, 
        ss_ext_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_sold_date_sk,
          ss_item_sk,
          ss_ext_sales_price
SEGMENTED BY MODULARHASH (ss_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_sold_time_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC2_v1),createtype(D)*/
(
 ws_item_sk ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_sold_time_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_sold_time_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');
-- Q72
--no need to do anything    
-- Q73
--no need to do anything
-- Q74

-- Q75

-- Q76


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ship_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ship_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_item_sk ENCODING DELTAVAL, 
 cs_sold_date_sk ENCODING DELTAVAL, 
 cs_ship_addr_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_sold_date_sk, 
        cs_ship_addr_sk, 
        cs_ext_sales_price
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_addr_sk,
          cs_item_sk,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION item_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 i_item_sk ENCODING COMMONDELTA_COMP, 
 i_category ENCODING ZSTD_FAST_COMP
)
AS
 SELECT i_item_sk, 
        i_category
 FROM tpcds.item 
 ORDER BY i_item_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.item');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ship_customer_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ship_customer_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_ship_customer_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING DELTAVAL, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ship_customer_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ship_customer_sk, 
        ws_ext_sales_price
 FROM tpcds.web_sales 
 ORDER BY ws_ship_customer_sk,
          ws_item_sk,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');
-- Q77


CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cr_returned_date_sk ENCODING RLE, 
 cr_call_center_sk ENCODING RLE, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_returned_date_sk, 
        cr_call_center_sk, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_call_center_sk,
          cr_returned_date_sk,
          cr_return_amount,
          cr_net_loss
SEGMENTED BY MODULARHASH (cr_returned_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cr_returned_date_sk ENCODING RLE, 
 cr_call_center_sk ENCODING RLE, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_returned_date_sk, 
        cr_call_center_sk, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_call_center_sk,
          cr_returned_date_sk,
          cr_return_amount,
          cr_net_loss
SEGMENTED BY MODULARHASH (cr_returned_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_call_center_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_call_center_sk,
          cs_sold_date_sk,
          cs_ext_sales_price,
          cs_net_profit
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cs_sold_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_sold_date_sk, 
        cs_call_center_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_call_center_sk,
          cs_sold_date_sk,
          cs_ext_sales_price,
          cs_net_profit
SEGMENTED BY MODULARHASH (cs_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION store_returns_DBD_6_seg_DBD_TPCDS_INC3_b0 /*+basename(store_returns_DBD_6_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_store_sk ENCODING RLE, 
 sr_returned_date_sk ENCODING RLE, 
 sr_return_amt ENCODING DELTARANGE_COMP, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_store_sk, 
        sr_returned_date_sk, 
        sr_return_amt, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_store_sk,
          sr_returned_date_sk
SEGMENTED BY HASH (sr_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_6_seg_DBD_TPCDS_INC3_b1 /*+basename(store_returns_DBD_6_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_store_sk ENCODING RLE, 
 sr_returned_date_sk ENCODING RLE, 
 sr_return_amt ENCODING DELTARANGE_COMP, 
 sr_net_loss ENCODING DELTAVAL
)
AS
 SELECT sr_store_sk, 
        sr_returned_date_sk, 
        sr_return_amt, 
        sr_net_loss
 FROM tpcds.store_returns 
 ORDER BY sr_store_sk,
          sr_returned_date_sk
SEGMENTED BY HASH (sr_store_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

CREATE PROJECTION store_DBD_7_seg_DBD_TPCDS_INC3_b0 /*+basename(store_DBD_7_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_DBD_7_seg_DBD_TPCDS_INC3_b1 /*+basename(store_DBD_7_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 s_store_sk ENCODING COMMONDELTA_COMP, 
 s_store_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT s_store_sk, 
        s_store_id
 FROM tpcds.store 
 ORDER BY s_store_sk
SEGMENTED BY HASH (s_store_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store');

CREATE PROJECTION web_page_DBD_3_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 wp_web_page_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT wp_web_page_sk
 FROM tpcds.web_page 
 ORDER BY wp_web_page_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.web_page');

CREATE PROJECTION web_returns_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(web_returns_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 wr_returned_date_sk ENCODING DELTAVAL, 
 wr_web_page_sk ENCODING RLE, 
 wr_return_amt ENCODING DELTARANGE_COMP, 
 wr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT wr_returned_date_sk, 
        wr_web_page_sk, 
        wr_return_amt, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_web_page_sk,
          wr_return_amt
SEGMENTED BY MODULARHASH (wr_returned_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_returns_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(web_returns_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 wr_returned_date_sk ENCODING DELTAVAL, 
 wr_web_page_sk ENCODING RLE, 
 wr_return_amt ENCODING DELTARANGE_COMP, 
 wr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT wr_returned_date_sk, 
        wr_web_page_sk, 
        wr_return_amt, 
        wr_net_loss
 FROM tpcds.web_returns 
 ORDER BY wr_web_page_sk,
          wr_return_amt
SEGMENTED BY MODULARHASH (wr_returned_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_returns');

CREATE PROJECTION web_sales_DBD_5_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_web_page_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_web_page_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_web_page_sk,
          ws_sold_date_sk,
          ws_ext_sales_price,
          ws_net_profit
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_5_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_sold_date_sk ENCODING RLE, 
 ws_web_page_sk ENCODING RLE, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_sold_date_sk, 
        ws_web_page_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_web_page_sk,
          ws_sold_date_sk,
          ws_ext_sales_price,
          ws_net_profit
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');
-- Q78
--no need to do anything
-- Q79

-- Q80


CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cr_item_sk ENCODING RLE, 
 cr_order_number ENCODING DELTAVAL, 
 cr_return_amount ENCODING DELTARANGE_COMP, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_item_sk, 
        cr_order_number, 
        cr_return_amount, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_item_sk,
          cr_order_number
SEGMENTED BY MODULARHASH (cr_item_sk, cr_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_catalog_page_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_catalog_page_sk, 
        cs_promo_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_order_number,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(catalog_sales_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cs_item_sk ENCODING GCDDELTA, 
 cs_order_number ENCODING DELTARANGE_COMP, 
 cs_sold_date_sk ENCODING RLE, 
 cs_catalog_page_sk ENCODING DELTAVAL, 
 cs_promo_sk ENCODING RLE, 
 cs_ext_sales_price ENCODING DELTARANGE_COMP, 
 cs_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT cs_item_sk, 
        cs_order_number, 
        cs_sold_date_sk, 
        cs_catalog_page_sk, 
        cs_promo_sk, 
        cs_ext_sales_price, 
        cs_net_profit
 FROM tpcds.catalog_sales 
 ORDER BY cs_sold_date_sk,
          cs_promo_sk,
          cs_order_number,
          cs_ext_sales_price
SEGMENTED BY MODULARHASH (cs_item_sk, cs_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_web_site_sk ENCODING RLE, 
 ws_promo_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_promo_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_web_site_sk,
          ws_order_number,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ws_item_sk ENCODING GCDDELTA, 
 ws_order_number ENCODING DELTARANGE_COMP, 
 ws_sold_date_sk ENCODING RLE, 
 ws_web_site_sk ENCODING RLE, 
 ws_promo_sk ENCODING DELTAVAL, 
 ws_ext_sales_price ENCODING DELTARANGE_COMP, 
 ws_net_profit ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_order_number, 
        ws_sold_date_sk, 
        ws_web_site_sk, 
        ws_promo_sk, 
        ws_ext_sales_price, 
        ws_net_profit
 FROM tpcds.web_sales 
 ORDER BY ws_sold_date_sk,
          ws_web_site_sk,
          ws_order_number,
          ws_ext_sales_price
SEGMENTED BY MODULARHASH (ws_item_sk, ws_order_number) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

-- Q81








-- Q82        


CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE
)
AS
 SELECT ss_item_sk
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE
)
AS
 SELECT ss_item_sk
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk
SEGMENTED BY MODULARHASH (ss_item_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

-- Q83

--no need to do anything






-- Q84


CREATE PROJECTION household_demographics_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(household_demographics_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 hd_demo_sk ENCODING AUTO, 
 hd_income_band_sk ENCODING AUTO
)
AS
 SELECT hd_demo_sk, 
        hd_income_band_sk
 FROM public.household_demographics 
 ORDER BY hd_income_band_sk
SEGMENTED BY MODULARHASH (hd_demo_sk, hd_income_band_sk) ALL NODES OFFSET 0;

CREATE PROJECTION household_demographics_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(household_demographics_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 hd_demo_sk ENCODING AUTO, 
 hd_income_band_sk ENCODING AUTO
)
AS
 SELECT hd_demo_sk, 
        hd_income_band_sk
 FROM public.household_demographics 
 ORDER BY hd_income_band_sk
SEGMENTED BY MODULARHASH (hd_demo_sk, hd_income_band_sk) ALL NODES OFFSET 1;

select refresh('public.household_demographics');

CREATE PROJECTION customer_address_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_city ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_city
 FROM tpcds.customer_address 
 ORDER BY ca_city,
          ca_address_sk
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_address_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ca_address_sk ENCODING DELTARANGE_COMP, 
 ca_city ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_city
 FROM tpcds.customer_address 
 ORDER BY ca_city,
          ca_address_sk
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk
 FROM tpcds.customer_demographics 
 ORDER BY cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk
 FROM tpcds.customer_demographics 
 ORDER BY cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_demographics');

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 c_customer_id ENCODING ZSTD_FAST_COMP, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_hdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING DELTAVAL, 
 c_first_name ENCODING ZSTD_FAST_COMP, 
 c_last_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT c_customer_id, 
        c_current_cdemo_sk, 
        c_current_hdemo_sk, 
        c_current_addr_sk, 
        c_first_name, 
        c_last_name
 FROM tpcds.customer 
 ORDER BY c_customer_id
SEGMENTED BY MODULARHASH (c_current_addr_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 c_customer_id ENCODING ZSTD_FAST_COMP, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_hdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING DELTAVAL, 
 c_first_name ENCODING ZSTD_FAST_COMP, 
 c_last_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT c_customer_id, 
        c_current_cdemo_sk, 
        c_current_hdemo_sk, 
        c_current_addr_sk, 
        c_first_name, 
        c_last_name
 FROM tpcds.customer 
 ORDER BY c_customer_id
SEGMENTED BY MODULARHASH (c_current_addr_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer');

CREATE PROJECTION store_returns_DBD_5_seg_DBD_TPCDS_INC3_b0 /*+basename(store_returns_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_cdemo_sk ENCODING RLE
)
AS
 SELECT sr_cdemo_sk
 FROM tpcds.store_returns 
 ORDER BY sr_cdemo_sk
SEGMENTED BY MODULARHASH (sr_cdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_returns_DBD_5_seg_DBD_TPCDS_INC3_b1 /*+basename(store_returns_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_cdemo_sk ENCODING RLE
)
AS
 SELECT sr_cdemo_sk
 FROM tpcds.store_returns 
 ORDER BY sr_cdemo_sk
SEGMENTED BY MODULARHASH (sr_cdemo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_returns');

--Q85








--Q86
--no need to do anything

--Q87







--Q88


CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE
)
AS
 SELECT ss_sold_time_sk, 
        ss_hdemo_sk, 
        ss_store_sk
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_sold_time_sk
SEGMENTED BY MODULARHASH (ss_hdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_1_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(store_sales_DBD_1_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 ss_sold_time_sk ENCODING DELTAVAL, 
 ss_hdemo_sk ENCODING RLE, 
 ss_store_sk ENCODING RLE
)
AS
 SELECT ss_sold_time_sk, 
        ss_hdemo_sk, 
        ss_store_sk
 FROM tpcds.store_sales 
 ORDER BY ss_hdemo_sk,
          ss_store_sk,
          ss_sold_time_sk
SEGMENTED BY MODULARHASH (ss_hdemo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');

CREATE PROJECTION time_dim_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 t_time_sk ENCODING COMMONDELTA_COMP, 
 t_hour ENCODING RLE, 
 t_minute ENCODING RLE
)
AS
 SELECT t_time_sk, 
        t_hour, 
        t_minute
 FROM tpcds.time_dim 
 ORDER BY t_hour,
          t_minute,
          t_time_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.time_dim');

--Q89
--no need to do anything

--Q90





CREATE PROJECTION household_demographics_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 hd_demo_sk ENCODING COMMONDELTA_COMP, 
 hd_dep_count ENCODING RLE
)
AS
 SELECT hd_demo_sk, 
        hd_dep_count
 FROM tpcds.household_demographics 
 ORDER BY hd_dep_count,
          hd_demo_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.household_demographics');

CREATE PROJECTION time_dim_DBD_2_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 t_time_sk ENCODING COMMONDELTA_COMP, 
 t_hour ENCODING RLE
)
AS
 SELECT t_time_sk, 
        t_hour
 FROM tpcds.time_dim 
 ORDER BY t_hour,
          t_time_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.time_dim');

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 ws_sold_time_sk ENCODING DELTARANGE_COMP, 
 ws_ship_hdemo_sk ENCODING RLE, 
 ws_web_page_sk ENCODING DELTAVAL
)
AS
 SELECT ws_sold_time_sk, 
        ws_ship_hdemo_sk, 
        ws_web_page_sk
 FROM tpcds.web_sales 
 ORDER BY ws_ship_hdemo_sk,
          ws_sold_time_sk,
          ws_web_page_sk
SEGMENTED BY MODULARHASH (ws_sold_time_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(web_sales_DBD_3_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 ws_sold_time_sk ENCODING DELTARANGE_COMP, 
 ws_ship_hdemo_sk ENCODING RLE, 
 ws_web_page_sk ENCODING DELTAVAL
)
AS
 SELECT ws_sold_time_sk, 
        ws_ship_hdemo_sk, 
        ws_web_page_sk
 FROM tpcds.web_sales 
 ORDER BY ws_ship_hdemo_sk,
          ws_sold_time_sk,
          ws_web_page_sk
SEGMENTED BY MODULARHASH (ws_sold_time_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

--Q91



CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cr_returned_date_sk ENCODING RLE, 
 cr_returning_customer_sk ENCODING DELTARANGE_COMP, 
 cr_call_center_sk ENCODING RLE, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_returned_date_sk, 
        cr_returning_customer_sk, 
        cr_call_center_sk, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_returned_date_sk,
          cr_call_center_sk,
          cr_returning_customer_sk
SEGMENTED BY MODULARHASH (cr_call_center_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cr_returned_date_sk ENCODING RLE, 
 cr_returning_customer_sk ENCODING DELTARANGE_COMP, 
 cr_call_center_sk ENCODING RLE, 
 cr_net_loss ENCODING DELTARANGE_COMP
)
AS
 SELECT cr_returned_date_sk, 
        cr_returning_customer_sk, 
        cr_call_center_sk, 
        cr_net_loss
 FROM tpcds.catalog_returns 
 ORDER BY cr_returned_date_sk,
          cr_call_center_sk,
          cr_returning_customer_sk
SEGMENTED BY MODULARHASH (cr_call_center_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_marital_status,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP, 
 cd_marital_status ENCODING RLE, 
 cd_education_status ENCODING RLE
)
AS
 SELECT cd_demo_sk, 
        cd_marital_status, 
        cd_education_status
 FROM tpcds.customer_demographics 
 ORDER BY cd_marital_status,
          cd_education_status,
          cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_demographics');

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_hdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_hdemo_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_current_addr_sk
SEGMENTED BY MODULARHASH (c_current_cdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_DBD_4_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
(
 c_customer_sk ENCODING DELTAVAL, 
 c_current_cdemo_sk ENCODING DELTAVAL, 
 c_current_hdemo_sk ENCODING DELTAVAL, 
 c_current_addr_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT c_customer_sk, 
        c_current_cdemo_sk, 
        c_current_hdemo_sk, 
        c_current_addr_sk
 FROM tpcds.customer 
 ORDER BY c_current_addr_sk
SEGMENTED BY MODULARHASH (c_current_cdemo_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer');

--Q92


CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ext_discount_amt
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_sold_date_sk,
          ws_ext_discount_amt
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_sales_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(web_sales_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ws_item_sk ENCODING RLE, 
 ws_sold_date_sk ENCODING DELTAVAL, 
 ws_ext_discount_amt ENCODING DELTARANGE_COMP
)
AS
 SELECT ws_item_sk, 
        ws_sold_date_sk, 
        ws_ext_discount_amt
 FROM tpcds.web_sales 
 ORDER BY ws_item_sk,
          ws_sold_date_sk,
          ws_ext_discount_amt
SEGMENTED BY MODULARHASH (ws_sold_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_sales');

--Q93


CREATE PROJECTION reason_DBD_1_rep_DBD_TPCDS_INC3 /*+createtype(D)*/
(
 r_reason_sk ENCODING COMMONDELTA_COMP, 
 r_reason_desc ENCODING ZSTD_FAST_COMP
)
AS
 SELECT r_reason_sk, 
        r_reason_desc
 FROM tpcds.reason 
 ORDER BY r_reason_desc,
          r_reason_sk
UNSEGMENTED ALL NODES;

select refresh('tpcds.reason');

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_customer_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk,
          ss_ticket_number
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number) ALL NODES OFFSET 0;

CREATE PROJECTION store_sales_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(store_sales_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ss_item_sk ENCODING RLE, 
 ss_ticket_number ENCODING DELTAVAL, 
 ss_customer_sk ENCODING DELTAVAL, 
 ss_quantity ENCODING DELTAVAL, 
 ss_sales_price ENCODING DELTAVAL
)
AS
 SELECT ss_item_sk, 
        ss_ticket_number, 
        ss_customer_sk, 
        ss_quantity, 
        ss_sales_price
 FROM tpcds.store_sales 
 ORDER BY ss_item_sk,
          ss_ticket_number
SEGMENTED BY MODULARHASH (ss_item_sk, ss_ticket_number) ALL NODES OFFSET 1;

select refresh('tpcds.store_sales');
--Q94


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
--Q95

--Q96
--no need to do anything
--Q97

--Q98
--no need to do anything

--Q99


CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cs_sold_date_sk ENCODING COMMONDELTA_COMP, 
 cs_ship_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ship_mode_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_date_sk, 
        cs_call_center_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_ship_mode_sk,
          cs_warehouse_sk,
          cs_sold_date_sk
SEGMENTED BY MODULARHASH (cs_ship_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cs_sold_date_sk ENCODING COMMONDELTA_COMP, 
 cs_ship_date_sk ENCODING RLE, 
 cs_call_center_sk ENCODING RLE, 
 cs_ship_mode_sk ENCODING RLE, 
 cs_warehouse_sk ENCODING RLE
)
AS
 SELECT cs_sold_date_sk, 
        cs_ship_date_sk, 
        cs_call_center_sk, 
        cs_ship_mode_sk, 
        cs_warehouse_sk
 FROM tpcds.catalog_sales 
 ORDER BY cs_ship_date_sk,
          cs_call_center_sk,
          cs_ship_mode_sk,
          cs_warehouse_sk,
          cs_sold_date_sk
SEGMENTED BY MODULARHASH (cs_ship_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_sales');