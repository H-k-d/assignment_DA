
SELECT 
    user_id,
    date,
    SUM(count_enqs) AS count_enqs,
    SUM(count_txns) AS count_txns
FROM (
    SELECT
        user_id,
        date,
        COUNT(*) AS count_enqs,
        0 AS count_txns
    FROM enquiries
    GROUP BY user_id, date

    UNION ALL

    SELECT
        user_id,
        date,
        0 AS count_enqs,
        COUNT(*) AS count_txns
    FROM txns
    GROUP BY user_id, date
) AS combined
GROUP BY user_id, date;
