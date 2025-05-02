Explanation Task-1

Here, to get the count of enquiries and transactions made by 1 user on a date is done by taking the union of two different tables. So in one query, we have used data by taking a union all from 2 tables.

In the first part, we fetch user_id, date, and the count of enquiries from the enquiries table by grouping on user_id and date. Since there are no transactions in this part, we set count_txns as 0. Also, because we're using UNION ALL, both parts of the union must have the same number and type of columns.

In the second table, we fetched user_id, date, count of enquiries is marked as 0 (as union all is used, so columns of both tables should be the same), and count of transactions is taken from the transaction table, grouped by user_id, date.

Finally, from this combined dataset, we select user_id, date, and calculate the sum of count_enqs and count_txns. We group the final output by user_id and date to get the number of enquiries, transactions made per day per user.



Explanation Tast-2

I have made 2 CTEs, 
The first CTE candidate_matches will give enquiry_id, user_id, enquiry_date, txn_id, and a row number. It is partitioned by txn_id because a transaction can be linked to only one enquiry, and it should be the earliest one, hence row_number = 1 will be chosen.
Here, we need data from both the txns table and the enquiries table, so we join both of them. As per the requirement, the date of the enquiry should be within a 30-day window before the transaction, so this condition is also used while joining.
An INNER JOIN is used because we want only those users who have both enquired and also made a transaction.
Second CTE txn_to_enquiry is used to get enquiry_id and transaction_id from the first CTE table which have row no. = 1 means the first enquiry.

Now, in the final query, we join the enquiries table with the second CTE txn_to_enquiry (since a single enquiry can have more than one transaction, we use an array). The join is based on enquiry_id and gives us the enquiry_id, user_id, and date of the enquiry, along with the corresponding transaction(s) made within 30 days of that enquiry.
These are also group by to get the array, if no transaction id will be there then the array will be empty.