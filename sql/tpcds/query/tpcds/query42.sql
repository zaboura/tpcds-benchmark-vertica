select  dt.d_year
 	,tpcds.item.i_category_id
 	,tpcds.item.i_category
 	,sum(ss_ext_sales_price)
 from 	tpcds.date_dim dt
 	,tpcds.store_sales
 	,tpcds.item
 where dt.d_date_sk = tpcds.store_sales.ss_sold_date_sk
 	and tpcds.store_sales.ss_item_sk = tpcds.item.i_item_sk
 	and tpcds.item.i_manager_id = 1  	
 	and dt.d_moy=11
 	and dt.d_year=2000
 group by 	dt.d_year
 		,tpcds.item.i_category_id
 		,tpcds.item.i_category
 order by       sum(ss_ext_sales_price) desc,dt.d_year
 		,tpcds.item.i_category_id
 		,tpcds.item.i_category
limit 100 ;


