# Database schema

The setup script creates five tables from the supplied SQL exercise.

| Table | Purpose | Main fields |
|---|---|---|
| employees | Employee and workstation details | employee_id, device_id, username, department, office, operating_system, patch_date |
| machines | Device records | device_id, employee_id, operating_system, patch_date |
| log_in_attempts | Authentication activity | attempt_id, username, country, ip_address, login_date, login_time, login_attempts, success |
| users | User directory sample | user_id, name, dept |
| assets | Hardware inventory sample | asset_id, model, user_id |

## Relationships and gaps

The original sample has no declared foreign keys. The employee and machine tables both contain device and patch fields, but the supplied queries use the employee table for the patch review. The users and assets tables are related through user_id in the join exercises. The assets sample includes one row with a NULL user_id.

The authentication table is not linked to the users or employees tables by a declared key. This project treats those datasets as separate exercises and does not assume that usernames identify the same person across tables.

## Data types

The project schema uses DATE for dates and TIME for login times so that comparisons are temporal rather than string-based. IP addresses are stored as text because the exercises use LIKE pattern matching.
