-- 01. Authentication review
-- Objective: inspect failed records and count failed rows by account.

SELECT username, country, ip_address, login_date, login_time, success
FROM log_in_attempts
WHERE success = FALSE
ORDER BY login_date, login_time;

SELECT username, ip_address, login_date, login_time, success
FROM log_in_attempts
WHERE success = FALSE
  AND login_date BETWEEN '2022-05-08' AND '2022-05-09'
ORDER BY login_date, login_time;

-- With the supplied sample this returns no rows because each account
-- has only one failed row.
SELECT username, COUNT(*) AS failed_record_count
FROM log_in_attempts
WHERE success = FALSE
GROUP BY username
HAVING COUNT(*) > 1;
