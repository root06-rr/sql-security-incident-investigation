-- 04. Endpoint and asset audit

SELECT employee_id, username, department, office
FROM employees
WHERE office LIKE 'East-%';

SELECT employee_id, username, department, office
FROM employees
WHERE department LIKE '%IT%';

SELECT employee_id, device_id, operating_system, patch_date
FROM employees
WHERE patch_date <= '2021-03-01'
  AND (operating_system = 'OS 1' OR operating_system = 'OS 3');

SELECT users.name, assets.model
FROM users
INNER JOIN assets
    ON users.user_id = assets.user_id;

SELECT users.name
FROM users
LEFT JOIN assets
    ON users.user_id = assets.user_id
WHERE assets.user_id IS NULL;

SELECT assets.asset_id, assets.model
FROM users
RIGHT JOIN assets
    ON users.user_id = assets.user_id
WHERE users.user_id IS NULL;
