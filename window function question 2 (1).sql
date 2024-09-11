/*...........................  Window fuctions question 2  .........................*/
create database salesperson;
use salesperson;

create table sales (
id int not null,
salesperson_id int not null,
sale_date date not null,
amount int not null
);

insert into sales (id, salesperson_id, sale_date, amount)
values ( 1,101,'2024-01-01',200),
(2,102,'2024-01-02',150),
(3,101,'2024-01-03',300),
(4,102,'2024-01-04',100),
(5,101,'2024-01-05',250);

-- Q1.   Find the cumulative sum of sales for each salesperson ordered by the date of sale.
select *, sum(amount) over (partition by salesperson_id order by sale_date ) as 'cumulative sum' 
from sales; 

create table employees ( 
id int not null,
name varchar(30) not null,
department varchar(10) not null,
salary int not null
);

insert into employees(id, name, department, salary)
values( 1,'Alice','HR',50000),
(2,'Bob','HR',60000),
(3,'Charlie','IT',70000),
(4,'David','IT',80000),
(5,'Eve','HR',55000);

-- Q2.  Rank the employees based on their salaries within each department.
select *, rank() over (partition by department order by salary desc) as 'Rank' from employees;

-- Q3.  Calculate the average salary for each department and display it along with each employee's details.
select *, avg(salary)  over( partition by department ) as 'Average' from employees;

-- Q4.  Find the difference between each employee's salary and the average salary of their department.
select *, salary - avg(salary) over (partition by department ) as 'difference' from employees;

-- Q5.  List employees with their salaries and the maximum salary in their department.
select *, max(salary) over (partition by department) as 'Maximum Salary' from employees;




