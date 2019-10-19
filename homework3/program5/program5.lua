local status, err = pcall (function ()
	env = assert (require "luasql.mysql".mysql(), "can't load library")
	con = assert (env:connect ("TTU", "root", "coursework"), "can't connect to database")
	cur = assert (con:execute "SELECT FirstName, LastName, CASE WHEN IFNULL(Grade, '') IN('C', 'B', 'A') THEN 'Yes' ELSE 'No' END AS ans FROM students LEFT JOIN grades ON students.TNumber = grades.TNumber AND grades.CourseID = 'CSC1310'", "error executing query")
	end)
if not status then
	print ("error: " ..err)
	os.exit()
end

row = cur:fetch ({}, "a")
while row do
	print (string.format("%-20s %-20s %-20s", row.FirstName, row.LastName, row.ans))
	row = cur:fetch (row, "a") 
end

cur:close()
con:close()
env:close()