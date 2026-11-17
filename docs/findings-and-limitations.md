# Findings and limitations

## Findings supported by the supplied sample

### Authentication review

The sample contains two failed records: one for j_doe and one for bmoreno. Each account appears once with success set to FALSE. The original aggregation uses HAVING COUNT(*) > 1, so it returns no accounts from this sample. This is an expected result for the supplied rows, not evidence that the query is broken.

The login_attempts field contains values such as 5 and 6 on individual records. The original query counts rows, not the login_attempts field. These are different measurements.

### After-hours review

The sample contains three records later than 18:00. Two are failed records and one is successful. The successful after-hours record belongs to j_doe on 2022-05-09 at 19:20.

The threshold is a fixed exercise value. The data does not define approved working hours or an exception process.

### IP and location review

The sample includes Canada and USA values. The patterns 198.51.100.0/24 and 203.0.113.0/24 are documentation ranges reserved for examples. They are not evidence of real external infrastructure or threat activity.

### Employee and asset review

The employee rows include East office entries, an IT Staff department entry, and workstation operating system and patch dates. The asset sample includes two assigned assets and one asset with a NULL user_id. The supplied users sample has three users. The join query identifies Charlie as having no matching asset row and the Server asset as unassigned in this sample.

## Limitations

- The dataset is small and simulated.
- There is no live log source or event collection process.
- There is no timezone field or approved business-hours schedule.
- There is no user identity mapping between authentication records and the separate users table.
- The machines table is present in the source schema but is not populated or used by the supplied investigations.
- The sample does not include enough repeated failed-login rows to demonstrate the greater-than-one aggregation threshold.
- The IP examples are documentation addresses, not threat intelligence.
- No conclusion about compromise, malicious intent, or real-world risk can be drawn from these records.

## Possible next improvements

A future version could add a larger and clearly documented test dataset, define relationships between identity and asset records, and add repeatable query validation. Those changes would be separate additions, not part of the original Notion material.
