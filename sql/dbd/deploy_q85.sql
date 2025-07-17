

CREATE PROJECTION customer_address_DBD_1_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_address_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_state ENCODING ZSTD_FAST_COMP, 
 ca_country ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state, 
        ca_country
 FROM tpcds.customer_address 
 ORDER BY ca_country,
          ca_address_sk
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 0;

CREATE PROJECTION customer_address_DBD_1_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_address_DBD_1_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 ca_address_sk ENCODING COMMONDELTA_COMP, 
 ca_state ENCODING ZSTD_FAST_COMP, 
 ca_country ENCODING RLE
)
AS
 SELECT ca_address_sk, 
        ca_state, 
        ca_country
 FROM tpcds.customer_address 
 ORDER BY ca_country,
          ca_address_sk
SEGMENTED BY MODULARHASH (ca_address_sk) ALL NODES OFFSET 1;

select refresh('tpcds.customer_address');

CREATE PROJECTION customer_demographics_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION customer_demographics_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(customer_demographics_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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