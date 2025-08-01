select  cast(amc as decimal(15,4))/cast(pmc as decimal(15,4)) am_pm_ratio
 from ( select count(*) amc
       from tpcds.web_sales, 
       tpcds.household_demographics , 
       tpcds.time_dim, 
       tpcds.web_page
       where ws_sold_time_sk = time_dim.t_time_sk
         and ws_ship_hdemo_sk = household_demographics.hd_demo_sk
         and ws_web_page_sk = web_page.wp_web_page_sk
         and time_dim.t_hour between 8 and 8+1
         and household_demographics.hd_dep_count = 6
         and web_page.wp_char_count between 5000 and 5200) at,
      ( select count(*) pmc
       from tpcds.web_sales, 
       tpcds.household_demographics , 
       tpcds.time_dim, 
       tpcds.web_page
       where ws_sold_time_sk = time_dim.t_time_sk
         and ws_ship_hdemo_sk = household_demographics.hd_demo_sk
         and ws_web_page_sk = web_page.wp_web_page_sk
         and time_dim.t_hour between 19 and 19+1
         and household_demographics.hd_dep_count = 6
         and web_page.wp_char_count between 5000 and 5200) pt
 order by am_pm_ratio
 limit 100;


