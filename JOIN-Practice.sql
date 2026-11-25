
CREATE DATABASE join_database;
USE join_database;

CREATE TABLE table1 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    phone_number VARCHAR(15)
);

INSERT INTO table1
(id, first_name, last_name, city, phone_number)
VALUES
(1, 'Rahul', 'Sharma', 'Delhi', '9876543210'),
(2, 'Priya', 'Verma', 'Mumbai', '8765432109'),
(3, 'Amit', 'Patel', 'Ahmedabad', '7654321098'),
(4, 'Anjali', 'Singh', 'Kolkata', '6543210987'),
(5, 'Vijay', 'Kumar', 'Bangalore', '5432109876');

-- table 2
CREATE TABLE table2 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10,2),
    address VARCHAR(150)
);

INSERT INTO table2
(id, first_name, last_name, city, salary, address)
VALUES
(3, 'Amit', 'Patel', 'Ahmedabad', 75000.00, 'Street 21, Ahmedabad, Gujarat'),
(4, 'Anjali', 'Singh', 'Kolkata', 82000.00, 'Park Street, Kolkata, West Bengal'),
(5, 'Vijay', 'Kumar', 'Bangalore', 92000.00, 'MG Road, Bangalore, Karnataka'),
(6, 'Sanjay', 'Reddy', 'Hyderabad', 70000.00, 'Banjara Hills, Hyderabad, Telangana'),
(7, 'Megha', 'Iyer', 'Chennai', 88000.00, 'Anna Nagar, Chennai, Tamil Nadu');

-- EMPLOYEES SELF JOIN TABLE
CREATE TABLE employees_selfjoin (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT NULL
);

INSERT INTO employees_selfjoin
(employee_id, name, manager_id)
VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2),
(5, 'Eve', 2);
-- Q1

SELECT 
    t1.id,
    t1.first_name,
    t1.city,
    t1.phone_number,
    t2.salary
FROM table1 t1
INNER JOIN table2 t2
    ON t1.id = t2.id
WHERE t2.salary > 75000
ORDER BY t2.salary DESC;


-- Q2

SELECT 
    t1.id,
    t1.first_name,
    t1.city,
    t2.salary,
    t2.address
FROM table1 t1
LEFT JOIN table2 t2
    ON t1.id = t2.id
WHERE t1.city IN ('Delhi', 'Kolkata', 'Bangalore')
ORDER BY t1.id ASC;


-- Q3

SELECT 
    t2.id,
    t2.first_name,
    t2.salary,
    t1.phone_number
FROM table1 t1
RIGHT JOIN table2 t2
    ON t1.id = t2.id
WHERE t2.salary >= 80000
ORDER BY t2.salary DESC
LIMIT 2;


-- Q4

SELECT 
    t1.id,
    t1.first_name,
    t1.phone_number,
    t2.salary
FROM table1 t1
LEFT JOIN table2 t2
    ON t1.id = t2.id

UNION

SELECT 
    t2.id,
    t2.first_name,
    t1.phone_number,
    t2.salary
FROM table1 t1
RIGHT JOIN table2 t2
    ON t1.id = t2.id

ORDER BY id ASC;


-- Q5

SELECT 
    t1.id AS table1_id,
    t1.first_name AS table1_first_name,
    t2.id AS table2_id,
    t2.first_name AS table2_first_name
FROM table1 t1
CROSS JOIN table2 t2
ORDER BY t1.id ASC, t2.id ASC
LIMIT 10;


-- Q6

SELECT t1.*
FROM table1 t1
LEFT JOIN table2 t2
    ON t1.id = t2.id
WHERE t2.id IS NULL
ORDER BY t1.first_name ASC;


-- Q7

SELECT t2.*
FROM table1 t1
RIGHT JOIN table2 t2
    ON t1.id = t2.id
WHERE t1.id IS NULL
  AND t2.salary > 75000
ORDER BY t2.salary DESC;


-- Q8

SELECT 
    t1.id,
    t1.first_name,
    'table1' AS source_table
FROM table1 t1
LEFT JOIN table2 t2
    ON t1.id = t2.id
WHERE t2.id IS NULL

UNION ALL

SELECT 
    t2.id,
    t2.first_name,
    'table2' AS source_table
FROM table2 t2
LEFT JOIN table1 t1
    ON t2.id = t1.id
WHERE t1.id IS NULL

ORDER BY first_name ASC, id ASC
LIMIT 3;


-- Q9

SELECT 
    t1.first_name,
    t1.last_name,
    t1.city,
    t1.phone_number,
    t2.salary
FROM table1 t1
INNER JOIN table2 t2
    ON t1.id = t2.id
WHERE t2.salary > 70000
ORDER BY t2.salary DESC, t1.id ASC
LIMIT 2;


-- Q10

SELECT 
    e.employee_id AS employee_id,
    e.name AS employee_name,
    m.name AS manager_name
FROM employees_selfjoin e
JOIN employees_selfjoin m
    ON e.manager_id = m.employee_id
WHERE m.name = 'Bob'
ORDER BY e.employee_id DESC
LIMIT 1;


