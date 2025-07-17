

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cr_item_sk ENCODING DELTARANGE_COMP, 
 cr_returned_date_sk ENCODING RLE, 
 cr_return_quantity ENCODING RLE
)
AS
 SELECT cr_item_sk, 
        cr_returned_date_sk, 
        cr_return_quantity
 FROM tpcds.catalog_returns 
 ORDER BY cr_returned_date_sk,
          cr_return_quantity,
          cr_item_sk
SEGMENTED BY MODULARHASH (cr_returned_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
(
 cr_item_sk ENCODING DELTARANGE_COMP, 
 cr_returned_date_sk ENCODING RLE, 
 cr_return_quantity ENCODING RLE
)
AS
 SELECT cr_item_sk, 
        cr_returned_date_sk, 
        cr_return_quantity
 FROM tpcds.catalog_returns 
 ORDER BY cr_returned_date_sk,
          cr_return_quantity,
          cr_item_sk
SEGMENTED BY MODULARHASH (cr_returned_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.catalog_returns');

CREATE PROJECTION date_dim_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(date_dim_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date
 FROM tpcds.date_dim 
 ORDER BY d_date_sk
SEGMENTED BY HASH (d_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION date_dim_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(date_dim_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 d_date_sk ENCODING COMMONDELTA_COMP, 
 d_date ENCODING COMMONDELTA_COMP
)
AS
 SELECT d_date_sk, 
        d_date
 FROM tpcds.date_dim 
 ORDER BY d_date_sk
SEGMENTED BY HASH (d_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.date_dim');

CREATE PROJECTION web_returns_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(web_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 wr_item_sk ENCODING DELTARANGE_COMP, 
 wr_returned_date_sk ENCODING RLE, 
 wr_return_quantity ENCODING RLE
)
AS
 SELECT wr_item_sk, 
        wr_returned_date_sk, 
        wr_return_quantity
 FROM tpcds.web_returns 
 ORDER BY wr_returned_date_sk,
          wr_return_quantity,
          wr_item_sk
SEGMENTED BY MODULARHASH (wr_returned_date_sk) ALL NODES OFFSET 0;

CREATE PROJECTION web_returns_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(web_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
(
 wr_item_sk ENCODING DELTARANGE_COMP, 
 wr_returned_date_sk ENCODING RLE, 
 wr_return_quantity ENCODING RLE
)
AS
 SELECT wr_item_sk, 
        wr_returned_date_sk, 
        wr_return_quantity
 FROM tpcds.web_returns 
 ORDER BY wr_returned_date_sk,
          wr_return_quantity,
          wr_item_sk
SEGMENTED BY MODULARHASH (wr_returned_date_sk) ALL NODES OFFSET 1;

select refresh('tpcds.web_returns');