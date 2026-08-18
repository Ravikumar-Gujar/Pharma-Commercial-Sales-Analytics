-- Pharma Commercial Sales Analytics
-- SQL Analysis Script
-- Primary analytical grain: daily sales
-- Source: data/processed/salesdaily_processed.csv

-- 1. Total sales
SELECT ROUND(SUM(Total_Sales), 2) AS total_sales
FROM daily_sales;

-- 2. Average daily sales
SELECT ROUND(AVG(Total_Sales), 2) AS average_daily_sales
FROM daily_sales;

-- 3. Product sales ranking
SELECT Product,
       ROUND(Total_Sales, 2) AS total_sales,
       ROUND(100.0 * Total_Sales / SUM(Total_Sales) OVER (), 2) AS sales_share_pct
FROM (
    SELECT 'M01AB' AS Product, SUM(M01AB) AS Total_Sales FROM daily_sales
    UNION ALL SELECT 'M01AE', SUM(M01AE) FROM daily_sales
    UNION ALL SELECT 'N02BA', SUM(N02BA) FROM daily_sales
    UNION ALL SELECT 'N02BE', SUM(N02BE) FROM daily_sales
    UNION ALL SELECT 'N05B', SUM(N05B) FROM daily_sales
    UNION ALL SELECT 'N05C', SUM(N05C) FROM daily_sales
    UNION ALL SELECT 'R03', SUM(R03) FROM daily_sales
    UNION ALL SELECT 'R06', SUM(R06) FROM daily_sales
)
ORDER BY Total_Sales DESC;

-- 4. Yearly sales and YoY growth
WITH yearly AS (
    SELECT Year, SUM(Total_Sales) AS total_sales
    FROM daily_sales
    GROUP BY Year
)
SELECT Year,
       ROUND(total_sales, 2) AS total_sales,
       ROUND(100.0 * (total_sales - LAG(total_sales) OVER (ORDER BY Year))
             / NULLIF(LAG(total_sales) OVER (ORDER BY Year), 0), 2) AS yoy_growth_pct
FROM yearly
ORDER BY Year;

-- 5. Monthly seasonality
SELECT Month,
       ROUND(SUM(Total_Sales), 2) AS total_sales
FROM daily_sales
GROUP BY Month
ORDER BY Month;

-- 6. Weekday performance
SELECT "Weekday Name" AS weekday,
       ROUND(SUM(Total_Sales), 2) AS total_sales
FROM daily_sales
GROUP BY "Weekday Name"
ORDER BY total_sales DESC;

-- 7. Best sales day
SELECT DATE(datum) AS sales_date,
       ROUND(Total_Sales, 2) AS total_sales
FROM daily_sales
ORDER BY Total_Sales DESC
LIMIT 10;

-- 8. Product contribution by year
WITH product_year AS (
    SELECT Year, 'M01AB' AS Product, SUM(M01AB) AS Sales FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'M01AE', SUM(M01AE) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N02BA', SUM(N02BA) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N02BE', SUM(N02BE) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N05B', SUM(N05B) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N05C', SUM(N05C) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'R03', SUM(R03) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'R06', SUM(R06) FROM daily_sales GROUP BY Year
)
SELECT Year, Product, ROUND(Sales, 2) AS sales
FROM product_year
ORDER BY Year, sales DESC;

-- 9. Highest-performing product in each year
WITH product_year AS (
    SELECT Year, 'M01AB' AS Product, SUM(M01AB) AS Sales FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'M01AE', SUM(M01AE) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N02BA', SUM(N02BA) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N02BE', SUM(N02BE) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N05B', SUM(N05B) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'N05C', SUM(N05C) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'R03', SUM(R03) FROM daily_sales GROUP BY Year
    UNION ALL SELECT Year, 'R06', SUM(R06) FROM daily_sales GROUP BY Year
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY Year ORDER BY Sales DESC) AS rnk
    FROM product_year
)
SELECT Year, Product, ROUND(Sales, 2) AS sales
FROM ranked
WHERE rnk = 1
ORDER BY Year;

-- 10. Monthly product performance
WITH monthly_product AS (
    SELECT Month, 'M01AB' AS Product, SUM(M01AB) AS Sales FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'M01AE', SUM(M01AE) FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'N02BA', SUM(N02BA) FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'N02BE', SUM(N02BE) FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'N05B', SUM(N05B) FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'N05C', SUM(N05C) FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'R03', SUM(R03) FROM daily_sales GROUP BY Month
    UNION ALL SELECT Month, 'R06', SUM(R06) FROM daily_sales GROUP BY Month
)
SELECT Month, Product, ROUND(Sales, 2) AS sales
FROM monthly_product
ORDER BY Month, sales DESC;

-- 11. Data quality: missing values in key fields
SELECT
    SUM(CASE WHEN datum IS NULL THEN 1 ELSE 0 END) AS missing_dates,
    SUM(CASE WHEN Total_Sales IS NULL THEN 1 ELSE 0 END) AS missing_total_sales
FROM daily_sales;

-- 12. Data quality: duplicate dates
SELECT DATE(datum) AS sales_date, COUNT(*) AS row_count
FROM daily_sales
GROUP BY DATE(datum)
HAVING COUNT(*) > 1
ORDER BY row_count DESC;
