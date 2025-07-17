

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