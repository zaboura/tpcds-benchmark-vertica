
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b0 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
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

CREATE PROJECTION tpcds.catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2_b1 /*+basename(catalog_returns_DBD_1_seg_DBD_TPCDS_INC3_v2),createtype(D)*/
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

CREATE PROJECTION tpcds.date_dim_DBD_4_seg_DBD_TPCDS_INC3_b0 /*+basename(date_dim_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.date_dim_DBD_4_seg_DBD_TPCDS_INC3_b1 /*+basename(date_dim_DBD_4_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.web_returns_DBD_2_seg_DBD_TPCDS_INC3_b0 /*+basename(web_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.web_returns_DBD_2_seg_DBD_TPCDS_INC3_b1 /*+basename(web_returns_DBD_2_seg_DBD_TPCDS_INC3),createtype(D)*/
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

CREATE PROJECTION tpcds.date_dim_DBD_8_rep_MC_TPCDS_COMP /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date_id ENCODING ZSTD_FAST_COMP,
 d_date ENCODING COMMONDELTA_COMP,
 d_month_seq ENCODING COMMONDELTA_COMP,
 d_week_seq ENCODING COMMONDELTA_COMP,
 d_quarter_seq ENCODING COMMONDELTA_COMP,
 d_year ENCODING COMMONDELTA_COMP,
 d_dow ENCODING RLE,
 d_moy ENCODING COMMONDELTA_COMP,
 d_dom ENCODING COMMONDELTA_COMP,
 d_qoy ENCODING RLE,
 d_fy_year ENCODING COMMONDELTA_COMP,
 d_fy_quarter_seq ENCODING COMMONDELTA_COMP,
 d_fy_week_seq ENCODING COMMONDELTA_COMP,
 d_day_name ENCODING ZSTD_FAST_COMP,
 d_quarter_name ENCODING ZSTD_FAST_COMP,
 d_holiday ENCODING RLE,
 d_weekend ENCODING RLE,
 d_following_holiday ENCODING RLE,
 d_first_dom ENCODING COMMONDELTA_COMP,
 d_last_dom ENCODING COMMONDELTA_COMP,
 d_same_day_ly ENCODING COMMONDELTA_COMP,
 d_same_day_lq ENCODING COMMONDELTA_COMP,
 d_current_day ENCODING RLE,
 d_current_week ENCODING RLE,
 d_current_month ENCODING RLE,
 d_current_quarter ENCODING RLE,
 d_current_year ENCODING RLE
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date_id,
        date_dim.d_date,
        date_dim.d_month_seq,
        date_dim.d_week_seq,
        date_dim.d_quarter_seq,
        date_dim.d_year,
        date_dim.d_dow,
        date_dim.d_moy,
        date_dim.d_dom,
        date_dim.d_qoy,
        date_dim.d_fy_year,
        date_dim.d_fy_quarter_seq,
        date_dim.d_fy_week_seq,
        date_dim.d_day_name,
        date_dim.d_quarter_name,
        date_dim.d_holiday,
        date_dim.d_weekend,
        date_dim.d_following_holiday,
        date_dim.d_first_dom,
        date_dim.d_last_dom,
        date_dim.d_same_day_ly,
        date_dim.d_same_day_lq,
        date_dim.d_current_day,
        date_dim.d_current_week,
        date_dim.d_current_month,
        date_dim.d_current_quarter,
        date_dim.d_current_year
 FROM tpcds.date_dim
 ORDER BY date_dim.d_current_day,
          date_dim.d_current_week,
          date_dim.d_holiday,
          date_dim.d_weekend,
          date_dim.d_following_holiday,
          date_dim.d_current_month,
          date_dim.d_current_quarter,
          date_dim.d_current_year,
          date_dim.d_qoy,
          date_dim.d_dow,
          date_dim.d_date
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_returns_DBD_3_seg_DBD_TPCDS_INC_b0 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 sr_item_sk ENCODING GCDDELTA,
 sr_ticket_number ENCODING DELTAVAL,
 sr_returned_date_sk ENCODING RLE,
 sr_customer_sk ENCODING DELTAVAL,
 sr_return_quantity ENCODING RLE
)
AS
 SELECT store_returns.sr_item_sk,
        store_returns.sr_ticket_number,
        store_returns.sr_returned_date_sk,
        store_returns.sr_customer_sk,
        store_returns.sr_return_quantity
 FROM tpcds.store_returns
 ORDER BY store_returns.sr_returned_date_sk,
          store_returns.sr_return_quantity,
          store_returns.sr_ticket_number
SEGMENTED BY hash(store_returns.sr_item_sk, store_returns.sr_ticket_number, store_returns.sr_customer_sk) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_returns_DBD_3_seg_DBD_TPCDS_INC_b1 /*+basename(store_returns_DBD_3_seg_DBD_TPCDS_INC),createtype(D)*/ 
(
 sr_item_sk ENCODING GCDDELTA,
 sr_ticket_number ENCODING DELTAVAL,
 sr_returned_date_sk ENCODING RLE,
 sr_customer_sk ENCODING DELTAVAL,
 sr_return_quantity ENCODING RLE
)
AS
 SELECT store_returns.sr_item_sk,
        store_returns.sr_ticket_number,
        store_returns.sr_returned_date_sk,
        store_returns.sr_customer_sk,
        store_returns.sr_return_quantity
 FROM tpcds.store_returns
 ORDER BY store_returns.sr_returned_date_sk,
          store_returns.sr_return_quantity,
          store_returns.sr_ticket_number
SEGMENTED BY hash(store_returns.sr_item_sk, store_returns.sr_ticket_number, store_returns.sr_customer_sk) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.item_DBD_2_rep_DBD_TPCDS_INC2 /*+createtype(D)*/ 
(
 i_item_sk ENCODING COMMONDELTA_COMP,
 i_item_id ENCODING ZSTD_FAST_COMP
)
AS
 SELECT item.i_item_sk,
        item.i_item_id
 FROM tpcds.item
 ORDER BY item.i_item_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.date_dim_DBD_1_rep_DBD_TPCDS_INC2_v2 /*+createtype(D)*/ 
(
 d_date_sk ENCODING COMMONDELTA_COMP,
 d_date ENCODING COMMONDELTA_COMP,
 d_week_seq ENCODING COMMONDELTA_COMP
)
AS
 SELECT date_dim.d_date_sk,
        date_dim.d_date,
        date_dim.d_week_seq
 FROM tpcds.date_dim
 ORDER BY date_dim.d_date,
          date_dim.d_date_sk
UNSEGMENTED ALL NODES;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

