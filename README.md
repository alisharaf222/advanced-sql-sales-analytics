# 📊 Sales & Enterprise Data Warehouse Analytics Engine (T-SQL)

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-Advanced-blue?style=for-the-badge)
![Data Analytics](https://img.shields.io/badge/Data%20Analytics-Enterprise-green?style=for-the-badge)
![Business Intelligence](https://img.shields.io/badge/Business%20Intelligence-Advanced-orange?style=for-the-badge)

## 📌 Project Overview

This repository hosts an enterprise-grade **T-SQL Data Analytics Engine** designed to process, explore, and analyze complex sales datasets. The project simulates a real-world Business Intelligence pipeline where raw transactional and dimension data are transformed into strategic insights to support key executive decisions.

By executing structured scripts divided into distinct phases, this analytical engine identifies revenue drivers, calculates period-over-period growth metrics, models customer behavior (RFM/Segmentation), and evaluates product portfolio performance.

---

## 📂 Repository Architecture & File Mapping

```text
advanced-sql-sales-analytics/
│
├── datasets/                            # Primary relational datasets (CSV format)
│   ├── dim_customers.csv               # Customer master data (Demographics, Geography, Sign-up Dates)
│   ├── dim_products.csv                # Product catalog (Categories, Sub-categories, Unit Costs)
│   └── fact_sales.csv                  # Core transactional records (Sales Amount, Quantities, Dates)
│
├── scripts/                             # Modular T-SQL scripts sequence
│   ├── 01_exploratory_data_analysis/   # Data profiling, integrity checks, & distribution scripts
│   │   ├── 01_data_profiling.sql
│   │   └── 02_summary_statistics.sql
│   │
│   └── 02_advanced_business_analytics/ # Complex analytical queries & reporting scripts
│       ├── 01_time_series_growth.sql
│       ├── 02_customer_segmentation.sql
│       └── 03_product_performance.sql
│
├── docs/                                # Project documentation & structural assets
│   └── data_warehouse_schema.png       # Relational Entity-Relationship Diagram (ERD)
│
├── .gitignore                          # Git tracking rules
├── LICENSE                             # MIT License
└── README.md                           # Project documentation
```

---

## 🗂️ Data Model / Schema

```text
+-------------------+       +--------------------+       +-------------------+
|   dim_customers   |       |     fact_sales     |       |   dim_products    |
+-------------------+       +--------------------+       +-------------------+
| PK  customer_id   |<----->| FK  customer_id    |       | PK  product_id    |
|     customer_name |       | FK  product_id     |<----->|     product_name  |
|     country       |       |     order_date     |       |     category      |
|     segment       |       |     sales_amount   |       |     unit_cost     |
+-------------------+       |     quantity       |       +-------------------+
                            +--------------------+
```

---

## 📊 Detailed Analytical Scope & Methodology

### 1. Exploratory Data Analysis (EDA) & Data Profiling

Before applying business logic, raw records undergo strict verification and baseline statistics profiling:

* **Integrity Validation:** Querying orphan records, detecting null keys, and validating date ranges across dimension joins.
* **Descriptive Metrics:** Calculating overall Revenue, Total Orders, Average Order Value (AOV), Total Quantity Sold, and Active Customer Counts.
* **Distribution Mapping:** Identifying sales distribution across regional territories and product categories.

### 2. Advanced Business Analytics Engine

The core analytical pipeline leverages advanced T-SQL capabilities to solve high-level business problems:

#### 📈 Time-Series & Growth Trends (`01_time_series_growth.sql`)

* **Year-over-Year (YoY) & Month-over-Month (MoM):** Evaluating momentum by comparing current period sales against historical periods using `LAG()` window functions.
* **Running & Cumulative Totals:** Tracking financial year-to-date (YTD) accumulation across historical timelines.
* **Moving Averages:** Applying rolling 3-month averages to smooth out seasonal volatility.

#### 👤 Customer Intelligence & Segmentation (`02_customer_segmentation.sql`)

* **Customer Value Ranking:** Classifying top revenue contributors using `DENSE_RANK()` and `NTILE(4)` quartiles.
* **Purchase Recency & Frequency:** Tracking transaction patterns to flag churn risks and identify loyal accounts.
* **Pareto Analysis (80/20 Rule):** Evaluating customer concentration risk using cumulative percentage calculations.

#### 📦 Product Portfolio Performance (`03_product_performance.sql`)

* **Category Profitability:** Merging catalog cost structures with revenue metrics to analyze gross margins.
* **Part-to-Whole Contribution:** Computing product revenue shares relative to total organizational sales.
* **Top & Bottom Performers:** Ranking products by revenue generated vs. unit velocity.
---

---

## 🛠 Prerequisites & Execution Guide

### Requirements

* Microsoft SQL Server 2019+ or Azure SQL Database.
* SQL Server Management Studio (SSMS) or Azure Data Studio.

### Quick Start Instructions

**1. Clone the Repository:**

```bash
git clone https://github.com/YourUsername/advanced-sql-sales-analytics.git
```

**2. Setup Database & Load Data:**

* Create a local database named `SalesDataWarehouse`.
* Import `dim_customers.csv`, `dim_products.csv`, and `fact_sales.csv` using the SSMS Import Flat File Wizard.

**3. Execute Analysis Pipelines:**

* Run scripts under `scripts/01_exploratory_data_analysis/` to complete initial validation.
* Run scripts under `scripts/02_advanced_business_analytics/` to generate business reporting datasets.

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.
