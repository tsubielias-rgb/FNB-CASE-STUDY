📊 **FNB Sales Case Study**
📌 **Project Overview**

This project analyses a simulated retail sales dataset provided as part of a Data Analyst case study.  

The dataset contains daily trading information for a large retail store and represents sales for one product. Each record provides information about the date, sales value, cost of sales, and quantity sold.  

The objective is to develop relevant sales and profitability metrics, investigate the effect of promotional pricing, and derive additional business insights from the available data.  

🎯 **Business Objective**  

The main objective of this case study is to analyse the product's sales performance and develop metrics that can support business decision-making.  

The required analysis includes:  

Daily sales price per unit  
Average unit sales price  
Daily percentage gross profit  
Daily percentage gross profit per unit  
Price Elasticity of Demand during three promotional periods  
Assessment of product performance during promotional pricing  
Additional insights using visuals, reports, dashboards, KPIs, or other metrics  

🗂️ **Dataset**  

The dataset contains the following fields:  
Date  	Day on which the sales occurred  
Sales  	Total Rand value of sales  
Cost of Sales  	Total Rand value of the cost of sales  
Quantity   Sold	Total number of units sold  

These are the four data elements specified in the case study.  

📈 Key Metrics  
1. Daily Sales Price per Unit  

The daily sales price per unit can be calculated as:  

Daily Sales Price per Unit =  
Sales ÷ Quantity Sold  

Example SQL:  

SELECT  
    Date,  
    Sales,  
    Quantity_Sold,  
    ROUND(Sales / Quantity_Sold, 2) AS Daily_Sales_Price_Per_Unit  
FROM sales;  
2. Average Unit Sales Price  

The average unit sales price can be calculated using the daily unit prices:  

Average Unit Sales Price =  
Average of Daily Sales Price per Unit  

Example:  

SELECT  
    ROUND(  
        AVG(Sales / Quantity_Sold),  
        2  
    ) AS Average_Unit_Sales_Price  
FROM sales;  
💰 3. Daily Gross Profit %  

Daily gross profit is calculated as:  

Gross Profit = Sales - Cost of Sales  

Gross profit percentage:  

Gross Profit % =  
((Sales - Cost of Sales) ÷ Sales) × 100  

Example SQL:  

SELECT  
    Date,  
    Sales,  
    Cost_of_Sales,  
    ROUND(  
        ((Sales - Cost_of_Sales) / Sales) * 100,  
        2  
    ) AS Daily_Gross_Profit_Percentage  
FROM sales;  
💵 4. Daily Gross Profit per Unit  

Gross profit per unit can be calculated as:  

Gross Profit per Unit =  
(Sales - Cost of Sales) ÷ Quantity Sold  

Example:  

SELECT  
    Date,  
    ROUND(  
        (Sales - Cost_of_Sales) / Quantity_Sold,  
        2  
    ) AS Gross_Profit_Per_Unit  
FROM sales;  
📉 5. Price Elasticity of Demand   

The case study requires selecting three periods when the product was on promotion/special and calculating the Price Elasticity of Demand for each period.  

Price Elasticity of Demand measures how responsive quantity demanded is to a change in price.  

A commonly used formula is:  

Price Elasticity of Demand =  
% Change in Quantity Demanded  
÷  
% Change in Price  

The analysis should identify three promotional periods from the dataset and compare the relevant price and quantity changes.  
Field	Description  
Date	Day on which the sales occurred  
Sales	Total Rand value of sales  
Cost of Sales	Total Rand value of the cost of sales  
Quantity Sold	Total number of units sold  

These are the four data elements specified in the case study.  

📈 Key Metrics  
1. Daily Sales Price per Unit  

The daily sales price per unit can be calculated as:  

Daily Sales Price per Unit =  
Sales ÷ Quantity Sold  

Example SQL:  

SELECT  
    Date,  
    Sales,  
    Quantity_Sold,  
    ROUND(Sales / Quantity_Sold, 2) AS Daily_Sales_Price_Per_Unit  
FROM sales;  
2. Average Unit Sales Price  

The average unit sales price can be calculated using the daily unit prices:  

Average Unit Sales Price =  
Average of Daily Sales Price per Unit  

Example:  

SELECT  
    ROUND(  
        AVG(Sales / Quantity_Sold),  
        2  
    ) AS Average_Unit_Sales_Price  
FROM sales;  
💰 3. Daily Gross Profit %  

Daily gross profit is calculated as:  

Gross Profit = Sales - Cost of Sales  

Gross profit percentage:  

Gross Profit % =  
((Sales - Cost of Sales) ÷ Sales) × 100  

Example SQL:  

SELECT  
    Date,  
    Sales,  
    Cost_of_Sales,  
    ROUND(  
        ((Sales - Cost_of_Sales) / Sales) * 100,  
        2  
    ) AS Daily_Gross_Profit_Percentage  
FROM sales;  
💵 4. Daily Gross Profit per Unit  

Gross profit per unit can be calculated as:  

Gross Profit per Unit =  
(Sales - Cost of Sales) ÷ Quantity Sold  

Example:  

SELECT  
    Date,  
    ROUND(  
        (Sales - Cost_of_Sales) / Quantity_Sold,  
        2  
    ) AS Gross_Profit_Per_Unit  
FROM sales;  
📉 5. Price Elasticity of Demand  

The case study requires selecting three periods when the product was on promotion/special and calculating the Price Elasticity of Demand for each period.  

Price Elasticity of Demand measures how responsive quantity demanded is to a change in price.  

A commonly used formula is:  

Price Elasticity of Demand =  
% Change in Quantity Demanded  
÷
% Change in Price  

The analysis should identify three promotional periods from the dataset and compare the relevant price and quantity changes.  
