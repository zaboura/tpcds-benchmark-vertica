
select mark_design_ksafe(1);

CREATE PROJECTION tpcds.store_sales_DBD_17_seg_MC_TPCDS_COMP_b0 /*+basename(store_sales_DBD_17_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_ticket_number ENCODING DELTARANGE_COMP,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_sold_time_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING DELTAVAL,
 ss_cdemo_sk ENCODING DELTAVAL,
 ss_hdemo_sk ENCODING DELTAVAL,
 ss_addr_sk ENCODING DELTAVAL,
 ss_store_sk ENCODING RLE,
 ss_promo_sk ENCODING RLE,
 ss_quantity ENCODING RLE,
 ss_wholesale_cost ENCODING DELTAVAL,
 ss_list_price ENCODING DELTAVAL,
 ss_sales_price ENCODING DELTAVAL,
 ss_ext_discount_amt ENCODING ZSTD_FAST_COMP,
 ss_ext_sales_price ENCODING DELTAVAL,
 ss_ext_wholesale_cost ENCODING DELTAVAL,
 ss_ext_list_price ENCODING DELTAVAL,
 ss_ext_tax ENCODING ZSTD_FAST_COMP,
 ss_coupon_amt ENCODING ZSTD_FAST_COMP,
 ss_net_paid ENCODING DELTAVAL,
 ss_net_paid_inc_tax ENCODING DELTAVAL,
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_ticket_number,
        store_sales.ss_sold_date_sk,
        store_sales.ss_sold_time_sk,
        store_sales.ss_customer_sk,
        store_sales.ss_cdemo_sk,
        store_sales.ss_hdemo_sk,
        store_sales.ss_addr_sk,
        store_sales.ss_store_sk,
        store_sales.ss_promo_sk,
        store_sales.ss_quantity,
        store_sales.ss_wholesale_cost,
        store_sales.ss_list_price,
        store_sales.ss_sales_price,
        store_sales.ss_ext_discount_amt,
        store_sales.ss_ext_sales_price,
        store_sales.ss_ext_wholesale_cost,
        store_sales.ss_ext_list_price,
        store_sales.ss_ext_tax,
        store_sales.ss_coupon_amt,
        store_sales.ss_net_paid,
        store_sales.ss_net_paid_inc_tax,
        store_sales.ss_net_profit
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_quantity,
          store_sales.ss_store_sk,
          store_sales.ss_promo_sk,
          store_sales.ss_ticket_number,
          store_sales.ss_ext_discount_amt
SEGMENTED BY hash(store_sales.ss_ticket_number) ALL NODES OFFSET 0;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster

CREATE PROJECTION tpcds.store_sales_DBD_17_seg_MC_TPCDS_COMP_b1 /*+basename(store_sales_DBD_17_seg_MC_TPCDS_COMP),createtype(D)*/ 
(
 ss_item_sk ENCODING DELTAVAL,
 ss_ticket_number ENCODING DELTARANGE_COMP,
 ss_sold_date_sk ENCODING DELTAVAL,
 ss_sold_time_sk ENCODING DELTAVAL,
 ss_customer_sk ENCODING DELTAVAL,
 ss_cdemo_sk ENCODING DELTAVAL,
 ss_hdemo_sk ENCODING DELTAVAL,
 ss_addr_sk ENCODING DELTAVAL,
 ss_store_sk ENCODING RLE,
 ss_promo_sk ENCODING RLE,
 ss_quantity ENCODING RLE,
 ss_wholesale_cost ENCODING DELTAVAL,
 ss_list_price ENCODING DELTAVAL,
 ss_sales_price ENCODING DELTAVAL,
 ss_ext_discount_amt ENCODING ZSTD_FAST_COMP,
 ss_ext_sales_price ENCODING DELTAVAL,
 ss_ext_wholesale_cost ENCODING DELTAVAL,
 ss_ext_list_price ENCODING DELTAVAL,
 ss_ext_tax ENCODING ZSTD_FAST_COMP,
 ss_coupon_amt ENCODING ZSTD_FAST_COMP,
 ss_net_paid ENCODING DELTAVAL,
 ss_net_paid_inc_tax ENCODING DELTAVAL,
 ss_net_profit ENCODING DELTAVAL
)
AS
 SELECT store_sales.ss_item_sk,
        store_sales.ss_ticket_number,
        store_sales.ss_sold_date_sk,
        store_sales.ss_sold_time_sk,
        store_sales.ss_customer_sk,
        store_sales.ss_cdemo_sk,
        store_sales.ss_hdemo_sk,
        store_sales.ss_addr_sk,
        store_sales.ss_store_sk,
        store_sales.ss_promo_sk,
        store_sales.ss_quantity,
        store_sales.ss_wholesale_cost,
        store_sales.ss_list_price,
        store_sales.ss_sales_price,
        store_sales.ss_ext_discount_amt,
        store_sales.ss_ext_sales_price,
        store_sales.ss_ext_wholesale_cost,
        store_sales.ss_ext_list_price,
        store_sales.ss_ext_tax,
        store_sales.ss_coupon_amt,
        store_sales.ss_net_paid,
        store_sales.ss_net_paid_inc_tax,
        store_sales.ss_net_profit
 FROM tpcds.store_sales
 ORDER BY store_sales.ss_quantity,
          store_sales.ss_store_sk,
          store_sales.ss_promo_sk,
          store_sales.ss_ticket_number,
          store_sales.ss_ext_discount_amt
SEGMENTED BY hash(store_sales.ss_ticket_number) ALL NODES OFFSET 1;



\echo NOTICE: The above create projection statement could error out if design created and implemented in the same cluster


select mark_design_ksafe(1);

