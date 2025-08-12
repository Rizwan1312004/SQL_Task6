CREATE DATABASE company_db;
USE company_db;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT NOT NULL,
    location TEXT
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    salary REAL,
    department_id INTEGER,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY,
    project_name TEXT NOT NULL,
    budget REAL,
    start_date DATE,
    end_date DATE
);

CREATE TABLE assignments (
    assignment_id INTEGER PRIMARY KEY,
    employee_id INTEGER,
    project_id INTEGER,
    role TEXT,
    hours_per_week INTEGER,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments (department_id, department_name, location) VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Sales', 'Chicago'),
(4, 'Marketing', 'Boston'),
(5, 'Finance', 'Los Angeles'),
(6, 'Engineering', 'Austin'),
(7, 'Support', 'Denver');

INSERT INTO employees (employee_id, first_name, last_name, salary, department_id, hire_date) VALUES
(101, 'Alice', 'Smith', 6000, 1, '2020-01-15'),
(102, 'Bob', 'Johnson', 7500, 2, '2019-06-20'),
(103, 'Charlie', 'Lee', 5000, 2, '2021-03-12'),
(104, 'Diana', 'Clark', 9000, 3, '2018-07-01'),
(105, 'Ethan', 'Harris', 8500, 3, '2022-02-25'),
(106, 'Fiona', 'Brown', 7000, 4, '2020-11-11'),
(107, 'George', 'Davis', 4000, 1, '2023-04-01'),
(108, 'Hannah', 'Miller', 9500, 5, '2017-05-10'),
(109, 'Ian', 'Wilson', 7800, 6, '2016-08-23'),
(110, 'Jane', 'Taylor', 8200, 6, '2019-09-30'),
(111, 'Kevin', 'Anderson', 6200, 7, '2021-12-17'),
(112, 'Laura', 'Thomas', 6700, 7, '2022-08-03');

INSERT INTO projects (project_id, project_name, budget, start_date, end_date) VALUES
(201, 'ERP System Upgrade', 150000, '2021-01-01', '2021-12-31'),
(202, 'Customer Portal', 100000, '2022-03-15', '2022-11-30'),
(203, 'Data Migration', 50000, '2023-05-01', '2023-09-30'),
(204, 'Cloud Infrastructure', 200000, '2020-06-01', '2021-06-01');

INSERT INTO assignments (assignment_id, employee_id, project_id, role, hours_per_week) VALUES
(1, 102, 201, 'Developer', 40),
(2, 103, 201, 'QA Tester', 35),
(3, 104, 202, 'Project Manager', 30),
(4, 105, 202, 'Sales Lead', 20),
(5, 106, 203, 'Marketing Lead', 25),
(6, 109, 204, 'Infrastructure Engineer', 40),
(7, 110, 204, 'DevOps Engineer', 35),
(8, 101, 203, 'HR Coordinator', 15),
(9, 112, 202, 'Support Analyst', 25),
(10, 111, 203, 'Support Engineer', 20);

SELECT 
    first_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary
FROM 
    employees;

SELECT first_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'Chicago'
);

SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1 
    FROM employees e
    WHERE e.department_id = d.department_id
);

SELECT first_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

SELECT e1.first_name, e1.salary, e1.department_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

SELECT department_id, avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg
WHERE avg_salary > 7000;
