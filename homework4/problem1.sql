execute procedure drop_if_exists('trigger', 'tr_department_rating_insert');
execute procedure drop_if_exists('trigger', 'tr_department_rating_delete');
execute procedure drop_if_exists('trigger', 'tr_department_rating_update');
commit work;

execute procedure drop_if_exists('table', 'department_rating');
execute procedure drop_if_exists('procedure', 'f_rating');
commit work;

-- Create a SQL script called problem1.sql that creates a table called department_rating with two 
-- columns. The first column is named rating and is of type varchar(5), and the second column is called 
-- occurrences and is of type int. 
create table department_rating
(
	rating varchar (5) not null primary key,
	occurrences int
);


-- Due to how Firebird implements transactions, once you create the salary_class (department_rating?)  
-- table, you will have to commit the transaction before you execute the insert statements. 
commit work;


-- Next, insert values for ULTRA, HIGH, MID, and LOW, all with the 
-- occurrences column set to 0.
insert into department_rating values ('ULTRA', 0);
insert into department_rating values ('HIGH', 0);
insert into department_rating values ('MID', 0);
insert into department_rating values ('LOW', 0);


-- Next, define a helper function that you will use in the next problem. 
-- The function is called f_rating. It takes has one parameter called budget. The function should return the string 
-- 'LOW' for a budget less than or equal to 500000, 
-- 'MID' for a budget less than or equal to 850000, 
-- 'HIGH' for a budget less than or equal to 1200000, and 
-- 'ULTRA' for a budget above 1200000. 
-- NOTE: In an email Dr. Brown meantioned that Firebird does not support functions so create a procedure instead
set term # ;
create procedure f_rating (budget int)
returns (result varchar(5)) as
begin
	if (budget < 500001) then result = 'LOW';
	else
		if (budget < 850001) then result = 'MID';
		else
			if (budget < 1200001) then result = 'HIGH';
			else
				if (budget > 1200000) then result = 'ULTRA';
	suspend;
end #

commit work #
set term ; #


-- Show that you created the department_rating table correctly by including a query in your script that 
-- shows all the rows in the table. 
select * from department_rating;

-- Also demonstrate your function by including a query that calls the 
-- function for each of the following salaries: 200000, 850000, 980000, and 1200001.
--SELECT result FROM f_rating(200000), f_rating(850000), f_rating(980000), f_rating(1200001);
select result from f_rating(200000);
select result from f_rating(850000);
select result from f_rating(980000);
select result from f_rating(1200001);