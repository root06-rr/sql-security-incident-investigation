# SQL reference from my Notion notes

This reference follows my Notion page [19) SQL](https://app.notion.com/p/19-SQL-301f055fceba8052a846cdbf4c8fce16?source=copy_link). I created it from the notes I collected while learning through the Google Cybersecurity Certificate on Coursera and TryHackMe labs. The Notion page is my learning source. The supplied SQL project archive is the source for the database, sample records, and four practical exercises.

The examples below explain the concepts in my notes. Some are learning examples from the notes, while others use the sample tables in this repository. They should not be read as additional security findings.

## 1. Database fundamentals

A database is an organized collection of structured data. Databases can handle large amounts of information and allow multiple users to access it. A relational database organizes data into tables that relate through shared data points.

- **Table:** A collection of related data arranged in rows and columns.
- **Field or column:** A vertical category of information. In the employees table, examples include employee_id, department, and username.
- **Record or row:** A horizontal entry representing one item, such as an employee record.
- **Relational database:** A database where tables can be related through shared columns.
- **Primary key:** A unique identifier for each row. It cannot be NULL or duplicated.
- **Foreign key:** A column in one table that refers to a primary key in another table. The notes use machines.employee_id as an example of a field that can link a machine to an employee.
- **SQL (Structured Query Language):** The language used to communicate with relational databases.
- **Query:** A specific request for data.

In a security context, SQL can be used to search structured information such as login attempts and workstation records.

### SQL and Linux filtering

| Feature | SQL filtering | Linux filtering |
|---|---|---|
| Primary purpose | Manage and query data inside a database | Work with files and directories in an operating system |
| Structure | Organized into tables, rows, and columns | Often free-form text and lines in files |
| Combining data | Can join related tables | Does not provide the same relational join model |
| Examples | SELECT, WHERE, JOIN | grep, find, cut, sed |
| Example use | Query structured security logs | Search raw .txt or .log files |

### Essential syntax rules

- SQL keywords are not case-sensitive. SELECT and select have the same meaning. I use uppercase keywords to make queries easier to read.
- A comma separates multiple selected columns, such as SELECT city, country.
- A semicolon marks the end of a SQL statement.
- Line breaks are not required, but placing FROM and other major clauses on separate lines makes queries easier to read.

## 2. Database statements

| Statement | Purpose |
|---|---|
| CREATE DATABASE database_name | Creates a database container |
| SHOW DATABASES | Lists databases available on the server |
| USE database_name | Selects the active database for later statements |
| DROP DATABASE database_name | Permanently deletes a database and its tables |

Example:

```sql
CREATE DATABASE thm_bookmarket_db;
SHOW DATABASES;
USE thm_bookmarket_db;
```

DROP DATABASE is destructive. It removes the database and the tables inside it. I do not use it in the project setup script.

## 3. Table statements

| Statement | Purpose |
|---|---|
| CREATE TABLE | Defines a table, columns, data types, and constraints |
| SHOW TABLES | Lists tables in the active database |
| DESCRIBE table_name or DESC table_name | Displays column names, data types, nullability, keys, defaults, and extra attributes |
| ALTER TABLE | Changes an existing table structure |
| DROP TABLE | Permanently deletes a table and its records |

The notes use INT, VARCHAR, DATE, PRIMARY KEY, AUTO_INCREMENT, and NOT NULL.

- **INT** stores whole numbers.
- **VARCHAR(255)** stores text up to the specified length.
- **DATE** stores a calendar date.
- **PRIMARY KEY** uniquely identifies each row.
- **AUTO_INCREMENT** automatically increases an integer value when a row is inserted.
- **NOT NULL** prevents a column from being left without a value.

Example:

```sql
CREATE TABLE book_inventory (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    publication_date DATE
);
```

## 4. CRUD operations

CRUD means Create, Read, Update, and Delete. These are the four basic operations used to manage records.

### Create: INSERT INTO

INSERT INTO adds a new row to a table.

```sql
INSERT INTO books (id, name, published_date, description)
VALUES (1, 'Android Security Internals', '2014-10-14',
        'An In-Depth Guide to Android Security Architecture');
```

### Read: SELECT and FROM

SELECT identifies the columns or expressions to retrieve. FROM identifies the table that contains the data.

```sql
SELECT name, dept
FROM users;
```

Selecting only the columns needed can reduce unnecessary data transfer and avoid exposing fields that are not required. SELECT * retrieves every column and row from the selected table. The notes advise avoiding SELECT * in large production environments because it can affect performance and return sensitive fields that are not needed.

### Update: UPDATE and SET

UPDATE changes existing records. SET identifies the column and new value.

```sql
UPDATE books
SET description = 'Updated description'
WHERE id = 1;
```

The WHERE clause is important. Without it, the update applies to every row in the table.

### Delete: DELETE FROM

DELETE FROM removes rows that match a condition.

```sql
DELETE FROM books
WHERE id = 1;
```

Without a WHERE clause, DELETE FROM removes all rows from the table. The table itself remains.

## 5. Clauses for organizing data

### DISTINCT

DISTINCT removes duplicate values or rows from the returned result.

```sql
SELECT DISTINCT country
FROM log_in_attempts;
```

### GROUP BY

GROUP BY places rows with matching values into groups. It is commonly used with aggregate functions.

```sql
SELECT username, COUNT(*) AS record_count
FROM log_in_attempts
GROUP BY username;
```

When a selected column is not inside an aggregate function, include it in the GROUP BY list.

### HAVING

HAVING filters groups after aggregation. WHERE filters individual rows before grouping.

```sql
SELECT username, COUNT(*) AS failed_record_count
FROM log_in_attempts
WHERE success = FALSE
GROUP BY username
HAVING COUNT(*) > 1;
```

This is the grouping pattern used in the authentication review. With the supplied sample records, it returns no rows because neither account has more than one failed row.

### ORDER BY

ORDER BY controls the order of the result.

- ASC sorts in ascending order and is the default.
- DESC sorts in descending order.
- When multiple columns are listed, the first column is the main sort and later columns break ties.

### WHERE

WHERE filters rows based on a condition.

```sql
SELECT username, country
FROM log_in_attempts
WHERE country = 'Canada';
```

## 6. LIKE and wildcards

LIKE searches for a pattern when an exact match is not required.

- **%** represents zero or more characters.
- **_** represents exactly one character.

| Pattern | Meaning |
|---|---|
| 'East%' | Starts with East |
| '%a' | Ends with a |
| '%IT%' | Contains IT |
| 'N_' | Two characters, starting with N |
| 'a_b' | Three characters, starts with a and ends with b |

The employee audit uses LIKE to match office and department values.

## 7. Data types and advanced filtering

### Data types

The notes group values into strings, numeric values, and date or time values.

- **String:** Text such as a username. String values are written in quotes.
- **Numeric:** Whole numbers or decimal values. Numeric values are not written in quotes.
- **Date and time:** Calendar dates and time values. The examples write these values in quotes.

### Comparison operators

| Operator | Meaning |
|---|---|
| > | Greater than |
| < | Less than |
| >= | Greater than or equal to |
| <= | Less than or equal to |
| <> or != | Not equal to |

Greater than and less than exclude the boundary value. Greater than or equal to and less than or equal to include it.

### BETWEEN

BETWEEN filters values within a range. The start and end values are included.

```sql
SELECT username, login_date
FROM log_in_attempts
WHERE login_date BETWEEN '2022-05-08' AND '2022-05-09';
```

### Logical operators

- **AND:** Both conditions must be true. The notes use an example of finding machines with a specific operating system and email client.
- **OR:** At least one condition must be true. The employee audit uses OS 1 or OS 3.
- **NOT:** Negates a condition and selects values that do not meet it.

The notes also combine NOT and AND to exclude records from both the USA and Canada.

## 8. SQL functions

The notes divide functions into string functions and aggregate functions.

### String functions

**CONCAT()**

Combines two or more strings, column values, or literals into one string. AS can be used to give the result a readable column name.

```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
```

The notes state that in MySQL, if an argument passed to CONCAT() is NULL, the result for that row is NULL.

**GROUP_CONCAT()**

Combines non-NULL values from multiple rows into one delimited string for each group.

```sql
GROUP_CONCAT(
    [DISTINCT] expression
    [ORDER BY sort_column [ASC | DESC]]
    [SEPARATOR 'delimiter']
)
```

- **expression:** The column, expression, or string to concatenate.
- **DISTINCT:** Removes duplicate values from the concatenated result.
- **ORDER BY:** Controls the order of values inside the result string.
- **SEPARATOR:** Sets the delimiter. The default delimiter is a comma.
- **GROUP BY:** Groups rows so the values are concatenated separately for each group.

**SUBSTRING() or SUBSTR()**

Extracts part of a string from a specified starting position for a specified length. The starting position in the notes is 1-based, so 1 represents the first character.

```sql
SELECT SUBSTRING(name, 1, 8) AS short_name
FROM hacking_tools;
```

**LENGTH()**

Returns the length of a string in bytes in MySQL. The notes use it with ORDER BY to sort values by their length.

```sql
SELECT name, LENGTH(name) AS char_length
FROM hacking_tools
ORDER BY char_length DESC;
```

### Aggregate functions

Aggregate functions evaluate values across rows and return a summary. The notes state that aggregate functions ignore NULL values, except COUNT(*).

**COUNT()**

- COUNT(*) counts every row, including rows that contain NULL values in columns.
- COUNT(column_name) counts rows where that column is not NULL.
- COUNT(DISTINCT column_name) counts unique, non-NULL values.

COUNT() is commonly used with WHERE, GROUP BY, and HAVING.

**SUM()**

Adds non-NULL numeric values in a column. The notes show it with numeric fields such as amount and with AS to name the result.

**MAX()**

Returns the highest value. Depending on the data type, this can be the largest number, latest alphabetical value, or most recent date.

**MIN()**

Returns the lowest value. Depending on the data type, this can be the smallest number, earliest alphabetical value, or oldest date.

The notes include examples using COUNT(), SUM(), MAX(), and MIN(). AVG() is also used as an aggregate example in the grouping notes.

## 9. SQL joins

A join combines rows from tables using a matching condition.

### Dot notation

Dot notation uses table_name.column_name to identify which table a field belongs to. This is useful when two tables contain columns with the same name.

Example: employees.device_id and machines.device_id.

### Primary key and foreign key

A primary key uniquely identifies a record. A foreign key refers to a primary key in another table. The notes use employees.employee_id and machines.employee_id as an example of this relationship.

### ON clause

ON defines how the tables are matched.

```sql
ON employees.device_id = machines.device_id
```

### INNER JOIN

Returns only rows with a match in both tables.

```sql
SELECT users.name, assets.model
FROM users
INNER JOIN assets
    ON users.user_id = assets.user_id;
```

With the sample users and assets, Alice and Bob have matching assets. Charlie and the unassigned Server do not appear in this INNER JOIN result.

### LEFT JOIN

Returns every row from the left table and matching rows from the right table. If there is no match, the right-side columns contain NULL.

### RIGHT JOIN

Returns every row from the right table and matching rows from the left table. If there is no match, the left-side columns contain NULL.

### FULL OUTER JOIN

The notes describe FULL OUTER JOIN as returning all rows from both tables, matching where possible and showing NULL where there is no match.

The example in the notes is conceptual for this MySQL project. MySQL does not support a direct FULL OUTER JOIN clause. The project uses INNER JOIN, LEFT JOIN, and RIGHT JOIN in its practical audit queries.

### NULL values in joins

NULL represents missing data or the absence of a matching value in the outer join examples. A NULL check can identify missing relationships.

```sql
SELECT users.name
FROM users
LEFT JOIN assets
    ON users.user_id = assets.user_id
WHERE assets.user_id IS NULL;
```

This pattern identifies users who have no matching asset row.

## Scope and source boundary

This reference carries the concepts and terms from all nine main sections of my Notion page into one place. The examples are kept as learning examples. The four investigation scripts remain based on the supplied SQL project archive and its sample data. I have not added new investigation findings or real security events.
