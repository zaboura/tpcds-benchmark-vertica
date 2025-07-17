select  dt.d_year 
       ,tpcds.item.i_brand_id brand_id 
       ,tpcds.item.i_brand brand
       ,sum(ss_ext_sales_price) sum_agg
 from  tpcds.date_dim dt 
      ,tpcds.store_sales
      ,tpcds.item
 where dt.d_date_sk = tpcds.store_sales.ss_sold_date_sk
   and tpcds.store_sales.ss_item_sk = tpcds.item.i_item_sk
   and tpcds.item.i_manufact_id = 128
   and dt.d_moy=11
 group by dt.d_year
      ,tpcds.item.i_brand
      ,tpcds.item.i_brand_id
 order by dt.d_year
         ,sum_agg desc
         ,brand_id
 limit 100;


