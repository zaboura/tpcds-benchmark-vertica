

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