# Power BI Dashboard Build Guide

## 1. Import
Load these files:
- Fact_DailySales.csv
- Fact_HourlySales.csv
- Dim_Date.csv
- Dim_Product.csv

## 2. Model
Create relationship:
`Dim_Date[Date]` (1) -> `Fact_DailySales[Date]` (*)

For hourly analysis:
`Dim_Date[Date]` (1) -> `Fact_HourlySales[Date]` (*)

Mark `Dim_Date` as the Date table using `Dim_Date[Date]`.

## 3. Product modeling
For the strongest Power BI model, open `Fact_DailySales` in Power Query and unpivot:
M01AB, M01AE, N02BA, N02BE, N05B, N05C, R03, R06.

Rename:
- Attribute -> Product
- Value -> Product Sales

This creates a normalized product fact structure and makes product slicers/charts much easier.

## 4. Dashboard pages

### Page 1 — Executive Overview
Cards:
- Total Sales
- Average Daily Sales
- Top Product
- Top Product Sales
- Sales YoY %

Charts:
- Line: Sales by Date
- Bar: Sales by Product
- Column: Sales by Month

Slicers:
- Year
- Month
- Product

### Page 2 — Product Performance
- Product sales ranking
- Product sales share %
- Product trend by year
- Product growth
- Product slicer

### Page 3 — Time & Demand
- Yearly trend
- Monthly seasonality
- Weekday sales
- Hourly sales pattern
- Date/Year slicer

### Page 4 — Commercial Insights
Use text boxes for:
- Top product concentration
- Strongest sales periods
- Peak demand timing
- Growth/decline observations
- Recommended commercial actions

## 5. Recommended formatting
- Use a clean professional healthcare/pharma visual style.
- Keep KPI cards at the top.
- Use consistent number formatting.
- Keep chart titles action-oriented.
- Avoid overcrowding the dashboard.
- Add a small footer: `Source: Pharmaceutical Sales Dataset | Analysis by Ravikumar Gujar`
