WITH 
mandates_payments AS (
  SELECT 
    m.id
    , m.organisation_id
    , COUNT(DISTINCT p.id) AS count_payments
  FROM `gc-prd-ext-data-test-prod-906c.gc_paysvc_live.mandates` AS m
  LEFT JOIN `gc-prd-ext-data-test-prod-906c.gc_paysvc_live.payments` AS p 
    ON m.id = p.mandate_id
  GROUP BY 1, 2
)
SELECT
  o.parent_vertical
  , COUNT(mp.id) AS count_mandates
  , COUNT(DISTINCT CASE WHEN mp.count_payments > 0 THEN mp.id END) AS count_activated_mandates
  , (COUNT(DISTINCT CASE WHEN mp.count_payments > 0 THEN mp.id END)
    / COUNT(mp.id)) AS mandate_activation_rate
FROM mandates_payments AS mp
JOIN `gc-prd-ext-data-test-prod-906c.gc_paysvc_live.organisations` AS o
  ON mp.organisation_id = o.id
GROUP BY 1
ORDER BY 1
