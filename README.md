# Database Management Systems – Assignment 3

## Project Overview
This repository contains SQL queries, entity-relationship diagrams (ERDs), and documentation for **Database Assignment 3**.  
The purpose of this project is to apply concepts of relational modeling, integrity constraints, and SQL querying to a multi-table database representing an e-commerce system.

---

## Database Schema

### Relations
The database includes the following relations, where underlined attributes represent primary or foreign keys:

- **merchants**(`mid`, name, city, state)  
- **products**(`pid`, name, category, description)  
- **sell**(`mid`, `pid`, price, quantity_available)  
- **orders**(`oid`, shipping_method, shipping_cost)  
- **contain**(`oid`, `pid`)  
- **customers**(`cid`, fullname, city, state)  
- **place**(`cid`, `oid`, order_date)

### Data Source
The data files used in this assignment are available at:  
[https://github.com/bforoura/DBMS/tree/master/HW3](https://github.com/bforoura/DBMS/tree/master/HW3)

---

## Setup Instructions

1. Import all tables into MySQL using the provided data files.
2. Define **primary and foreign key constraints** according to the schema above.
3. Apply the following **column constraints**:

| Table | Constraint |
|--------|------------|
| `products.name` | Must be one of: Printer, Ethernet Adapter, Desktop, Hard Drive, Laptop, Router, Network Card, Super Drive, Monitor |
| `products.category` | Must be one of: Peripheral, Networking, Computer |
| `sell.price` | Between 0 and 100,000 |
| `sell.quantity_available` | Between 0 and 1,000 |
| `orders.shipping_method` | Must be one of: UPS, FedEx, USPS |
| `orders.shipping_cost` | Between 0 and 500 |
| `place.order_date` | Must be a valid date |

---

## SQL Questions

Each of the following questions is addressed in the accompanying `HW3.sql` file.  

1. List names and sellers of products that are no longer available (quantity = 0).  
2. List names and descriptions of products that are not sold.  
3. Determine how many customers bought SATA drives but not any routers.  
4. Apply a 20% sale for HP’s Networking products.  
5. Retrieve all products (names and prices) ordered from Acer by Uriel Whitney.  
6. List the annual total sales for each company, sorted by company and year.  
7. Identify the company with the highest annual revenue and the corresponding year.  
8. Determine the average cheapest shipping method ever used.  
9. Identify the best-selling (by dollar amount) category for each company.  
10. For each company, find which customers spent the most and least overall.

---

## Report Submission Guidelines

### Title Page
Include the following:
- Title: **DB Assignment 3**  
- Student Name  
- Date  

### SQL Section
For each problem:
- Clearly identify the question number.  
- Provide the complete and properly commented SQL query used to solve the problem.  
- Include a clear screenshot of the query output from MySQL Workbench.  
- Briefly explain what the query does and how it answers the question.  
- Include the ERD diagram of the database.

---

## Deliverables

| File | Description |
|------|-------------|
| `DBMS Assignment#3.docx` | Full report including queries, explanations, ERD, and screenshots |
| `HW#3.sql` | Well-documented SQL script with all queries |
| `README.md` | Project overview and submission details |

**Note:** Documentation quality accounts for 10% of the total grade.

---

## Submission Instructions

- Upload all required files to your GitHub repository.  
- Submit the repository link according to the course submission procedure.  
- Late submissions will follow the policy outlined in the course syllabus.

---

## Notes
- Verify that all constraints are correctly implemented in the database.  
- Ensure that primary and foreign key relationships are valid.  
- Use clear, properly formatted SQL code and include inline comments for readability.

---

**Author:** [Ihor Holubets]  
**Course:** Database Management Systems  
**Instructor:** [Dr. Babak Forouraghi] 
**Date:** [10/21/25]  

