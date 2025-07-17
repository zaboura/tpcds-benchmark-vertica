
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b0 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/
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

CREATE PROJECTION tpcds.catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3_b1 /*+basename(catalog_sales_DBD_1_seg_DBD_TPCDS_INC_v3),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_address_DBD_2_rep_DBD_TPCDS_INC_v2 /*+createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_DBD_4_seg_DBD_TPCDS_INC_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_DBD_4_seg_DBD_TPCDS_INC_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_6_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 cd_demo_sk ENCODING COMMONDELTA_COMP,
 cd_gender ENCODING RLE,
 cd_marital_status ENCODING RLE,
 cd_education_status ENCODING RLE,
 cd_purchase_estimate ENCODING COMMONDELTA_COMP,
 cd_credit_rating ENCODING RLE,
 cd_dep_count ENCODING RLE,
 cd_dep_employed_count ENCODING RLE,
 cd_dep_college_count ENCODING RLE
)
AS
 SELECT customer_demographics.cd_demo_sk,
        customer_demographics.cd_gender,
        customer_demographics.cd_marital_status,
        customer_demographics.cd_education_status,
        customer_demographics.cd_purchase_estimate,
        customer_demographics.cd_credit_rating,
        customer_demographics.cd_dep_count,
        customer_demographics.cd_dep_employed_count,
        customer_demographics.cd_dep_college_count
 FROM tpcds.customer_demographics
 ORDER BY customer_demographics.cd_gender,
          customer_demographics.cd_credit_rating,
          customer_demographics.cd_marital_status,
          customer_demographics.cd_education_status,
          customer_demographics.cd_dep_count,
          customer_demographics.cd_dep_employed_count,
          customer_demographics.cd_dep_college_count,
          customer_demographics.cd_demo_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

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

CREATE PROJECTION tpcds.date_dim_DBD_2_rep_DBD_TPCDS_INC /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING RLE,
 d_moy ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_month_seq,
        date_dim.d_year,
        date_dim.d_moy
 FROM tpcds.date_dim
 ORDER BY date_dim.d_year,
          date_dim.d_moy,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

