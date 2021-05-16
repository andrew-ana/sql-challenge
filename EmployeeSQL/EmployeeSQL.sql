
-- Andrew Anastasiades | @andrew-ana

-- DATA ENGINEERING

-- Created tables using QuickDBD

departments
-
dept_no VARCHAR PK
dept_name VARCHAR

employees
-
emp_no INT PK
emp_title_id VARCHAR FK - titles.title_id
birth_date DATE
first_name VARCHAR
last_name VARCHAR
sex VARCHAR
hire_date DATE

titles
-
title_id VARCHAR PK
title VARCHAR

dept_emp
-
emp_no INT FK - employees.emp_no 
dept_no VARCHAR FK - departments.dept_no

salaries
-
emp_no INT FK - employees.emp_no
salary VARCHAR

dept_manager
-
dept_no VARCHAR FK - departments.dept_no
emp_no INT FK - employees.emp_no

-- Manually imported csvs in the order that I check their values 

select * from employees limit(100)

select * from titles limit(100)

select * from departments limit(100)

select * from salaries limit(100)

select * from dept_emp limit(100)

select * from dept_manager limit(100)

-- Added Primary Keys to the ones I missed.

alter table dept_emp 
add primary key (emp_no, dept_no);

alter table dept_manager 
add primary key (dept_no, emp_no);

alter table salaries 
add primary key (emp_no);

-- DATA ANALYSIS

-- 1. Employee Salaries
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees e, salaries s
where e.emp_no = s.emp_no;

-- 2. Hired in '86
select first_name, last_name, hire_date
from employees
where date_part('year', hire_date) = 1986;

-- 3. Department Managers
select d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
from employees e, departments d, dept_manager dm 
where e.emp_no = dm.emp_no and d.dept_no = dm.dept_no;

-- 4. Department Employees
select e.emp_no, e.last_name, e.first_name, d.dept_name 
from employees e, departments d, dept_emp de 
where e.emp_no = de.emp_no and d.dept_no = de.dept_no;

-- 5. Hercules B. Workin!
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

-- 6. Salespersons
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e, departments d, dept_emp de 
where d.dept_name = 'Sales' 
and d.dept_no = de.dept_no 
and e.emp_no = de.emp_no;

-- 7. Slimies & Deviants
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e, departments d, dept_emp de 
where 
(d.dept_name = 'Sales' or d.dept_name = 'Development')
and d.dept_no = de.dept_no 
and e.emp_no = de.emp_no;

-- 8. Baba and Foolsday
select last_name, count(last_name)
from employees
group by
last_name
order by
count(last_name) desc;