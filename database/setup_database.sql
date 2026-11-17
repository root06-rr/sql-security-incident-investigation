-- SQL-Based Security Access and Asset Audit
-- Sample schema and records from the supplied Notion SQL exercise.
-- Run in a MySQL-compatible client. All records are simulated learning data.

CREATE DATABASE IF NOT EXISTS sql_security_audit;
USE sql_security_audit;

CREATE TABLE IF NOT EXISTS employees (
 employee_id INT PRIMARY KEY, device_id VARCHAR(50), username VARCHAR(50) NOT NULL,
 department VARCHAR(100), office VARCHAR(50), operating_system VARCHAR(50),
 email_client VARCHAR(50), patch_date DATE
);

-- Retained from the source schema. The supplied sample does not populate this table.
CREATE TABLE IF NOT EXISTS machines (
 device_id VARCHAR(50) PRIMARY KEY, employee_id INT,
 operating_system VARCHAR(50), patch_date DATE
);

CREATE TABLE IF NOT EXISTS log_in_attempts (
 attempt_id INT PRIMARY KEY, username VARCHAR(50) NOT NULL, country VARCHAR(50),
 ip_address VARCHAR(45), login_date DATE, login_time TIME,
 login_attempts INT, success BOOLEAN
);

CREATE TABLE IF NOT EXISTS users (
 user_id INT PRIMARY KEY, name VARCHAR(50), dept VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS assets (
 asset_id INT PRIMARY KEY, model VARCHAR(50), user_id INT NULL
);

INSERT INTO employees VALUES
(1000,'h32rb17','j_doe','Marketing','East-120','OS 1','Client A','2021-03-01'),
(1001,'dev9','bmoreno','Finance','East-Building','OS 2','Client B','2021-02-15'),
(1002,'cpu825','tshah','Human Resources','West-200','OS 3','Client A','2021-03-01'),
(1003,'srv01','analyst10','IT Staff','North-101','OS 1','Client A','2021-03-01');

INSERT INTO log_in_attempts VALUES
(1,'analyst10','Canada','192.168.1.10','2022-05-08','14:30:00',1,TRUE),
(2,'j_doe','USA','198.51.100.42','2022-05-08','19:15:00',5,FALSE),
(3,'j_doe','USA','198.51.100.42','2022-05-09','19:20:00',5,TRUE),
(4,'bmoreno','Canada','203.0.113.15','2022-05-09','21:10:00',6,FALSE);

INSERT INTO users VALUES
(1,'Alice','IT'),(2,'Bob','Sales'),(3,'Charlie','Exec');

INSERT INTO assets VALUES
(101,'MacBook',1),(102,'ThinkPad',2),(103,'Server',NULL);
