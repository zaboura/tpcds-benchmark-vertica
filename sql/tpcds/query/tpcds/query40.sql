SELECT  
   w_state,
   i_item_id,
   SUM(CASE WHEN (CAST(d_date AS DATE) < CAST('2000-03-11' AS DATE)) 
            THEN cs_sales_price - COALESCE(cr_refunded_cash, 0) ELSE 0 END) AS sales_before,
   SUM(CASE WHEN (CAST(d_date AS DATE) >= CAST('2000-03-11' AS DATE)) 
            THEN cs_sales_price - COALESCE(cr_refunded_cash, 0) ELSE 0 END) AS sales_after
FROM
   tpcds.catalog_sales 
   LEFT OUTER JOIN tpcds.catalog_returns 
        ON (cs_order_number = cr_order_number AND cs_item_sk = cr_item_sk),
   tpcds.warehouse,
   tpcds.item,
   tpcds.date_dim
WHERE
   i_current_price BETWEEN 0.99 AND 1.49
   AND i_item_sk          = cs_item_sk
   AND cs_warehouse_sk    = w_warehouse_sk 
   AND cs_sold_date_sk    = d_date_sk
   AND d_date BETWEEN (CAST('2000-03-11' AS DATE) - INTERVAL '30' DAY)
                    AND (CAST('2000-03-11' AS DATE) + INTERVAL '30' DAY)
GROUP BY
   w_state, i_item_id
ORDER BY w_state, i_item_id
LIMIT 100;
