

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