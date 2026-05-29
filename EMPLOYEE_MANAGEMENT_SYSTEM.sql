create database employee_payroll;
use employee_payroll;

create table employees(employee_id int auto_increment primary key,employee_name varchar(255),department varchar(100),position varchar(100),hire_date date,base_salary decimal(10,2));
create table attendance(attendance_id int auto_increment primary key,employee_id int,attendance_date date,attendance_status enum('present','absent','leave'),foreign key(employee_id) references employees(employee_id)); 
create table salaries(salary_id int auto_increment primary key,employee_id int,base_salary decimal(10,2),bonus decimal(10,2),deductions decimal(10,2),salary_month varchar(20),saralry_year int,foreign key(employee_id) references employees(employee_id));
create table payroll(payroll_id int auto_increment primary key,employee_id int,total_salary decimal(10,2),payment_date date,foreign key (employee_id) references employees(employee_id));

insert into employees(employee_name,department,position,hire_date,base_salary) values ('Adithya','HR','HR Manager','2018-06-15',55000.00),('Greeshma', 'Finance', 'Accountant', '2019-03-10', 48000.00),('Sreerag', 'IT', 'Software Developer', '2021-07-22', 65000.00),('Priya ', 'Marketing', 'Marketing Executive', '2020-11-05', 45000.00),('Vijay', 'IT', 'System Administrator', '2017-09-18', 60000.00),('Midhun', 'Sales', 'Sales Executive', '2022-01-12', 40000.00);
insert into attendance(employee_id,attendance_date,attendance_status) values (1, '2026-02-01', 'Present'),(2, '2026-02-01', 'Present'),(3, '2026-02-01', 'Absent'),(4, '2026-02-01', 'Present'),(5, '2026-02-01', 'Leave'),(6, '2026-02-01', 'Present');
insert into salaries(employee_id,base_salary,bonus,deductions,salary_month,saralry_year) values (1, 55000.00, 5000.00, 2000.00, 'February', 2026),(2, 48000.00, 3000.00, 1500.00, 'February', 2026),(3, 65000.00, 7000.00, 2500.00, 'February', 2026),(4, 45000.00, 2000.00, 1000.00, 'February', 2026),(5, 60000.00, 6000.00, 2200.00, 'February', 2026),(6, 40000.00, 1500.00, 800.00, 'February', 2026);
insert into payroll(employee_id,total_salary,payment_date) values (1, 58000.00, '2026-02-28'),(2, 49500.00, '2026-02-28'),(3, 69500.00, '2026-02-28'),(4, 46000.00, '2026-02-28'),(5, 63800.00, '2026-02-28'),(6, 40700.00, '2026-02-28');

--  Add New Employees
insert into employees(employee_name,department,position,hire_date,base_salary) values ('Anjana','IT','Software Tester','2022-01-13',30000.00);

-- Update Employee Information
update employees set employee_name="Abhi" where employee_id=4;

--  Delete Employee Records
delete from employees where employee_id=7;

-- Track Employee Attendance
select e.employee_name, att.attendance_date, att.attendance_status from attendance att join employees e on att.employee_id = e.employee_id ;

-- Calculate Salary
select e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id;

 --  Manage Deductions and Bonuses:
update salaries set bonus=6000,deductions=3000 where employee_id=1;

--  Update Payroll Records
update payroll p join salaries s on p.employee_id=s.employee_id set p.total_salary=(s.base_salary+s.bonus-s.deductions),p.payment_date='2026-02-28' where s.salary_month='february' and s.saralry_year=2026;

--  Generate Pay Slips
select e.employee_id,e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id where e.employee_id=1;
select e.employee_id,e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id where e.employee_id=2;
select e.employee_id,e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id where e.employee_id=3;
select e.employee_id,e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id where e.employee_id=4;
select e.employee_id,e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id where e.employee_id=5;
select e.employee_id,e.employee_name,s.base_salary,s.bonus,s.deductions,(s.base_salary+s.bonus -s.deductions) as total_salary from salaries s join employees e on s.employee_id=e.employee_id where e.employee_id=6;

--  Generate Payroll Reports
select e.employee_id,e.employee_name,e.department,e.position,e.hire_date,e.base_salary,a.attendance_id,a.attendance_date,a.attendance_status,s.salary_id,s.bonus,s.deductions,s.salary_month,s.saralry_year,p.total_salary,p.payment_date from employees e join attendance a on e.employee_id=a.employee_id join salaries s on e.employee_id=s.employee_id join payroll p on e.employee_id=p.employee_id;
