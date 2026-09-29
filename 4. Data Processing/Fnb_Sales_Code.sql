-- Databricks notebook source
--Inspecting the raw data
SELECT *
FROM sales_casestudy.fnb.raw_data
LIMIT 10;

DESCRIBE sales_casestudy.fnb.raw_data;

--Checking number of rows:
Select COUNT(*) AS total_Rows
FROM sales_casestudy.fnb.raw_data;

--Checking for Null values
SELECT COUNT(*) AS total_rows,
SUM(CASE WHEN Date is Null THEN 1 ELSE 0 END) AS null_dates,
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
SUM(CASE WHEN `Cost Of Sales` IS NULL THEN 1 ELSE 0 END) AS null_cost_of_sales,
SUM(CASE WHEN `Quantity Sold` IS NULL THEN 1 ELSE 0 END) AS null_quantity
FROM Sales_casestudy.fnb.raw_data;

--checking duplicates
SELECT Date,
    COUNT(*) AS duplicate_count
FROM Sales_casestudy.fnb.raw_data
GROUP BY Date
HAVING COUNT(*) > 1
ORDER BY Date;

--Creating a cleaned temporary view:
CREATE OR REPLACE TEMP VIEW sales_cleaned AS
WITH cleaned AS (
    SELECT
        -- Date
        TO_DATE(TRIM(CAST(Date AS STRING))) AS sales_date,
        -- Sales
        CAST(Sales AS DECIMAL(18,2)) AS sales,
        -- Cost
        CAST(`Cost Of Sales` AS DECIMAL(18,2)) AS cost_of_sales,
        -- Quantity
        CAST(`Quantity Sold` AS INT) AS quantity_sold
    FROM Sales_casestudy.fnb.raw_data

),

validated AS (
    SELECT
        sales_date,
        sales,
        cost_of_sales,
        quantity_sold

    FROM cleaned
    WHERE sales_date IS NOT NULL
      AND sales IS NOT NULL
      AND cost_of_sales IS NOT NULL
      AND quantity_sold IS NOT NULL
      AND quantity_sold > 0
)

SELECT
    sales_date,
    sales,
    cost_of_sales,
    quantity_sold,

    -- Gross profit
    ROUND(sales - cost_of_sales, 2) AS gross_profit,
    -- Sales price per unit
    ROUND(sales / quantity_sold, 2) AS sales_price_per_unit,
    -- Cost per unit
    ROUND(cost_of_sales / quantity_sold, 2) AS cost_per_unit,
    -- Gross profit percentage
    ROUND(
        ((sales - cost_of_sales) / NULLIF(sales, 0)) * 100,
        2
    ) AS gross_profit_percentage,
    -- Year
    YEAR(sales_date) AS year,
    -- Month number
    MONTH(sales_date) AS month_number,
    -- Month name
    DATE_FORMAT(sales_date, 'MMMM') AS month_name,
    -- Quarter
    CONCAT('Q', QUARTER(sales_date)) AS quarter,
    -- Day number
    DAY(sales_date) AS day_number,
    -- Day name
    DATE_FORMAT(sales_date, 'EEEE') AS day_name,
    -- Week number
    WEEKOFYEAR(sales_date) AS week_number,
    -- Weekday/weekend
    CASE
        WHEN DAYOFWEEK(sales_date) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type

FROM validated;

--checking the cleaned data
SELECT *
FROM sales_cleaned
ORDER BY sales_date
LIMIT 100;

--checking nulls in cleaned data
SELECT
    SUM(CASE WHEN sales_date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN cost_of_sales IS NULL THEN 1 ELSE 0 END) AS null_cost,
    SUM(CASE WHEN quantity_sold IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN sales_price_per_unit IS NULL THEN 1 ELSE 0 END) AS null_unit_price
FROM sales_cleaned;

--Creating a permanent cleaned table
CREATE OR REPLACE TABLE FNB_sales_cleaned
USING DELTA
AS
SELECT *
FROM sales_cleaned;

--Daily sales price per unit
SELECT
    sales_date,
    ROUND(
        SUM(sales) / NULLIF(SUM(quantity_sold), 0),
        2
    ) AS daily_sales_price_per_unit
FROM sales_cleaned
GROUP BY sales_date
ORDER BY sales_date;

--Average unit sales price
SELECT
    ROUND(
        AVG(sales_price_per_unit),
        2
    ) AS average_unit_sales_price
FROM sales_cleaned;

--Daily profit
SELECT
    sales_date,
    ROUND(
        SUM(sales) - SUM(cost_of_sales),
        2
    ) AS daily_gross_profit
FROM sales_cleaned
GROUP BY sales_date
ORDER BY sales_date;

--Daily percentages of profits
SELECT
    sales_date,

    ROUND(
        (
            (SUM(sales) - SUM(cost_of_sales))
            / NULLIF(SUM(sales), 0)
        ) * 100,
        2
    ) AS daily_gross_profit_percentage

FROM sales_cleaned
GROUP BY sales_date
ORDER BY sales_date;

CREATE OR REPLACE TEMP VIEW fnb_sales_cleaned AS

SELECT
    sales_date,
    year,
    month_number,
    month_name,
    quarter,
    week_number,
    day_number,
    day_name,
    day_type,

    SUM(sales) AS total_sales,
    SUM(cost_of_sales) AS total_cost_of_sales,
    SUM(quantity_sold) AS total_quantity_sold,

    ROUND(
        SUM(sales) / NULLIF(SUM(quantity_sold), 0),
        2
    ) AS sales_price_per_unit,

    ROUND(
        SUM(cost_of_sales) / NULLIF(SUM(quantity_sold), 0),
        2
    ) AS cost_per_unit,

    ROUND(
        SUM(sales) - SUM(cost_of_sales),
        2
    ) AS gross_profit,

    ROUND(
        (
            (SUM(sales) - SUM(cost_of_sales))
            / NULLIF(SUM(sales), 0)
        ) * 100,
        2
    ) AS gross_profit_percentage

FROM sales_cleaned

GROUP BY
    sales_date,
    year,
    month_number,
    month_name,
    quarter,
    week_number,
    day_number,
    day_name,
    day_type;

SELECT *
FROM fnb_sales_cleaned
ORDER BY sales_date;