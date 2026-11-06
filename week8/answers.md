USE infoman1_week8;
SELECT COUNT(*) FROM employee;  

-- Task 1.1: last name ends in 'ez'
SELECT emp_id, first_name, last_name
FROM employee
WHERE last_name LIKE '%ez';

-- Task 1.2: first name starts with 'Ma'
SELECT emp_id, first_name, department
FROM employee
WHERE first_name LIKE 'Ma%';

-- Task 1.3a: prove every code is E + 4 characters (expect 500 rows)
SELECT COUNT(*) AS matching_rows
FROM employee
WHERE emp_code LIKE 'E____';

-- Task 1.3b: third character is 0
SELECT emp_code, first_name, last_name
FROM employee
WHERE emp_code LIKE 'E_0__';

-- Task 2.1
SELECT COUNT(*) AS total_employees,
       COUNT(commission) AS with_commission
FROM employee;

-- Task 2.2
SELECT SUM(salary) AS total_monthly_payroll FROM employee;

-- Task 2.3
SELECT AVG(salary) AS avg_salary,
       MIN(hire_date) AS earliest_hire,
       MAX(hire_date) AS latest_hire
FROM employee;

-- Task 2.4
SELECT SUM(salary + COALESCE(commission, 0)) AS total_compensation
FROM employee;

-- Task 3.1
SELECT department,
       COUNT(*) AS headcount,
       AVG(salary) AS avg_salary,
       COUNT(DISTINCT job_title) AS distinct_titles
FROM employee
GROUP BY department;

-- Task 3.2
SELECT department, job_title, COUNT(*) AS headcount
FROM employee
GROUP BY department, job_title
ORDER BY department, job_title;

-- Task 4.1 (replace 60000 with YOUR chosen threshold after inspecting Task 3.1)
SELECT department, AVG(salary) AS avg_salary
FROM employee
GROUP BY department
HAVING AVG(salary) > 60000;

-- Task 4.2
SELECT department, COUNT(*) AS headcount
FROM employee
WHERE status = 'Active'
GROUP BY department
HAVING COUNT(*) > 50;