# SQL-Based Security Access and Asset Audit

I built this project to practise reviewing authentication activity and auditing employee and hardware records with SQL. My learning reference is my Notion page, which I developed from material I studied through the Google Cybersecurity Certificate on Coursera and TryHackMe labs. The practical database and four investigation exercises come from the supplied SQL project archive.

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
- [Complete SQL reference from my Notion notes](docs/sql-reference.md)
- [Learning notes and selected screenshots](docs/learning-notes/README.md)

## Important limitations

The sample data is small and simulated. The IP addresses 198.51.100.42 and 203.0.113.15 belong to documentation ranges reserved for examples. They are not real threat indicators. A failed login or after-hours login is not proof of compromise or unauthorized access.

The original schema includes a machines table, but the supplied sample does not populate it and the supplied investigations do not use it. The authentication records are also not relationally linked to the separate users or employees tables.

The SQL reference documents the learning material. It is not a claim that every concept is used by the four investigation scripts.

## Skills demonstrated

SQL filtering, comparison and logical operators, LIKE, BETWEEN, aggregation, GROUP BY, HAVING, sorting, string functions, INNER JOIN, LEFT JOIN, RIGHT JOIN, NULL handling, schema setup, and technical documentation.
