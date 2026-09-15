# SQL Playbook

This repository is a structured playbook for writing practical, production-grade SQL used in data engineering and machine learning workflows.

It focuses on transforming raw relational data into clean, validated, and model-ready feature tables using SQL.

---

## It contains:

### 1. Core SQL building blocks:
- Filtering and selection (SELECT, WHERE, IN, BETWEEN, NULL handling)
- Aggregations (GROUP BY, HAVING, COUNT DISTINCT)
- Joins (INNER, LEFT, multi-table joins with correct cardinality)
- Conditional logic (CASE WHEN)
- Subqueries and CTEs (WITH clause)
- Window functions (ROW_NUMBER, RANK, SUM OVER with PARTITION BY)

---

### 2. Data transformation workflows:
- Converting raw transactional data into aggregated customer-level features
- Pre-aggregation before joins to avoid duplication issues
- Handling NULLs in joins and aggregations
- Writing modular and readable SQL using CTEs
- Adding sanity checks (row counts, distinct counts, duplicate detection)

---

### 3. Business-oriented problem solving:
- Customer-level feature generation for machine learning
- Transaction and behavior analysis
- Building model-ready datasets from multiple tables
- Feature engineering using SQL (aggregations, joins, window functions)

---

## Repository structure:

Each section represents a key concept in SQL and contains:

- A `.sql` file with clean, production-style queries
- A `notes.md` file with concise, interview-focused explanations:
  - What the query does
  - Why it is written that way
  - When to use / avoid
  - Common mistakes and failure cases

Each step produces a meaningful output (e.g., filtered data, aggregated tables, joined features) that builds toward a final feature dataset.

---

## Dataset

This playbook uses synthetic e-commerce data designed to practice SQL for data transformation, customer analysis, and ML feature engineering.

### `customers`

One row represents one customer.

| Column | Description |
|---|---|
| `customer_id` | Unique identifier for each customer |
| `name` | Customer name |
| `age` | Customer age |
| `country` | Customer's country |
| `income` | Customer income; may be NULL |
| `signup_date` | Date the customer signed up |
| `last_login_date` | Date of the customer's most recent login |

### `orders`

One row represents one customer order.

| Column | Description |
|---|---|
| `order_id` | Unique identifier for each order |
| `customer_id` | Identifier linking the order to a customer |
| `order_date` | Date the order was placed |
| `order_amount` | Monetary value of the order |

### Relationship

- `customers.customer_id` uniquely identifies a customer.
- `orders.customer_id` links an order to its customer.
- One customer can have multiple orders.
- Some customers have no orders.
- A customer can therefore appear multiple times after joining with `orders`.
- `income` can contain NULL values, allowing NULL-handling scenarios to be practiced.

The datasets are synthetic and created solely for SQL practice and feature engineering exercises.

---

## Additional components:

- `datasets/`
  - Structured datasets (ecommerce, credit risk) used across all queries
  - Ensures consistency and avoids context switching while learning

- `queries/`
  - Concept-based SQL files organized by topic
  - Focused on real-world data transformations and feature creation

- `mini_projects/`
  - End-to-end SQL use cases such as:
    - Customer segmentation
    - Credit risk feature engineering
  - Demonstrates how SQL is used to build ML-ready datasets

---

## Goals of this repository:

- Build strong intuition for data transformation using SQL
- Learn how SQL is used in real-world data pipelines
- Practice writing clean, readable, and maintainable queries
- Understand how to generate validated feature tables for machine learning
- Develop business-oriented thinking using data