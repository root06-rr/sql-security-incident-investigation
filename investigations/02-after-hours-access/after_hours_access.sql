-- 02. After-hours access review
-- Objective: inspect records later than the exercise threshold of 18:00.

SELECT username, login_date, login_time, ip_address, success
FROM log_in_attempts
WHERE login_time > '18:00:00'
ORDER BY login_date DESC, login_time DESC;

SELECT username, login_date, login_time, ip_address, success
FROM log_in_attempts
WHERE login_time > '18:00:00'
  AND success = TRUE
ORDER BY login_date DESC, login_time DESC;

SELECT username, login_date, login_time, ip_address, success
FROM log_in_attempts
WHERE login_date BETWEEN '2022-05-08' AND '2022-05-09'
ORDER BY login_date, login_time;
