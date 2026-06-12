# ==========================================
# PRODUCT & USER BEHAVIOR ANALYTICS PLATFORM
# ==========================================

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# ==========================================
# LOAD DATA
# ==========================================

df = pd.read_csv("sales_data.csv")

print("=" * 60)
print("PRODUCT & USER BEHAVIOR ANALYTICS")
print("=" * 60)

# ==========================================
# DATA INSPECTION
# ==========================================

print("\nDATA SHAPE")
print(df.shape)

print("\nFIRST 5 RECORDS")
print(df.head())

print("\nDATA TYPES")
print(df.dtypes)

print("\nMISSING VALUES")
print(df.isnull().sum())

# ==========================================
# DATA CLEANING
# ==========================================

df.drop_duplicates(inplace=True)

df.fillna(0, inplace=True)

df["Order_Date"] = pd.to_datetime(df["Order_Date"])

df["Month"] = df["Order_Date"].dt.month_name()

# ==========================================
# FEATURE ENGINEERING
# ==========================================

df["Order_Value"] = df["Quantity"] * df["Unit_Price"]

# ==========================================
# KPI CALCULATIONS
# ==========================================

total_orders = len(df)

total_customers = df["Customer_ID"].nunique()

total_products = df["Product_ID"].nunique()

total_revenue = round(df["Revenue"].sum(), 2)

avg_order_value = round(df["Revenue"].mean(), 2)

print("\nKPI SUMMARY")
print("-" * 50)

print("Total Orders :", total_orders)
print("Total Customers :", total_customers)
print("Total Products :", total_products)
print("Total Revenue :", total_revenue)
print("Average Order Value :", avg_order_value)

# ==========================================
# CUSTOMER ANALYSIS
# ==========================================

customer_analysis = (
    df.groupby(["Customer_ID","Customer_Name"])
    .agg(
        Orders=("Order_ID","count"),
        Revenue=("Revenue","sum")
    )
    .sort_values(by="Revenue",ascending=False)
)

print("\nTOP CUSTOMERS")
print(customer_analysis.head(10))

# ==========================================
# REPEAT CUSTOMERS
# ==========================================

repeat_customers = (
    customer_analysis[
        customer_analysis["Orders"] > 1
    ]
)

# ==========================================
# CUSTOMER SEGMENTATION
# ==========================================

customer_analysis["Segment"] = np.where(
    customer_analysis["Revenue"] >= 1000,
    "High Value",
    np.where(
        customer_analysis["Revenue"] >= 500,
        "Medium Value",
        "Low Value"
    )
)

# ==========================================
# PRODUCT ANALYSIS
# ==========================================

product_analysis = (
    df.groupby("Product_Name")
    .agg(
        Quantity_Sold=("Quantity","sum"),
        Revenue=("Revenue","sum")
    )
    .sort_values(
        by="Revenue",
        ascending=False
    )
)

print("\nTOP PRODUCTS")
print(product_analysis.head(10))

# ==========================================
# CATEGORY ANALYSIS
# ==========================================

category_analysis = (
    df.groupby("Category")
    ["Revenue"]
    .sum()
    .sort_values(ascending=False)
)

# ==========================================
# COUNTRY ANALYSIS
# ==========================================

country_analysis = (
    df.groupby("Country")
    ["Revenue"]
    .sum()
    .sort_values(ascending=False)
)

# ==========================================
# MONTHLY REVENUE
# ==========================================

monthly_revenue = (
    df.groupby("Month")
    ["Revenue"]
    .sum()
)

# ==========================================
# EXPORT FILES
# ==========================================

customer_analysis.to_csv(
    "customer_analysis.csv"
)

product_analysis.to_csv(
    "product_analysis.csv"
)

country_analysis.to_csv(
    "country_analysis.csv"
)

df.to_csv(
    "cleaned_sales_data.csv",
    index=False
)

# ==========================================
# CHART 1
# MONTHLY REVENUE
# ==========================================

plt.figure(figsize=(10,5))

monthly_revenue.plot(
    kind="line",
    marker="o"
)

plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue")

plt.tight_layout()

plt.savefig("monthly_revenue.png")

plt.close()

# ==========================================
# CHART 2
# TOP PRODUCTS
# ==========================================

plt.figure(figsize=(10,5))

product_analysis.head(10)["Revenue"].plot(
    kind="bar"
)

plt.title("Top 10 Products by Revenue")

plt.tight_layout()

plt.savefig("top_products.png")

plt.close()

# ==========================================
# CHART 3
# COUNTRY ANALYSIS
# ==========================================

plt.figure(figsize=(8,5))

country_analysis.plot(kind="bar")

plt.title("Revenue by Country")

plt.tight_layout()

plt.savefig("country_analysis.png")

plt.close()

# ==========================================
# CHART 4
# CATEGORY ANALYSIS
# ==========================================

plt.figure(figsize=(8,5))

category_analysis.plot(kind="bar")

plt.title("Revenue by Category")

plt.tight_layout()

plt.savefig("category_analysis.png")

plt.close()

# ==========================================
# CHART 5
# TOP CUSTOMERS
# ==========================================

plt.figure(figsize=(10,5))

customer_analysis.head(10)["Revenue"].plot(
    kind="bar"
)

plt.title("Top 10 Customers")

plt.tight_layout()

plt.savefig("top_customers.png")

plt.close()

# ==========================================
# FINAL OUTPUT
# ==========================================

print("\nFILES CREATED")
print("cleaned_sales_data.csv")
print("customer_analysis.csv")
print("product_analysis.csv")
print("country_analysis.csv")

print("\nCHARTS CREATED")
print("monthly_revenue.png")
print("top_products.png")
print("country_analysis.png")
print("category_analysis.png")
print("top_customers.png")

print("\nPROJECT COMPLETED SUCCESSFULLY")
