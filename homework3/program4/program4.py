import sys
import MySQLdb

try:
	con = MySQLdb.connect (host = "localhost", user = "root", passwd = "coursework", db = "TTU")
except MySQLdb.Error, e:
	print "Error %d: %s" % (e.args[0], e.args[1])
	sys.exit(1)

cursor = con.cursor()
# This is so the program can be run mutiple times
cursor.execute("drop table if exists grades") 

cursor.execute("create table grades (TNumber char(8), CourseID char(7), Semester char(1), YearTaught numeric(4), Grade char(1), foreign key (TNumber) references students (TNumber))engine=innodb")
cursor.execute("insert into grades values('00012233', 'CSC3300', 'F', 2013, 'A')")
cursor.execute("insert into grades values('00023052', 'MAT1910', 'F', 2011, 'C')")
cursor.execute("insert into grades values('00001203', 'CSC1310', 'S', 2013, 'A')")
cursor.execute("insert into grades values('00120330', 'MAT1910', 'S', 2012, 'D')")
cursor.execute("insert into grades values('00120330', 'CSC1310', 'S', 2012, 'F')")
cursor.execute("insert into grades values('00120330', 'MAT1910', 'F', 2012, 'A')")
cursor.execute("insert into grades values('00120330', 'CSC1310', 'F', 2012, 'D')")
cursor.execute("insert into grades values('00012233', 'CSC1310', 'F', 2011, 'C')")
cursor.execute("insert into grades values('00012233', 'CSC1310', 'S', 2012, 'C')")
cursor.execute("insert into grades values('00012233', 'CSC1310', 'F', 2013, 'B')")
cursor.execute("insert into grades values('00001203', 'CSC2310', 'S', 2012, 'D')")

cursor.execute("select * from grades")

while(1):
	row = cursor.fetchone()
	if row == None:
		break
	print "%s   %s   %s   %s   %s" % (row [0], row[1], row[2], row[3], row[4])

cursor.execute("commit")