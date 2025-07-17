select  count(*) from (
    select distinct c_last_name, c_first_name, d_date
    from tpcds.store_sales, tpcds.date_dim, tpcds.customer
          where tpcds.store_sales.ss_sold_date_sk = tpcds.date_dim.d_date_sk
      and tpcds.store_sales.ss_customer_sk = tpcds.customer.c_customer_sk
      and d_month_seq between 1200 and 1200 + 11
  intersect
    select distinct c_last_name, c_first_name, d_date
    from tpcds.catalog_sales, tpcds.date_dim, tpcds.customer
          where tpcds.catalog_sales.cs_sold_date_sk = tpcds.date_dim.d_date_sk
      and tpcds.catalog_sales.cs_bill_customer_sk = tpcds.customer.c_customer_sk
      and d_month_seq between 1200 and 1200 + 11
  intersect
    select distinct c_last_name, c_first_name, d_date
    from tpcds.web_sales, tpcds.date_dim, tpcds.customer
          where tpcds.web_sales.ws_sold_date_sk = tpcds.date_dim.d_date_sk
      and tpcds.web_sales.ws_bill_customer_sk = tpcds.customer.c_customer_sk
      and d_month_seq between 1200 and 1200 + 11
) hot_cust
limit 100;


