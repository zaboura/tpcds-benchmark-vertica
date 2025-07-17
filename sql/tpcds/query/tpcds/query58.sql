WITH ss_items AS (
  SELECT i_item_id AS item_id,
         CAST(SUM(ss_ext_sales_price) AS NUMERIC(18,3)) AS ss_item_rev
  FROM tpcds.store_sales, tpcds.item, tpcds.date_dim
  WHERE ss_item_sk = i_item_sk
    AND d_date IN (SELECT d_date
                   FROM tpcds.date_dim
                   WHERE d_week_seq = (SELECT d_week_seq 
                                       FROM tpcds.date_dim
                                       WHERE d_date = '2000-01-03'))
    AND ss_sold_date_sk = d_date_sk
  GROUP BY i_item_id
),
cs_items AS (
  SELECT i_item_id AS item_id,
         CAST(SUM(cs_ext_sales_price) AS NUMERIC(18,3)) AS cs_item_rev
  FROM tpcds.catalog_sales, tpcds.item, tpcds.date_dim
  WHERE cs_item_sk = i_item_sk
    AND d_date IN (SELECT d_date
                   FROM tpcds.date_dim
                   WHERE d_week_seq = (SELECT d_week_seq 
                                       FROM tpcds.date_dim
                                       WHERE d_date = '2000-01-03'))
    AND cs_sold_date_sk = d_date_sk
  GROUP BY i_item_id
),
ws_items AS (
  SELECT i_item_id AS item_id,
         CAST(SUM(ws_ext_sales_price) AS NUMERIC(18,3)) AS ws_item_rev
  FROM tpcds.web_sales, tpcds.item, tpcds.date_dim
  WHERE ws_item_sk = i_item_sk
    AND d_date IN (SELECT d_date
                   FROM tpcds.date_dim
                   WHERE d_week_seq = (SELECT d_week_seq 
                                       FROM tpcds.date_dim
                                       WHERE d_date = '2000-01-03'))
    AND ws_sold_date_sk = d_date_sk
  GROUP BY i_item_id
)
SELECT ss_items.item_id,
       ss_item_rev,
       ss_item_rev / ((ss_item_rev + cs_item_rev + ws_item_rev) / 3)* 100  AS ss_dev,
       cs_item_rev,
       cs_item_rev / ((ss_item_rev + cs_item_rev + ws_item_rev) / 3) * 100 AS cs_dev,
       ws_item_rev,
       ws_item_rev / ((ss_item_rev + cs_item_rev + ws_item_rev) / 3) * 100 AS ws_dev,
       (ss_item_rev + cs_item_rev + ws_item_rev) / 3 AS average
FROM ss_items, cs_items, ws_items
WHERE ss_items.item_id = cs_items.item_id
  AND ss_items.item_id = ws_items.item_id
  AND ss_item_rev BETWEEN 0.9 * cs_item_rev AND 1.1 * cs_item_rev
  AND ss_item_rev BETWEEN 0.9 * ws_item_rev AND 1.1 * ws_item_rev
  AND cs_item_rev BETWEEN 0.9 * ss_item_rev AND 1.1 * ss_item_rev
  AND cs_item_rev BETWEEN 0.9 * ws_item_rev AND 1.1 * ws_item_rev
  AND ws_item_rev BETWEEN 0.9 * ss_item_rev AND 1.1 * ss_item_rev
  AND ws_item_rev BETWEEN 0.9 * cs_item_rev AND 1.1 * cs_item_rev
ORDER BY item_id, ss_item_rev
LIMIT 100;