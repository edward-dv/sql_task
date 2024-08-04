SELECT
  m.organisation_id
  , SUM(p.amount) AS revenue
FROM `gc-prd-ext-data-test-prod-906c.gc_paysvc_live.payments` AS p
JOIN `gc-prd-ext-data-test-prod-906c.gc_paysvc_live.mandates` AS m
  ON p.mandate_id = m.id
WHERE p.charge_date IS NOT NULL -- To differentiate revenue, however this condition has no effect as all payments have a charge date
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
