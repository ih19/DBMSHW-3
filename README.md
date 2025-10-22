Assume the following relations, where underlined attributes are primary or foreign keys:

merchants(mid, name, city, state)
products(pid, name, category, description)
sell(mid, pid, price, quantity_available)
orders(oid, shipping_method, shipping_cost)
contain(oid, pid)
customers(cid, fullname, city, state)
place(cid, oid, order_date)
 

The data tables can be found here: https://github.com/bforoura/DBMS/tree/master/HW3Links to an external site.

 

For each of the following questions write a SQL query:

List names and sellers of products that are no longer available (quantity=0)
List names and descriptions of products that are not sold.
How many customers bought SATA drives but not any routers?
HP has a 20% sale on all its Networking products.
What did Uriel Whitney order from Acer? (make sure to at least retrieve product names and prices).
List the annual total sales for each company (sort the results along the company and the year attributes).
Which company had the highest annual revenue and in what year?
On average, what was the cheapest shipping method used ever?
What is the best sold ($) category for each company?
For each company find out which customers have spent the most and the least amounts.
 

 

 

General Guidelines

Import the tables into MySQL.

Your tables must have primary or foreign key constraints along with these constraints:

Products name constraint: Printer, Ethernet Adapter, Desktop, Hard Drive, Laptop, Router, Network Card, Super Drive, Monitor
Products category constraint: Peripheral, Networking, Computer
Sell price constraint: between 0 and 100,000
Sell quantity_available constraint: between 0 and 1,000
Orders shipping_method constraint: UPS, FedEx, USPS
Orders shipping_cost constraint: between 0 and 500
Valid dates
 

 

Report Submission Guidelines

Title Page

Title: DB Assignment 3
Your Name: 
Date: 
 

SQL Section

Clearly identify each problem.
Include the complete documented SQL query used to solve the problem.
Provide a screenshot of the query results from Workbench along with the ERD diagram. Ensure screenshots are clear and include the results.
Briefly explain in words what the query does and how it solves the problem. 
Upload the complete PDF report (HW3.pdf) and the well-documented SQL script (HW3.sql) to your GitHub repo. 
Documentation counts as 10% of the total grade in this assignment.
Submit the link to your GitHub repo.
Please read the syllabus statement on late submissions.
