
WITH ws_wh AS (
  SELECT ws1.ws_order_number,
         ws1.ws_warehouse_sk AS wh1,
         ws2.ws_warehouse_sk AS wh2
  FROM tpcds.web_sales ws1,
       tpcds.web_sales ws2
  WHERE ws1.ws_order_number = ws2.ws_order_number
    AND ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
)
SELECT  
   COUNT(DISTINCT ws_order_number) AS "order count",
   SUM(ws_ext_ship_cost) AS "total shipping cost",
   SUM(ws_net_profit) AS "total net profit"
FROM
   tpcds.web_sales ws1,
   tpcds.date_dim,
   tpcds.customer_address,
   tpcds.web_site
WHERE
    d_date BETWEEN '1999-02-01'
               AND CAST('1999-02-01' AS DATE) + INTERVAL '60' DAY
  AND ws1.ws_ship_date_sk = d_date_sk
  AND ws1.ws_ship_addr_sk = ca_address_sk
  AND ca_state = 'IL'
  AND ws1.ws_web_site_sk = web_site_sk
  AND web_company_name = 'pri'
  AND ws1.ws_order_number IN (
        SELECT ws_order_number
        FROM ws_wh
      )
  AND ws1.ws_order_number IN (
        SELECT wr_order_number
        FROM tpcds.web_returns, ws_wh
        WHERE wr_order_number = ws_wh.ws_order_number
      )
ORDER BY "order count"
LIMIT 100;



