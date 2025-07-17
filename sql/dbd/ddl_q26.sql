
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5),createtype(D)*/
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

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v5),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_2_seg_DBD_TPCDS_INC_b0 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_2_seg_DBD_TPCDS_INC_b1 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.item_DBD_12_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_item_id ENCODING ZSTD_FAST_COMP,
 i_rec_start_date ENCODING RLE,
 i_rec_end_date ENCODING RLE,
 i_item_desc ENCODING ZSTD_FAST_COMP,
 i_current_price ENCODING DELTARANGE_COMP,
 i_wholesale_cost ENCODING DELTARANGE_COMP,
 i_brand_id ENCODING BLOCKDICT_COMP,
 i_brand ENCODING ZSTD_FAST_COMP,
 i_class_id ENCODING BLOCKDICT_COMP,
 i_class ENCODING ZSTD_FAST_COMP,
 i_category_id ENCODING RLE,
 i_category ENCODING ZSTD_FAST_COMP,
 i_manufact_id ENCODING DELTAVAL,
 i_manufact ENCODING ZSTD_FAST_COMP,
 i_size ENCODING RLE,
 i_formulation ENCODING ZSTD_FAST_COMP,
 i_color ENCODING ZSTD_FAST_COMP,
 i_units ENCODING ZSTD_FAST_COMP,
 i_container ENCODING RLE,
 i_manager_id ENCODING DELTAVAL,
 i_product_name ENCODING ZSTD_FAST_COMP
)
AS
 SELECT item.i_item_sk,
        item.i_item_id,
        item.i_rec_start_date,
        item.i_rec_end_date,
        item.i_item_desc,
        item.i_current_price,
        item.i_wholesale_cost,
        item.i_brand_id,
        item.i_brand,
        item.i_class_id,
        item.i_class,
        item.i_category_id,
        item.i_category,
        item.i_manufact_id,
        item.i_manufact,
        item.i_size,
        item.i_formulation,
        item.i_color,
        item.i_units,
        item.i_container,
        item.i_manager_id,
        item.i_product_name
 FROM tpcds.item
 ORDER BY item.i_container,
          item.i_rec_end_date,
          item.i_rec_start_date,
          item.i_size,
          item.i_category_id,
          item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.promotion_DBD_13_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 p_promo_sk ENCODING COMMONDELTA_COMP,
 p_promo_id ENCODING ZSTD_FAST_COMP,
 p_start_date_sk ENCODING DELTAVAL,
 p_end_date_sk ENCODING DELTAVAL,
 p_item_sk ENCODING DELTAVAL,
 p_cost ENCODING RLE,
 p_response_target ENCODING RLE,
 p_promo_name ENCODING ZSTD_FAST_COMP,
 p_channel_dmail ENCODING ZSTD_FAST_COMP,
 p_channel_email ENCODING RLE,
 p_channel_catalog ENCODING RLE,
 p_channel_tv ENCODING RLE,
 p_channel_radio ENCODING RLE,
 p_channel_press ENCODING RLE,
 p_channel_event,
 p_channel_demo,
 p_channel_details ENCODING ZSTD_FAST_COMP,
 p_purpose ENCODING ZSTD_FAST_COMP,
 p_discount_active
)
AS
 SELECT promotion.p_promo_sk,
        promotion.p_promo_id,
        promotion.p_start_date_sk,
        promotion.p_end_date_sk,
        promotion.p_item_sk,
        promotion.p_cost,
        promotion.p_response_target,
        promotion.p_promo_name,
        promotion.p_channel_dmail,
        promotion.p_channel_email,
        promotion.p_channel_catalog,
        promotion.p_channel_tv,
        promotion.p_channel_radio,
        promotion.p_channel_press,
        promotion.p_channel_event,
        promotion.p_channel_demo,
        promotion.p_channel_details,
        promotion.p_purpose,
        promotion.p_discount_active
 FROM tpcds.promotion
 ORDER BY promotion.p_cost,
          promotion.p_response_target,
          promotion.p_channel_email,
          promotion.p_channel_catalog,
          promotion.p_channel_tv,
          promotion.p_channel_radio,
          promotion.p_channel_press,
          promotion.p_promo_id
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_4_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

