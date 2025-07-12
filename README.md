# dbt Project - Northwind Model

This project uses dbt to transform data from the Northwind model in Redshift Serverless, implementing a denormalized analytics-ready schema with yearly partitioning.

## Key Features
- Data cleaning and deduplication
- Calculated columns and business logic
- Complete denormalization of operational schema
- Yearly partitioning for performance optimization

## Original Data Schema

<p  align="center">
  <img width="515" height="542" alt="schema_db" src="https://github.com/user-attachments/assets/8c7b06e0-bbce-4df0-816b-f7634494cb7e">
</p>


The Northwind database contains:
- Customers
- Employees
- Orders
- OrderDetails
- Products
- Suppliers
- Categories
- Shippers

## Transformation Pipeline

### 1. Customers
- Removed duplicate records
- Standardized address fields

### 2. Employees
- Added calculated columns:
  - `age` (from birth_date)
  - `lengthofservice` (from hire_date)
  - `full_name` (first_name + last_name)

### 3. Order Details
- Calculated:
  - `total_amount` (unit_price * quantity)
  - `discount_amount` (total - (product.unit_price * quantity))

### 4. Denormalization Process
1. **Model 1**: Products with Suppliers and Categories
2. **Model 2**: OrderDetails joined with Model 1
3. **Model 3**: Orders with Customers, Employees, and Shippers
4. **Final Model**: Inner join of Model 2 and Model 3

### 5. Yearly Partitioning
- Implemented on final denormalized model
- Partitions:
  - `northwind_2020` (orders from 2020)
  - `northwind_2021` (orders from 2021) 
  - `northwind_2022` (orders from 2022)
 
## Data Quality Tests

### Custom Test: Check Duplicates
Created a custom test `checkduplicates` to verify data integrity in the customers staging model:

**Location:**
```
tests
├── checkduplicates.sql
```

### How to Run:

#### Run all tests
```
dbt test
```

#### Run specific duplicate check
```
dbt test --select test_type:singular test_name:checkduplicates
```

## Project Structure:
```
models/
├── staging/
│ ├── customers.sql
│ ├── employees.sql
│ └── orderdetails.sql
├── intermediate/
│ ├── northwind_denormalized.sql
└── marts/
├── northwind_2020.sql
├── northwind_2021.sql
└── northwind_2022.sql
```


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
