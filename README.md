# Supermarket Retail Analytics

This project provides an end-to-end retail analytics pipeline using Python, SQL (PostgreSQL), and Power BI. The goal is to clean, explore, and visualize sales data to uncover actionable business insights for a supermarket chain.

---

## 📁 Project Files

| File Name                            | Description |
|-------------------------------------|-------------|
| `Supermarket Retail Analytics Dataset.csv` | Raw input dataset |
| `supermart_cleaned_dataset.csv`     | Cleaned and preprocessed dataset |
| `supermarket_retail_analytics.py`   | Python code for data cleaning, EDA, KPIs, clustering |
| `supermart_sales.sql`               | SQL scripts for DB creation and analysis |
| `Supermart_sales.pbix`              | Power BI interactive dashboard |
| `README.md`                         | Project overview and guide |

---

## 🧾 Dataset Overview

The dataset contains transactional records from a supermarket retail chain. It includes:
- `Order_ID`: Unique ID for each order
- `Customer_Name`: Name of the buyer
- `Order_Date`: Date of order
- `Category`, `Sub_Category`: Product classifications
- `City`, `Store_State`, `Region`: Store locations
- `Sales`, `Discount`, `Profit`: Financial details

---

## Tech Stack

| Tool                                 | Purpose |
|--------------------------------------|---------|
| Python (Pandas, Matplotlib, Seaborn) | Data cleaning, EDA, clustering |
| PostgreSQL                           | Data cleaning, EDA, SQL analysis & KPI generation |
| Power BI                             | Interactive dashboard |
| Google Colab                         | Code execution & analysis |

---

## How to Run the Project

### 1. Python Analysis
- Open `supermarket_retail_analytics.py` in **Google Colab** or **Jupyter Notebook**
- Required libraries:
  pip install pandas matplotlib seaborn scikit-learn

---

### 2. SQL Analysis
Run `supermart_sales.sql` in PostgreSQL
Get descriptive stats, trends, and KPIs using SQL queries

---

### 3. Power BI Dashboard
Open `Supermart_sales.pbix` in Power BI Desktop
Explore KPIs, filters, time-series charts, and region-wise performance

---

### Executive Summary: Insights & Recommendations
**Top Category Drive Revenue**: Snacks & Eggs, Meat & Fish are the most profitable and high-volume categories. Invest in supply chain and marketing for these.

**Sub-Category Focus**: Noodles and Fish offer consistently high profit margins. Explore bundling offers or featured listings for these.

**Regional Growth Opportunities**: Vellore city dominate revenue

**Seasonal Peaks**: October to December sees spikes in orders—likely festive-driven. Stock up and launch promotions in advance.

**Discount Efficiency**: Discount clustering revealed that excessive discounts do not always correlate with increased profit. Optimize discount thresholds to balance competitiveness and margin protection.

**Loss Leaders Identified**: A significant number of Masala products are being sold at a loss due to excessive discounts. These loss leaders have been identified using clustering techniques and exported for targeted action.

**Loss-Making Products**: Categories like Health Drinks and Spices frequently cause losses. Consider cost revaluation, supplier change, or promotional revamp.

