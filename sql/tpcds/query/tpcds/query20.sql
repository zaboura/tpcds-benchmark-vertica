SELECT  
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    SUM(cs_ext_sales_price) AS itemrevenue,
    SUM(cs_ext_sales_price) * 100 / SUM(SUM(cs_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
FROM tpcds.catalog_sales
   , tpcds.item
   , tpcds.date_dim
WHERE cs_item_sk = i_item_sk
  AND i_category IN ('Sports','Books','Home')
  AND cs_sold_date_sk = d_date_sk
  AND d_date BETWEEN CAST('1999-02-22' AS DATE) 
                 AND (CAST('1999-02-22' AS DATE) + INTERVAL '30' DAY)
GROUP BY i_item_id,
         i_item_desc,
         i_category,
         i_class,
         i_current_price
ORDER BY i_category,
         i_class,
         i_item_id,
         i_item_desc,
         revenueratio
LIMIT 100;
