

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