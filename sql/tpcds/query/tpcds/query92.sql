SELECT  
   SUM(ws_ext_discount_amt) AS "Excess Discount Amount"
FROM 
    tpcds.web_sales 
   ,tpcds.item 
   ,tpcds.date_dim
WHERE
    i_manufact_id = 350
    AND i_item_sk = ws_item_sk 
    AND d_date BETWEEN '2000-01-27'
                   AND CAST('2000-01-27' AS DATE) + INTERVAL '90' DAY
    AND d_date_sk = ws_sold_date_sk 
    AND ws_ext_discount_amt > ( 
         SELECT 
            1.3 * AVG(ws_ext_discount_amt)
         FROM 
            tpcds.web_sales 
           ,tpcds.date_dim
         WHERE 
              ws_item_sk = i_item_sk 
              AND d_date BETWEEN '2000-01-27'
                              AND CAST('2000-01-27' AS DATE) + INTERVAL '90' DAY
              AND d_date_sk = ws_sold_date_sk 
      ) 
ORDER BY SUM(ws_ext_discount_amt)
LIMIT 100;


