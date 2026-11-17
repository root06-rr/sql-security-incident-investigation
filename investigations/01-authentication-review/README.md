# 01. Authentication review

## Objective

I review failed authentication records and summarize failed rows by username.

## Queries

Open [investigation.sql](investigation.sql).

1. Return all rows where success is FALSE.
2. Restrict failed records to 2022-05-08 and 2022-05-09.
3. Count failed rows by username and return accounts with more than one failed row.

## What the sample shows

There are two failed rows. j_doe has one and bmoreno has one. The final query returns no rows because neither account has more than one failed row in the supplied sample.

The login_attempts column is separate from the number of rows. The aggregation counts failed records, not the login_attempts value.

## Interpretation

A failed record is an authentication outcome in this sample. It does not establish that the account was compromised. More context would be required before treating repeated failures as suspicious.
