WITH candidate_matches AS (
  SELECT
    e.enquiry_id,
    e.user_id,
    e.date AS enquiry_date,
    t.txn_id,
    t.date AS txn_date,
    ROW_NUMBER() OVER (
      PARTITION BY t.txn_id
      ORDER BY e.date
    ) AS rn
  FROM enquiries e
  JOIN txns t
    ON e.user_id = t.user_id
   AND t.date BETWEEN e.date AND e.date + INTERVAL 30 DAY
)


, txn_to_enquiry AS (
  SELECT enquiry_id, txn_id
  FROM candidate_matches
  WHERE rn = 1
)

--  Group txn_ids by enquiry

SELECT
  e.enquiry_id,
  e.date,
  e.user_id,
  array_agg(te.txn_id) AS txn_ids
FROM enquiries e
LEFT JOIN txn_to_enquiry te
  ON e.enquiry_id = te.enquiry_id
GROUP BY e.enquiry_id, e.date, e.user_id;