
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
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

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_DBD_4_seg_DBD_TPCDS_INC3_v1_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_DBD_4_seg_DBD_TPCDS_INC3_v1_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3_v1),createtype(D)*/
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

CREATE PROJECTION tpcds.call_center_DBD_1_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 cc_call_center_sk,
 cc_call_center_id ENCODING ZSTD_FAST_COMP,
 cc_rec_start_date ENCODING COMMONDELTA_COMP,
 cc_rec_end_date ENCODING BLOCKDICT_COMP,
 cc_closed_date_sk ENCODING RLE,
 cc_open_date_sk,
 cc_name ENCODING ZSTD_FAST_COMP,
 cc_class ENCODING RLE,
 cc_employees,
 cc_sq_ft,
 cc_hours ENCODING ZSTD_FAST_COMP,
 cc_manager ENCODING ZSTD_FAST_COMP,
 cc_mkt_id,
 cc_mkt_class ENCODING ZSTD_FAST_COMP,
 cc_mkt_desc ENCODING ZSTD_FAST_COMP,
 cc_market_manager ENCODING ZSTD_FAST_COMP,
 cc_division,
 cc_division_name,
 cc_company,
 cc_company_name,
 cc_street_number ENCODING ZSTD_FAST_COMP,
 cc_street_name ENCODING ZSTD_FAST_COMP,
 cc_street_type,
 cc_suite_number,
 cc_city ENCODING ZSTD_FAST_COMP,
 cc_county ENCODING ZSTD_FAST_COMP,
 cc_state ENCODING ZSTD_FAST_COMP,
 cc_zip ENCODING ZSTD_FAST_COMP,
 cc_country ENCODING RLE,
 cc_gmt_offset ENCODING RLE,
 cc_tax_percentage
)
AS
 SELECT call_center.cc_call_center_sk,
        call_center.cc_call_center_id,
        call_center.cc_rec_start_date,
        call_center.cc_rec_end_date,
        call_center.cc_closed_date_sk,
        call_center.cc_open_date_sk,
        call_center.cc_name,
        call_center.cc_class,
        call_center.cc_employees,
        call_center.cc_sq_ft,
        call_center.cc_hours,
        call_center.cc_manager,
        call_center.cc_mkt_id,
        call_center.cc_mkt_class,
        call_center.cc_mkt_desc,
        call_center.cc_market_manager,
        call_center.cc_division,
        call_center.cc_division_name,
        call_center.cc_company,
        call_center.cc_company_name,
        call_center.cc_street_number,
        call_center.cc_street_name,
        call_center.cc_street_type,
        call_center.cc_suite_number,
        call_center.cc_city,
        call_center.cc_county,
        call_center.cc_state,
        call_center.cc_zip,
        call_center.cc_country,
        call_center.cc_gmt_offset,
        call_center.cc_tax_percentage
 FROM tpcds.call_center
 ORDER BY call_center.cc_closed_date_sk,
          call_center.cc_country,
          call_center.cc_class,
          call_center.cc_gmt_offset,
          call_center.cc_call_center_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.household_demographics_DBD_9_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 hd_demo_sk ENCODING COMMONDELTA_COMP,
 hd_income_band_sk ENCODING COMMONDELTA_COMP,
 hd_buy_potential ENCODING RLE,
 hd_dep_count ENCODING RLE,
 hd_vehicle_count ENCODING RLE
)
AS
 SELECT household_demographics.hd_demo_sk,
        household_demographics.hd_income_band_sk,
        household_demographics.hd_buy_potential,
        household_demographics.hd_dep_count,
        household_demographics.hd_vehicle_count
 FROM tpcds.household_demographics
 ORDER BY household_demographics.hd_buy_potential,
          household_demographics.hd_vehicle_count,
          household_demographics.hd_dep_count,
          household_demographics.hd_demo_sk
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

