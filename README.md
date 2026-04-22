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