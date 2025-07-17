SELECT SUM(cs_ext_discount_amt) AS "excess discount amount"
FROM 
   tpcds.catalog_sales,
   tpcds.item,
   tpcds.date_dim
WHERE
  i_manufact_id = 977
  AND i_item_sk = cs_item_sk
  AND d_date BETWEEN CAST('2000-01-27' AS date) AND (CAST('2000-01-27' AS date) + INTERVAL '90' DAY)
  AND d_date_sk = cs_sold_date_sk
  AND cs_ext_discount_amt > (
      SELECT 1.3 * AVG(cs_ext_discount_amt)
      FROM tpcds.catalog_sales, tpcds.date_dim
      WHERE cs_item_sk = i_item_sk
        AND d_date BETWEEN CAST('2000-01-27' AS date) AND (CAST('2000-01-27' AS date) + INTERVAL '90' DAY)
        AND d_date_sk = cs_sold_date_sk
  )
LIMIT 100;
