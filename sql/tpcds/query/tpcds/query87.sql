select count(*) 
from ((select distinct c_last_name, c_first_name, d_date
       from tpcds.store_sales, 
       tpcds.date_dim, 
       tpcds.customer
       where store_sales.ss_sold_date_sk = date_dim.d_date_sk
         and store_sales.ss_customer_sk = customer.c_customer_sk
         and d_month_seq between 1200 and 1200+11)
       except
      (select distinct c_last_name, c_first_name, d_date
       from tpcds.catalog_sales, 
       tpcds.date_dim, 
       tpcds.customer
       where catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
         and catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
         and d_month_seq between 1200 and 1200+11)
       except
      (select distinct c_last_name, c_first_name, d_date
       from tpcds.web_sales, 
       tpcds.date_dim, 
       tpcds.customer
       where web_sales.ws_sold_date_sk = date_dim.d_date_sk
         and web_sales.ws_bill_customer_sk = customer.c_customer_sk
         and d_month_seq between 1200 and 1200+11)
) cool_cust
;


