# Investigation methodology

I follow the same sequence for each review.

1. **Define the question.** State what the query is intended to identify.
2. **Identify the source table.** Use only the fields needed to answer the question.
3. **Filter the records.** Apply the relevant date, time, outcome, location, or pattern condition.
4. **Group or join when needed.** Use aggregation to summarize account activity and joins to compare related records.
5. **Review the returned rows.** A query result is a lead for review, not proof of malicious activity.
6. **Record limitations.** Note missing context, small sample size, and assumptions in the data.

## Interpretation rules

- A failed login record does not establish that an account was compromised.
- A login after 18:00 is only outside the threshold used in this exercise. It is not automatically suspicious.
- A country or IP pattern match is only a match against the supplied sample values.
- A missing asset match may reflect incomplete sample data rather than an actual inventory problem.
- The dataset has no business calendar, approved access schedule, identity provider context, or asset inventory source of truth.
