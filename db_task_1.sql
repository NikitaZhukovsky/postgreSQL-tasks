-- Task 1
create table employees ( 
    id serial primary key,
    Name VARCHAR(50),
    Position VARCHAR(50), 
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
); 

-- Task 2
insert into employees (Name, Position, Department, Salary)
  values ('Ilya', 'Manager', 'Sales', 5200), 
   	     ('Pavel', 'Administrator', 'Support', 1000), 
         ('Maria', 'Programmer', 'Development', 5300),
         ('Igor', 'Administrator', 'Sales', 900);
    
-- Task 3
update employees 
set Position = 'Manager'
where name='Igor';

-- Task 4
alter table employees
add column HireDate VARCHAR(50);

-- Task 5
update employees
set HireDate = now() 
where HireDate is null;

-- Task 6
create or replace function find_manager()
returns setof record
as $$
begin
  return QUERY 
  select name, position from employees where position = 'Manager';
end;
$$ language plpgsql;

select * from find_manager() as (emp_name VARCHAR(50), emp_position VARCHAR(50));

-- Task 7
create or replace function find_salary()
returns setof record
as $$
begin
  return QUERY 
  select Name, Salary from employees where Salary > 5000;
end;
$$ language plpgsql;

select * from find_salary() as (emp_name VARCHAR(50), emp_salary DECIMAL(10, 2));

-- Task 8
create or replace function find_department()
returns setof record
as $$
begin
  return QUERY 
  select Name, Department from employees where Department = 'Sales';
end;
$$ language plpgsql;

select * from find_department() as (emp_name VARCHAR(50), emp_department VARCHAR(50));

-- Task 9
create or replace function average_salary()
returns DECIMAL(10, 2)
as $$
declare 
	avg_salary DECIMAL(10, 2);
begin 
	select avg(Salary) into avg_salary from employees;
    return avg_salary;
end;
$$ language plpgsql;

select average_salary();

-- Task 10
drop table if exists employees;