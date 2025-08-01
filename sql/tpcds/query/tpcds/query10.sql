select  
  cd_gender,
  cd_marital_status,
  cd_education_status,
  count(*) cnt1,
  cd_purchase_estimate,
  count(*) cnt2,
  cd_credit_rating,
  count(*) cnt3,
  cd_dep_count,
  count(*) cnt4,
  cd_dep_employed_count,
  count(*) cnt5,
  cd_dep_college_count,
  count(*) cnt6
 from
  tpcds.customer c,tpcds.customer_address ca,tpcds.customer_demographics
 where
  c.c_current_addr_sk = ca.ca_address_sk and
  ca_county in ('Rush County','Toole County','Jefferson County','Dona Ana County','La Porte County') and
  cd_demo_sk = c.c_current_cdemo_sk and 
  exists (select *
          from tpcds.store_sales,tpcds.date_dim
          where c.c_customer_sk = ss_customer_sk and
                ss_sold_date_sk = d_date_sk and
                d_year = 2002 and
                d_moy between 1 and 1+3) and
   exists (select *
          from (
             select ws_bill_customer_sk as customer_sk, d_year,d_moy
             from tpcds.web_sales, tpcds.date_dim where ws_sold_date_sk = d_date_sk
              and d_year = 2002 and
                  d_moy between 1 and 1+3
             union all
             select cs_ship_customer_sk as customer_sk, d_year, d_moy
             from tpcds.catalog_sales, tpcds.date_dim where cs_sold_date_sk = d_date_sk
              and d_year = 2002 and
                  d_moy between 1 and 1+3
	     ) x
            where c.c_customer_sk = customer_sk)
 group by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 order by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
limit 100;


