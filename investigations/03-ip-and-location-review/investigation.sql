-- 03. IP and location review
-- The matching IPs are documentation examples, not threat intelligence.

SELECT *
FROM log_in_attempts
WHERE country = 'Canada';

SELECT username, country, ip_address, login_date, login_time
FROM log_in_attempts
WHERE NOT country = 'USA'
  AND NOT country = 'Canada';

SELECT username, ip_address, login_date, login_time, success
FROM log_in_attempts
WHERE ip_address NOT LIKE '192.168.%';

SELECT username, ip_address, login_date, login_time, success
FROM log_in_attempts
WHERE ip_address LIKE '198.51.100.%'
   OR ip_address LIKE '203.0.113.%';
