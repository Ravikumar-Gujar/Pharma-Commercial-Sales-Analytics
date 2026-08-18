# Initial Sales Insights — Exploratory Data Analysis

## Executive Summary

- Total recorded sales across the daily dataset: **127,595.50** units.
- Highest-performing product/category: **N02BE**, contributing **49.38%** of total sales.
- Lowest-performing product/category: **N05C**, contributing **0.98%** of total sales.
- Highest-sales month based on aggregated monthly seasonality: **Jan**.
- Lowest-sales month based on aggregated monthly seasonality: **Jul**.
- Highest-sales weekday based on aggregated daily data: **Saturday**.
- Peak hourly sales occur at hour **19:00** in the hourly dataset.

## Product Performance

| Product   |   Total_Sales |   Sales_Share_% |
|:----------|--------------:|----------------:|
| N02BE     |      63005.4  |           49.38 |
| N05B      |      18645.7  |           14.61 |
| R03       |      11608.8  |            9.1  |
| M01AB     |      10600.9  |            8.31 |
| M01AE     |       8204.62 |            6.43 |
| N02BA     |       8172.21 |            6.4  |
| R06       |       6107.82 |            4.79 |
| N05C      |       1249.96 |            0.98 |

## Yearly Performance

|   Year |   Total_Sales |   YoY_Growth_% |
|-------:|--------------:|---------------:|
|   2014 |       20238.3 |         nan    |
|   2015 |       22752.4 |          12.42 |
|   2016 |       25234.9 |          10.91 |
|   2017 |       19399.4 |         -23.12 |
|   2018 |       22884.6 |          17.97 |
|   2019 |       17086   |         -25.34 |

## First-to-Last Year Product Growth

|       |   Growth_First_to_Last_Year_% |
|:------|------------------------------:|
| R03   |                         55.12 |
| R06   |                         34.11 |
| M01AB |                          4.84 |
| M01AE |                        -13.73 |
| N02BE |                        -13.93 |
| N05C  |                        -28.11 |
| N05B  |                        -44.25 |
| N02BA |                        -45.57 |

## Monthly Seasonality

|     |   Total_Sales |
|:----|--------------:|
| Jan |      13970.7  |
| Feb |      11604.6  |
| Mar |      11363.6  |
| Apr |      10248.7  |
| May |       9925.97 |
| Jun |       8992.86 |
| Jul |       8758.5  |
| Aug |       9037.61 |
| Sep |      11000.9  |
| Oct |      12051    |
| Nov |       9534.38 |
| Dec |      11106.7  |

## Weekday Performance

| Weekday Name   |   Total_Sales |
|:---------------|--------------:|
| Monday         |       18242.8 |
| Tuesday        |       18065.2 |
| Wednesday      |       17771.5 |
| Thursday       |       17212.4 |
| Friday         |       18134.5 |
| Saturday       |       19767.6 |
| Sunday         |       18401.4 |

## Analytical Notes

- Product performance is based on the eight product/category sales columns supplied in the source data.
- `Total_Sales` is the row-level sum of those eight fields.
- Monthly and weekday summaries are aggregated from daily observations.
- Hourly patterns are calculated from the hourly dataset and should not be inferred from the daily `Hour` field.
- These are descriptive EDA findings; causal explanations should be validated against commercial/business context.
