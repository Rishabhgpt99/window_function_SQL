/*  WINDOW FUNCTION QUESTIONS */
create database sales_ds ;
use sales_ds;

CREATE TABLE Sales (
    SaleID INT,
    SaleDate DATE,
    CustomerID INT,
    ProductID INT,
    Amount DECIMAL(10, 2)
);

INSERT INTO Sales (SaleID, SaleDate, CustomerID, ProductID, Amount) VALUES
(1, '2024-01-01', 101, 1001, 150.00),
(2, '2024-01-02', 102, 1002, 200.00),
(3, '2024-01-03', 101, 1001, 100.00),
(4, '2024-01-04', 103, 1003, 300.00),
(5, '2024-01-05', 102, 1002, 250.00),
(6, '2024-01-06', 101, 1001, 175.00),
(7, '2024-01-07', 104, 1004, 400.00),
(8, '2024-01-08', 105, 1005, 350.00),
(9, '2024-01-09', 102, 1002, 225.00),
(10, '2024-01-10', 101, 1001, 125.00);

/* Question 1: Calculate the running total of sales amount.  */
select saleID, saleDate, CustomerID, ProductID, Amount,
sum(Amount) over(partition by CustomerID order by Amount) as 'Running total' 
from Sales;

-- Question 2: Calculate the average sales amount over the last 3 sales.
select saleID, saleDate, CustomerID, ProductID, Amount,
AVG(Amount) over(order by Amount rows between 2 preceding and current row) as 'last 3 Average' 
from Sales; 

-- Question 3: Rank the sales by amount for each customer.
select saleID, saleDate, CustomerID, ProductID, Amount,
RANK() over(order by Amount) as 'RANK' 
from Sales; 

-- Question 4: Calculate the cumulative distribution of sales amount.
select saleID, saleDate, CustomerID, ProductID, Amount,
CUME_DIST() OVER( order by Amount) as 'cumulative distribution'
from Sales;

-- Question 5: Calculate the difference in sales amount between the current sale and the previous sale.
select saleID, saleDate, CustomerId, ProductID, Amount , Amount - lag(Amount) over ( order by Amount) as 'Difference ' from Sales;
/* or if we see date wise */
select saleID, saleDate, CustomerId, ProductID, Amount , Amount - lag(Amount) over ( order by saleDate) as 'Difference ' from Sales;

-- Question 6: Calculate the lead sales amount for the next sale.
select saleID, saleDate, CustomerId, ProductID, Amount, lead(Amount) over (order by Amount) as 'Lead sales for next sales' from Sales;

-- Question 7: Find the first sale amount for each customer.
select saleID, saleDate, CustomerId, ProductID, Amount, first_value(Amount) over ( partition by CustomerID order by saleDate) as 'first value' from Sales;

