# Project overview

## Why I built this

I used SQL to explore how structured records can support basic security reviews. My starting point was the SQL learning page in my Notion workspace and the sample database that accompanied it. I organized the practical queries into four investigation areas so that the purpose and limits of each query are clear.

## Scope

The project covers authentication records, login time and outcome, country and IP pattern filters, employee workstation details, patch dates, and user-to-asset relationships. The dataset is simulated learning data. It does not contain live security telemetry, verified incident records, or threat intelligence.

## Questions explored

1. Which authentication records show a failed result?
2. Does the sample contain accounts with more than one failed record?
3. Which login records occur after 18:00?
4. Which after-hours records were successful?
5. Which records match the country and IP patterns used in the exercise?
6. Which employee records match the office, department, operating system, and patch-date filters?
7. Which users have no matching asset record, and which assets are unassigned?

## What this demonstrates

Filtering, comparison operators, Boolean logic, pattern matching, aggregation, grouping, sorting, inner joins, outer joins, and NULL checks.
