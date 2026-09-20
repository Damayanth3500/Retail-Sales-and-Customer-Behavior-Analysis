# Retail Sales & Customer Behavior Analysis

**SQL / MySQL Data Analytics Project**

A portfolio project focused on analyzing retail transactions and customer behavior using relational SQL queries. The analysis covers revenue performance, customer segmentation, payment behavior, category trends, shopping-mall performance, and time-based sales patterns.

## Project Objective

Use SQL to turn transaction and customer data into measurable business insights while demonstrating practical database and analytical SQL skills.

## Dataset

The project uses two CSV files:
- `data/sales_data.csv` — transaction-level sales data.
- `data/customer_data.csv` — customer demographics and payment method.

## Tech Stack
- MySQL 8+
- SQL
- MySQL Workbench
- CSV
- Git / GitHub

## SQL Concepts Demonstrated
- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate functions
- INNER / LEFT JOIN
- CASE expressions
- Common Table Expressions (CTEs)
- Subqueries
- Window functions (`DENSE_RANK`, `ROW_NUMBER`)
- Date-based aggregation
- Customer segmentation
- Index creation
- Data-quality checks

## Project Structure
```text
Retail-Sales-and-Customer-Behavior-Analysis/
├── data/
│   ├── customer_data.csv
│   └── sales_data.csv
├── sql/
│   ├── 01_schema.sql
│   └── 02_analysis.sql
├── docs/
│   └── insights.md
└── README.md
```

## How to Run
1. Install MySQL 8+ and open MySQL Workbench.
2. Run `sql/01_schema.sql`.
3. Import the CSV files into the corresponding tables.
4. Run `sql/02_analysis.sql` query by query.
5. Review `docs/insights.md`.

## Verified Dataset Results
The supplied data contains **99,457 transactions** and **99,457 unique customers**, with calculated revenue of **$251,505,794.25** and an average transaction value of **$2,528.79**.

## Resume Description
**Retail Sales & Customer Behavior Analysis | SQL, MySQL**
- Analyzed 99K+ retail transactions using MySQL to identify revenue trends, customer behavior, product-category performance, and shopping-mall sales patterns.
- Built SQL analysis using joins, CTEs, subqueries, CASE expressions, aggregations, and window functions.
- Performed data-quality checks and translated transaction-level data into measurable business insights.

## Portfolio Note
This repository is a personalized implementation based on a publicly available retail analytics dataset/project structure. The SQL organization, documentation, validation, and analysis were rewritten for this portfolio. The underlying CSV data remains the supplied dataset.
