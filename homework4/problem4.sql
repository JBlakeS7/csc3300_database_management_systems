-- Reset Code that is neccessary for multiple runs and testing
execute procedure drop_if_exists('trigger', 'tr_department_rating_update');
update department_tester set budget = 700000 where dept_no = 120;


-- Create an SQL script called problem4.sql that updates the department_rating table if a budget is 
-- changed (an update statement is executed on the department_tester table). The update trigger 
-- should be fairly easy because it does what both the delete and insert triggers do, and has OLD and 
-- NEW row variables that have the column values for the row's values before the update and after the 
-- update, respectively. 
set term # ;
create trigger tr_department_rating_update for department_tester after update
as
begin
	update department_rating
		set occurrences = occurrences - 1
		where rating = (select result from f_rating(OLD.budget));

	update department_rating
		set occurrences = occurrences + 1
		where rating = (select result from f_rating(NEW.budget));
end#

commit work#
set term ; #

-- Lastly, include, in your script, an SQL command that adds 160000 dollars to the budget for the 
-- department with the department number of 120.
update department_tester set budget = budget + 160000 where dept_no = 120;

--Finally, include an SQL query that shows the department_rating table.
select * from department_rating;