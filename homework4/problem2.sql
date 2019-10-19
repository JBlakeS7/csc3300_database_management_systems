-- Reset Code that is neccessary for multiple runs and testing
execute procedure drop_if_exists('trigger', 'tr_department_rating_insert');
update department_rating set occurrences = 0;
execute procedure drop_if_exists('table', 'department_tester');
commit work;
create table department_tester
(
    dept_no deptno not null primary key,
    department varchar (25) not null unique,
    head_dept deptno,
    mngr_no empno,
    budget budget default 50000,
    location varchar(15),
    phone_no phonenumber default '555-1234',
    foreign key (head_dept) references department (dept_no),
    foreign key (mngr_no) references employee (emp_no)
);
commit work;


-- Create a script called problem2.sql, and in the script define a trigger called 
-- tr_department_rating_insert that, when a new employee is inserted into the department_tester 
-- table, updates the corresponding occurrences column in the department_rating table. 
-- For example, if a new department that has a 200000 dollar salary is entered into the department_tester table, the 
-- trigger should increment the occurrences column for the class 'LOW' budgets in the 
-- department_rating table by 1. 
set term # ;
create trigger tr_department_rating_insert for department_tester after insert
as
begin
	update department_rating
		set occurrences = occurrences + 1
		where rating = (select result from f_rating(NEW.budget));
end#

commit work#
set term ; #


-- To show that your script works, include, in your script, SQL commands to copy all the data from the 
-- department table into the department_tester table.
insert into department_tester select * from department;


-- Finally, include, in your script, a query that 
-- shows the department_rating table after all the rows from the budget table are copied. 
select * from department_rating;