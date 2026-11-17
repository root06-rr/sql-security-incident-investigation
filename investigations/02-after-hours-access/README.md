# 02. After-hours access review

## Objective

I use 18:00 as the after-hours threshold from the original exercise and review all matching records, then isolate successful after-hours records.

## What the sample shows

Three records occur later than 18:00:

- j_doe on 2022-05-08 at 19:15, failed
- j_doe on 2022-05-09 at 19:20, successful
- bmoreno on 2022-05-09 at 21:10, failed

The successful after-hours query returns the j_doe record from 2022-05-09 at 19:20.

The threshold is an exercise assumption. Without approved schedules, time zone context, and business exceptions, an after-hours record should not be labelled unauthorized.
