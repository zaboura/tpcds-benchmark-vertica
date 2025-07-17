WITH ss AS
 (SELECT s_store_sk,
         SUM(ss_ext_sales_price) AS sales,
         SUM(ss_net_profit) AS profit
  FROM tpcds.store_sales,
       tpcds.date_dim,
       tpcds.store
  WHERE ss_sold_date_sk = d_date_sk
        AND d_date BETWEEN CAST('2000-08-23' AS DATE)
                        AND CAST('2000-08-23' AS DATE) + INTERVAL '30' DAY
        AND ss_store_sk = s_store_sk
  GROUP BY s_store_sk),
 sr AS
 (SELECT s_store_sk,
         SUM(sr_return_amt) AS returns,
         SUM(sr_net_loss) AS profit_loss
  FROM tpcds.store_returns,
       tpcds.date_dim,
       tpcds.store
  WHERE sr_returned_date_sk = d_date_sk
        AND d_date BETWEEN CAST('2000-08-23' AS DATE)
                        AND CAST('2000-08-23' AS DATE) + INTERVAL '30' DAY
        AND sr_store_sk = s_store_sk
  GROUP BY s_store_sk), 
 cs AS
 (SELECT cs_call_center_sk,
         SUM(cs_ext_sales_price) AS sales,
         SUM(cs_net_profit) AS profit
  FROM tpcds.catalog_sales,
       tpcds.date_dim
  WHERE cs_sold_date_sk = d_date_sk
        AND d_date BETWEEN CAST('2000-08-23' AS DATE)
                        AND CAST('2000-08-23' AS DATE) + INTERVAL '30' DAY
  GROUP BY cs_call_center_sk 
 ), 
 cr AS
 (SELECT cr_call_center_sk,
         SUM(cr_return_amount) AS returns,
         SUM(cr_net_loss) AS profit_loss
  FROM tpcds.catalog_returns,
       tpcds.date_dim
  WHERE cr_returned_date_sk = d_date_sk
        AND d_date BETWEEN CAST('2000-08-23' AS DATE)
                        AND CAST('2000-08-23' AS DATE) + INTERVAL '30' DAY
  GROUP BY cr_call_center_sk
 ), 
 ws AS
 ( SELECT wp_web_page_sk,
         SUM(ws_ext_sales_price) AS sales,
         SUM(ws_net_profit) AS profit
  FROM tpcds.web_sales,
       tpcds.date_dim,
       tpcds.web_page
  WHERE ws_sold_date_sk = d_date_sk
        AND d_date BETWEEN CAST('2000-08-23' AS DATE)
                        AND CAST('2000-08-23' AS DATE) + INTERVAL '30' DAY
        AND ws_web_page_sk = wp_web_page_sk
  GROUP BY wp_web_page_sk), 
 wr AS
 (SELECT wp_web_page_sk,
        SUM(wr_return_amt) AS returns,
        SUM(wr_net_loss) AS profit_loss
  FROM tpcds.web_returns,
       tpcds.date_dim,
       tpcds.web_page
  WHERE wr_returned_date_sk = d_date_sk
        AND d_date BETWEEN CAST('2000-08-23' AS DATE)
                        AND CAST('2000-08-23' AS DATE) + INTERVAL '30' DAY
        AND wr_web_page_sk = wp_web_page_sk
  GROUP BY wp_web_page_sk)
  SELECT  channel
        , id
        , SUM(sales) AS sales
        , SUM(returns) AS returns
        , SUM(profit) AS profit
 FROM 
 (SELECT 'store channel' AS channel
        , ss.s_store_sk AS id
        , sales
        , COALESCE(returns, 0) AS returns
        , (profit - COALESCE(profit_loss,0)) AS profit
 FROM   ss LEFT JOIN sr
        ON  ss.s_store_sk = sr.s_store_sk
 UNION ALL
 SELECT 'catalog channel' AS channel
        , cs_call_center_sk AS id
        , sales
        , returns
        , (profit - profit_loss) AS profit
 FROM  cs
       , cr
 UNION ALL
 SELECT 'web channel' AS channel
        , ws.wp_web_page_sk AS id
        , sales
        , COALESCE(returns, 0) returns
        , (profit - COALESCE(profit_loss,0)) AS profit
 FROM   ws LEFT JOIN wr
        ON  ws.wp_web_page_sk = wr.wp_web_page_sk
 ) x
 GROUP BY ROLLUP (channel, id)
 ORDER BY channel
         ,id
 LIMIT 100;
