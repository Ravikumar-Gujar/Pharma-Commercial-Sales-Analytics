# SQL Setup Guide

## Recommended table

Create a table named `daily_sales` with the columns from `salesdaily_processed.csv`.

The SQL analysis script assumes these fields:
- datum
- M01AB, M01AE, N02BA, N02BE, N05B, N05C, R03, R06
- Year, Month, Hour, Weekday Name
- Total_Sales

## Workflow

1. Import `salesdaily_processed.csv` into a SQL database.
2. Name the table `daily_sales`.
3. Run `pharma_sales_analysis.sql`.
4. Export useful query results for reporting or Power BI.

The queries are written in broadly SQLite-compatible SQL and use window functions for ranking and year-over-year analysis.
