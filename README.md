# SQL-Based Security Access and Asset Audit

I built this project to practise reviewing authentication activity and auditing employee and hardware records with SQL. I used the SQL examples and sample records from my Notion notes as the starting point, then organized the queries into four investigation areas.

This is a hands-on SQL investigation project using simulated records. It is not connected to a live environment and does not represent a real security incident.

## Project objectives

- Review failed authentication attempts and group them by account.
- Identify login activity after the 18:00 threshold used in the exercise.
- Filter authentication records by country and IP address pattern.
- Review employee workstation patch information.
- Compare user records with assigned hardware and identify unassigned assets.

## Investigation workflow

| Investigation | Main question | Tables |
|---|---|---|
| Authentication review | Which records failed, and are there accounts with multiple failed rows? | log_in_attempts |
| After-hours review | Which records occur after 18:00, and which were successful? | log_in_attempts |
| IP and location review | Which records match the country and IP patterns in the exercise? | log_in_attempts |
| Endpoint and asset audit | Which employee records match the filters, and which users or assets lack a matching assignment? | employees, users, assets |

## Repository structure

```text
.
├── README.md
├── database/
│   └── setup_database.sql
├── investigations/
│   ├── 01-authentication-review/
│   ├── 02-after-hours-access/
│   ├── 03-ip-and-location-review/
│   └── 04-endpoint-and-asset-audit/
└── docs/
    ├── project-overview.md
    ├── investigation-methodology.md
    ├── database-schema.md
    ├── findings-and-limitations.md
    ├── source-notes.md
    └── sql-reference.md
```

## Run the project

The scripts use MySQL-compatible SQL.

1. Clone this repository.
2. Open `database/setup_database.sql` in a MySQL-compatible SQL client.
3. Execute the setup script.
4. Run the investigation SQL files in order.
5. Review the matching investigation README for context and interpretation.

The setup script creates the `sql_security_audit` database and inserts the sample rows. It is intended for a fresh database. If you run it again after the sample rows have already been inserted, the primary key values will already exist and the inserts will fail. Use a fresh copy of the database before running the setup script again.

## Investigation guides

- [01. Authentication review](investigations/01-authentication-review/README.md)
- [02. After-hours access review](investigations/02-after-hours-access/README.md)
- [03. IP and location review](investigations/03-ip-and-location-review/README.md)
- [04. Endpoint and asset audit](investigations/04-endpoint-and-asset-audit/README.md)

## Project documentation

- [Project overview](docs/project-overview.md)
- [Investigation methodology](docs/investigation-methodology.md)
- [Database schema](docs/database-schema.md)
- [Findings and limitations](docs/findings-and-limitations.md)
- [Source notes](docs/source-notes.md)
- [SQL reference from my Notion notes](docs/sql-reference.md)

## Important limitations

The sample data is small and simulated. The IP addresses 198.51.100.42 and 203.0.113.15 belong to documentation ranges reserved for examples. They are not real threat indicators. A failed login or after-hours login is not proof of compromise or unauthorized access.

The original schema includes a machines table, but the supplied sample does not populate it and the supplied investigations do not use it. The authentication records are also not relationally linked to the separate users or employees tables.

## Skills demonstrated

SQL filtering, comparison and logical operators, LIKE, BETWEEN, aggregation, GROUP BY, HAVING, sorting, INNER JOIN, LEFT JOIN, RIGHT JOIN, NULL handling, schema setup, and technical documentation.
