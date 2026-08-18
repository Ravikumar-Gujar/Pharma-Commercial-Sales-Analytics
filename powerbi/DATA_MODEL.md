# Power BI Data Model

## Tables

### Fact_DailySales
Daily commercial sales fact table with product-category sales and Total_Sales.

### Fact_HourlySales
Hourly sales fact table for intraday demand analysis.

### Dim_Date
Continuous calendar dimension used for time intelligence.

### Dim_Product
List of product/category codes.

## Relationships

Dim_Date[Date] -> Fact_DailySales[Date]
Dim_Date[Date] -> Fact_HourlySales[Date]

Recommended cardinality: One-to-many, single-direction filtering from Dim_Date to facts.

## Power Query recommendation

Unpivot the eight product columns in Fact_DailySales to create:
Product | Product Sales

This produces a cleaner star-schema product analysis model.
