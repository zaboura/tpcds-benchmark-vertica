select  a.ca_state state, count(*) cnt
 from tpcds.customer_address a
     ,tpcds.customer c
     ,tpcds.store_sales s
     ,tpcds.date_dim d
     ,tpcds.item i
 where a.ca_address_sk = c.c_current_addr_sk
 	and c.c_customer_sk = s.ss_customer_sk
 	and s.ss_sold_date_sk = d.d_date_sk
 	and s.ss_item_sk = i.i_item_sk
 	and d.d_month_seq = 
 	     (select distinct (d_month_seq)
 	      from tpcds.date_dim
               where d_year = 2001
 	        and d_moy = 1 )
 	and i.i_current_price > 1.2 * 
             (select avg(j.i_current_price) 
 	     from tpcds.item j 
 	     where j.i_category = i.i_category)
 group by a.ca_state
 having count(*) >= 10
 order by cnt, a.ca_state 
 limit 100;


