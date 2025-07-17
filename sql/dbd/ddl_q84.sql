
select mark_design_ksafe(1);

CREATE PROJECTION public.household_demographics_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(household_demographics_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION public.household_demographics_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(household_demographics_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_address_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_address_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_address_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk
 FROM tpcds.customer_demographics 
 ORDER BY cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.customer_demographics_DBD_3_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_demographics_DBD_3_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 cd_demo_sk ENCODING COMMONDELTA_COMP
)
AS
 SELECT cd_demo_sk
 FROM tpcds.customer_demographics 
 ORDER BY cd_demo_sk
SEGMENTED BY MODULARHASH (cd_demo_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.customer_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.customer_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.store_returns_DBD_5_seg_DBD_TPCDS_INC3_b0 /*+basename(store_returns_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_cdemo_sk ENCODING RLE
)
AS
 SELECT sr_cdemo_sk
 FROM tpcds.store_returns 
 ORDER BY sr_cdemo_sk
SEGMENTED BY MODULARHASH (sr_cdemo_sk) ALL NODES OFFSET 0;

CREATE PROJECTION tpcds.store_returns_DBD_5_seg_DBD_TPCDS_INC3_b1 /*+basename(store_returns_DBD_5_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 sr_cdemo_sk ENCODING RLE
)
AS
 SELECT sr_cdemo_sk
 FROM tpcds.store_returns 
 ORDER BY sr_cdemo_sk
SEGMENTED BY MODULARHASH (sr_cdemo_sk) ALL NODES OFFSET 1;

CREATE PROJECTION tpcds.income_band_DBD_10_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 ib_income_band_sk ENCODING COMMONDELTA_COMP,
 ib_lower_bound ENCODING COMMONDELTA_COMP,
 ib_upper_bound ENCODING COMMONDELTA_COMP
)
AS
 SELECT income_band.ib_income_band_sk,
        income_band.ib_lower_bound,
        income_band.ib_upper_bound
 FROM tpcds.income_band
 ORDER BY income_band.ib_upper_bound
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

