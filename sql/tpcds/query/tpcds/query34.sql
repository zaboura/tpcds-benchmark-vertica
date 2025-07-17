SELECT c_last_name, 
       c_first_name, 
       c_salutation, 
       c_preferred_cust_flag, 
       ss_ticket_number, 
       cnt 
FROM   (SELECT ss_ticket_number, 
               ss_customer_sk, 
               Count(*) cnt 
        FROM   tpcds.store_sales, 
               tpcds.date_dim, 
               tpcds.store, 
               tpcds.household_demographics 
        WHERE  tpcds.store_sales.ss_sold_date_sk = tpcds.date_dim.d_date_sk 
               AND tpcds.store_sales.ss_store_sk = tpcds.store.s_store_sk 
               AND tpcds.store_sales.ss_hdemo_sk = tpcds.household_demographics.hd_demo_sk 
               AND ( tpcds.date_dim.d_dom BETWEEN 1 AND 3 
                      OR tpcds.date_dim.d_dom BETWEEN 25 AND 28 ) 
               AND ( tpcds.household_demographics.hd_buy_potential = '>10000' 
                      OR tpcds.household_demographics.hd_buy_potential = 'unknown' ) 
               AND tpcds.household_demographics.hd_vehicle_count > 0 
               AND ( CASE 
                       WHEN tpcds.household_demographics.hd_vehicle_count > 0 THEN 
                       tpcds.household_demographics.hd_dep_count / 
                       tpcds.household_demographics.hd_vehicle_count 
                       ELSE NULL 
                     END ) > 1.2 
               AND tpcds.date_dim.d_year IN ( 1999, 1999 + 1, 1999 + 2 ) 
               AND tpcds.store.s_county IN ( 'Williamson County', 'Williamson County', 
                                             'Williamson County', 'Williamson County' 
                                             , 
                                             'Williamson County', 'Williamson County', 
                                             'Williamson County', 'Williamson County' 
                                           ) 
        GROUP  BY ss_ticket_number, 
                  ss_customer_sk) dn, 
       tpcds.customer 
WHERE  ss_customer_sk = c_customer_sk 
       AND cnt BETWEEN 15 AND 20 
ORDER  BY c_last_name, 
          c_first_name, 
          c_salutation, 
          c_preferred_cust_flag DESC;
