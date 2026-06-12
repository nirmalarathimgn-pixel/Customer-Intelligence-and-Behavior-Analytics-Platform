-- ==========================================
-- PRODUCT & USER BEHAVIOR ANALYTICS PLATFORM
-- ==========================================

DROP DATABASE IF EXISTS product_analytics;

CREATE DATABASE product_analytics;

USE product_analytics;

-- ==========================================
-- CREATE TABLE
-- ==========================================

CREATE TABLE sales_data (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Country VARCHAR(50),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Revenue DECIMAL(12,2)
);

-- ==========================================
-- SAMPLE DATA
-- ==========================================

INSERT INTO sales_data VALUES
(1001,'2024-01-01','C101','John Smith','USA','P001','Laptop','Technology',2,500,1000),
(1002,'2024-01-02','C102','Emma Brown','India','P002','Mouse','Technology',5,20,100),
(1003,'2024-01-03','C103','David Lee','UK','P003','Chair','Furniture',2,150,300),
(1004,'2024-01-04','C101','John Smith','USA','P004','Keyboard','Technology',3,40,120),
(1005,'2024-01-05','C104','Sophia White','India','P005','Table','Furniture',1,300,300),
(1006,'2024-01-06','C105','James Miller','Canada','P006','Notebook','Office Supplies',10,5,50),
(1007,'2024-01-07','C106','Olivia Clark','USA','P007','Printer','Technology',1,250,250),
(1008,'2024-01-08','C107','Liam Wilson','UK','P008','Desk','Furniture',1,400,400),
(1009,'2024-01-09','C108','Noah Davis','India','P009','Pen Set','Office Supplies',20,2,40),
(1010,'2024-01-10','C109','Ava Moore','USA','P010','Monitor','Technology',2,200,400);

-- ==========================================
-- KPI QUERIES
-- ==========================================

SELECT COUNT(*) AS Total_Orders
FROM sales_data;

SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM sales_data;

SELECT COUNT(DISTINCT Product_ID) AS Total_Products
FROM sales_data;

SELECT ROUND(SUM(Revenue),2) AS Total_Revenue
FROM sales_data;

SELECT ROUND(AVG(Revenue),2) AS Average_Order_Value
FROM sales_data;

-- ==========================================
-- MONTHLY REVENUE
-- ==========================================

SELECT
MONTH(Order_Date) AS Month_No,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY MONTH(Order_Date)
ORDER BY Month_No;

-- ==========================================
-- REVENUE BY COUNTRY
-- ==========================================

SELECT
Country,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Country
ORDER BY Revenue DESC;

-- ==========================================
-- REVENUE BY CATEGORY
-- ==========================================

SELECT
Category,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Category
ORDER BY Revenue DESC;

-- ==========================================
-- TOP 10 PRODUCTS
-- ==========================================

SELECT
Product_Name,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Product_Name
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================
-- TOP 10 CUSTOMERS
-- ==========================================

SELECT
Customer_ID,
Customer_Name,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================
-- MOST SOLD PRODUCTS
-- ==========================================

SELECT
Product_Name,
SUM(Quantity) AS Quantity_Sold
FROM sales_data
GROUP BY Product_Name
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- ==========================================
-- CUSTOMER PURCHASE FREQUENCY
-- ==========================================

SELECT
Customer_ID,
Customer_Name,
COUNT(Order_ID) AS Total_Orders
FROM sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Orders DESC;

-- ==========================================
-- REPEAT CUSTOMERS
-- ==========================================

SELECT
Customer_ID,
Customer_Name,
COUNT(Order_ID) AS Orders_Count
FROM sales_data
GROUP BY Customer_ID, Customer_Name
HAVING COUNT(Order_ID) > 1;

-- ==========================================
-- CUSTOMER SEGMENTATION
-- ==========================================

SELECT
Customer_ID,
Customer_Name,
SUM(Revenue) AS Total_Spent,
CASE
    WHEN SUM(Revenue) >= 1000 THEN 'High Value'
    WHEN SUM(Revenue) >= 500 THEN 'Medium Value'
    ELSE 'Low Value'
END AS Customer_Segment
FROM sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Spent DESC;

-- ==========================================
-- CATEGORY PERFORMANCE
-- ==========================================

SELECT
Category,
COUNT(Product_ID) AS Products,
SUM(Quantity) AS Quantity_Sold,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Category;

-- ==========================================
-- PRODUCT PERFORMANCE
-- ==========================================

SELECT
Product_ID,
Product_Name,
SUM(Quantity) AS Quantity_Sold,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Product_ID, Product_Name
ORDER BY Revenue DESC;

-- ==========================================
-- COUNTRY PERFORMANCE
-- ==========================================

SELECT
Country,
COUNT(Order_ID) AS Orders_Count,
SUM(Revenue) AS Revenue
FROM sales_data
GROUP BY Country
ORDER BY Revenue DESC;

-- ==========================================
-- EXECUTIVE SUMMARY
-- ==========================================

SELECT
COUNT(*) AS Total_Orders,
COUNT(DISTINCT Customer_ID) AS Total_Customers,
COUNT(DISTINCT Product_ID) AS Total_Products,
SUM(Revenue) AS Total_Revenue,
ROUND(AVG(Revenue),2) AS Average_Order_Value
FROM sales_data;
