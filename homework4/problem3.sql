-- Reset Code that is neccessary for multiple runs and testing
-- IMPORTANT: to run this script multiple times, run problem2.sql first
execute procedure drop_if_exists('trigger', 'tr_department_rating_delete');


-- Create an SQL script called problem3.sql that defines a trigger tr_department_rating_delete that, 
-- when a department is deleted from the department_tester table, updates the corresponding 
-- occurrences column in the department_rating table. 
-- For example, if a department that has a 200000 
-- dollar salary is deleted from the department_tester table, the trigger should decrement the 
-- occurrences column for the class 'LOW' salaries in the department_rating table by 1. 
set term # ;
create trigger tr_department_rating_delete for department_tester after delete
as
begin
	update department_rating
		set occurrences = occurrences - 1
		where rating = (select result from f_rating(OLD.budget));
end#

commit work#
set term ; #


-- To show that your trigger works, delete the employees with department numbers 115 and 672, and 
-- execute a query that shows all the rows in the department_rating table. 
delete from department_tester where dept_no = 115;
delete from department_tester where dept_no = 672;
select * from department_rating;