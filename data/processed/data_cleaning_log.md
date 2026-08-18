# Data Cleaning & Preprocessing Log

Processed from the original CSV files in `data/raw/`. Raw files were not modified.

## Transformations

- Trimmed whitespace from column names.
- Converted `datum` to datetime.
- Converted pharmaceutical sales fields to numeric values.
- Converted `Year` and `Month` to numeric integer fields where present.
- Converted `Hour` to numeric where present.
- Removed exact duplicate rows if present.
- Validated `Year`, `Month`, and `Weekday Name` against `datum`.
- Added `Total_Sales`, the row-level sum across the eight product/category sales fields.
- Saved cleaned datasets as CSV files in the processed-data output.

## Quality Results

| Dataset   |   Original Rows |   Processed Rows |   Columns |   Exact Duplicates Removed |   Missing Cells |   Date Parse Failures |   Year Mismatches |   Month Mismatches |   Weekday Mismatches |
|:----------|----------------:|-----------------:|----------:|---------------------------:|----------------:|----------------------:|------------------:|-------------------:|---------------------:|
| hourly    |           50532 |            50532 |        14 |                          0 |               0 |                     0 |                 0 |                  0 |                    0 |
| daily     |            2106 |             2106 |        14 |                          0 |               0 |                     0 |                 0 |                  0 |                    0 |
| weekly    |             302 |              302 |        10 |                          0 |               0 |                     0 |                 0 |                  0 |                    0 |
| monthly   |              70 |               70 |        10 |                          0 |               0 |                     0 |                 0 |                  0 |                    0 |

## Important Note

The daily dataset's `Hour` values are not assumed to represent a 0–23 clock hour. The field should be interpreted only after validating its source meaning. The hourly dataset is the appropriate source for intraday analysis.
