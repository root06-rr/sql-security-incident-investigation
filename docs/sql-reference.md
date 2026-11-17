# SQL reference from my Notion notes

This reference follows the topics in my Notion page [19) SQL](https://app.notion.com/p/19-SQL-301f055fceba8052a846cdbf4c8fce16?source=copy_link). I use it to explain the SQL concepts that support the four investigations in this repository. The examples in this document are learning examples. They are not additional security findings.

## 1. Database fundamentals

A database is an organized collection of structured data. A relational database stores information in tables that can be connected through shared fields.

- **Table:** A structured collection of related data.
- **Field or column:** A category of information stored in a table.
- **Record or row:** One entry in a table.
- **Primary key:** A unique, non-null identifier for each row.
- **Foreign key:** A field that refers to a primary key in another table.

SQL is used to communicate with relational databases. In security work, it can be used to query structured records such as login events and device information.

### SQL and Linux filtering

My notes compare SQL filtering with Linux filtering.

| Area | SQL | Linux |
|---|---|---|
| Main purpose | Work with data inside a database | Work with files and directories in an operating system |
| Structure | Tables with rows and columns | Often free-form text and files |
| Combining data | Can join related tables | Does not provide the same relational join model |
| Examples | SELECT, WHERE, JOIN | grep, find, cut, sed |
| Example use | Query structured security logs | Search raw text or log files |

### Syntax and readability

SQL keywords are not case-sensitive in the examples. I use uppercase keywords to make queries easier to read. I separate selected column names with commas and place major clauses on separate lines. A semicolon ends a SQL statement.

## 2. Database statements

| Statement | Purpose |
|---|---|
| CREATE DATABASE | Creates a database |
| SHOW DATABASES | Lists databases available to the account |
| USE | Selects the active database |
| DROP DATABASE | Deletes a database and its tables |

Example:

```sql
CREATE DATABASE thm_bookmarket_db;
SHOW DATABASES;
USE thm_bookmarket_db;
```

DROP DATABASE is destructive. It removes the database and the tables inside it. I do not include it in the project setup script.

## 3. Table statements

| Statement | Purpose |
|---|---|
| CREATE TABLE | Defines a table, its columns, data types, and constraints |
| SHOW TABLES | Lists tables in the active database |
| DESCRIBE or DESC | Displays a table's column structure |
| ALTER TABLE | Changes an existing table structure |
| DROP TABLE | Deletes a table and its records |

The notes use examples such as INT, VARCHAR, DATE, PRIMARY KEY, AUTO_INCREMENT, and NOT NULL. These define the type of information a column stores and the rules applied to its values.

## 4. CRUD operations

CRUD describes four basic ways to work with stored records.

### Create with INSERT INTO

Adds rows to a table.

```sql
INSERT INTO books (id, name)
VALUES (1, 'Android Security Internals');
```

### Read with SELECT and FROM

Retrieves information from a table.

```sql
SELECT name, dept
FROM users;
```

Selecting only the fields needed keeps the result focused. SELECT * returns every column. My notes point out that selecting unnecessary columns can affect performance and expose fields that are not needed.

### Update with UPDATE and SET

Changes existing records.

```sql
UPDATE books
SET description = 'Updated description'
WHERE id = 1;
```

The WHERE condition matters. Without it, the update applies to every row.

### Delete with DELETE FROM

Removes records.

```sql
DELETE FROM books
WHERE id = 1;
```

Without a WHERE condition, the statement deletes every row in the table while leaving the table itself in place.

## 5. Clauses for organizing data

### DISTINCT

DISTINCT removes duplicate rows from the returned result.

```sql
SELECT DISTINCT country
FROM log_in_attempts;
```

### GROUP BY

GROUP BY places rows with matching values into groups. It is used with aggregate functions such as COUNT, SUM, AVG, MIN, and MAX.

```sql
SELECT username, COUNT(*) AS record_count
FROM log_in_attempts
GROUP BY username;
```

Columns in the SELECT list that are not inside aggregate functions should be included in GROUP BY.

### HAVING

HAVING filters grouped results after aggregation. WHERE filters individual rows before grouping.

```sql
SELECT username, COUNT(*) AS failed_record_count
FROM log_in_attempts
WHERE success = FALSE
GROUP BY username
HAVING COUNT(*) > 1;
```

This is the aggregation pattern used in the authentication review.

### ORDER BY

ORDER BY controls the order of the final result. ASC sorts in ascending order and is the default. DESC sorts in descending order. When multiple columns are supplied, the database sorts by the first column and uses later columns to break ties.

### WHERE

WHERE filters rows using a condition.

```sql
SELECT username, country
FROM log_in_attempts
WHERE country = 'Canada';
```

Text values in these examples use single quotes.

## 6. LIKE and wildcards

LIKE is used when an exact match is not required.

- The percent sign (%) represents zero or more characters.
- The underscore (_) represents exactly one character.

Examples:

| Pattern | Meaning |
|---|---|
| 'East%' | Starts with East |
| '%a' | Ends with a |
| '%IT%' | Contains IT |
| 'N_' | Two characters, starting with N |
| 'a_b' | Three characters, starts with a and ends with b |

The employee review uses LIKE to match office and department values.

## 7. Data types and advanced filtering

### Common data types

My notes group values into strings, numeric values, and date or time values.

- **String:** Text such as a username. Text values use quotes.
- **Numeric:** Whole numbers or decimals. Numeric values are not quoted.
- **Date and time:** Calendar dates or time values. The examples use quoted date and time values.

### Comparison operators

| Operator | Meaning | Example use from the notes |
|---|---|---|
| > | Greater than | Login after a time threshold |
| < | Less than | Value below a threshold |
| >= | Greater than or equal to | Date on or after a given date |
| <= | Less than or equal to | Patch date on or before a given date |
| <> or != | Not equal to | Exclude a value |

Greater than and less than are exclusive. Greater than or equal to and less than or equal to include the boundary value.

### BETWEEN

BETWEEN filters values within a range. The start and end values are included.

```sql
SELECT username, login_date
FROM log_in_attempts
WHERE login_date BETWEEN '2022-05-08' AND '2022-05-09';
```

### Logical operators

- **AND:** Both conditions must be true.
- **OR:** At least one condition must be true.
- **NOT:** Negates a condition.

The project uses these operators to combine login, time, country, operating system, and patch-date filters.

## 8. SQL functions

### String functions

- **CONCAT():** Combines values into one string.
- **GROUP_CONCAT():** Combines values from rows into a string for each group. The notes cover DISTINCT, ORDER BY, and SEPARATOR options.
- **SUBSTRING() or SUBSTR():** Extracts part of a string using a starting position and length.
- **LENGTH():** Returns the length of a string in bytes in MySQL.

### Aggregate functions

Aggregate functions calculate a summary from multiple values. The notes state that aggregate functions ignore NULL values except COUNT(*).

- **COUNT(*):** Counts all rows.
- **COUNT(column):** Counts rows where the column is not NULL.
- **COUNT(DISTINCT column):** Counts unique non-NULL values.
- **SUM():** Adds numeric values.
- **MAX():** Returns the highest value.
- **MIN():** Returns the lowest value.

The GROUP BY and HAVING examples use aggregate functions to summarize records and filter the resulting groups.

## 9. SQL joins

A join combines rows from tables using a matching condition. Dot notation identifies which table a column belongs to, such as users.user_id or assets.user_id. The ON clause defines the match.

### INNER JOIN

Returns rows that have a match in both tables.

```sql
SELECT users.name, assets.model
FROM users
INNER JOIN assets
    ON users.user_id = assets.user_id;
```

### LEFT JOIN

Returns every row from the left table and matching rows from the right table. If there is no match, the right-side columns contain NULL.

### RIGHT JOIN

Returns every row from the right table and matching rows from the left table. If there is no match, the left-side columns contain NULL.

### FULL OUTER JOIN

The notes describe FULL OUTER JOIN as returning all rows from both tables, matching where possible and returning NULL where there is no match. The example is conceptual for this reference. MySQL does not support a direct FULL OUTER JOIN clause, so the supplied project investigations use INNER JOIN, LEFT JOIN, and RIGHT JOIN instead.

### NULL values in joins

NULL can be used to identify missing matches after an outer join.

```sql
SELECT users.name
FROM users
LEFT JOIN assets
    ON users.user_id = assets.user_id
WHERE assets.user_id IS NULL;
```

This pattern is used in the asset audit to find users without a matching asset row.
