-- Retail Sales & Customer Behavior Analysis
-- Database setup for MySQL 8+

CREATE DATABASE IF NOT EXISTS retail_sales_analysis;
USE retail_sales_analysis;

DROP TABLE IF EXISTS sales_data;
DROP TABLE IF EXISTS customer_data;

CREATE TABLE customer_data (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(20),
    age INT,
    payment_method VARCHAR(30)
);

CREATE TABLE sales_data (
    invoice_no VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(12,2),
    invoice_date DATE,
    shopping_mall VARCHAR(100),
    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id) REFERENCES customer_data(customer_id)
);

CREATE INDEX idx_sales_customer ON sales_data(customer_id);
CREATE INDEX idx_sales_category ON sales_data(category);
CREATE INDEX idx_sales_date ON sales_data(invoice_date);
CREATE INDEX idx_sales_mall ON sales_data(shopping_mall);
