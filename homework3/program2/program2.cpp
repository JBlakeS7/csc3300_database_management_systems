#include <stdlib.h>
#include <iostream>
#include <mysql.h>
#include <stdio.h>
#include <iomanip> //This creates the nice little table
#define SERVER "localhost"
#define USER "root"
#define PASSWORD "coursework"
#define DATABASE "TTU"

using namespace std;

int main()
{
	MYSQL *connect;
	connect = mysql_init(NULL);
	if(!connect)
	{
		cout<<"MySQL Initializtion failed";
		return 1;
	}

	//Try to connect to the database
	connect=mysql_real_connect(connect, SERVER, USER, PASSWORD, DATABASE, 0, NULL, 0);
	if(connect)
	{
		//cout<<"connection successful";
	}
	else
	{
		cout<<"connection failed";
		exit(1);
	}

	MYSQL_RES *res_set; //Result set
	MYSQL_ROW row;
	
	//Doing the inserts and query everything in the table
	mysql_query(connect, "INSERT INTO students(TNumber, FirstName, LastName, DateOfBirth) VALUES('00012233', 'John', 'Smith', '1970-01-26')");
	mysql_query(connect, "INSERT INTO students(TNumber, FirstName, LastName, DateOfBirth) VALUES('00023052', 'Jane', 'Doe', '1986-04-24')");
	mysql_query(connect, "INSERT INTO students(TNumber, FirstName, LastName, DateOfBirth) VALUES('00120330', 'Ivan', 'Ivanoff', '1974-02-28')");
	mysql_query(connect, "INSERT INTO students(TNumber, FirstName, LastName, DateOfBirth) VALUES('00001203', 'Billy', 'Williams', '1992-09-19')");
	mysql_query(connect, "select * from students");

	unsigned int i=0;
	res_set=mysql_store_result(connect);
	unsigned int numrows = mysql_num_rows(res_set);

	// Go through the result set and print the rows in a nice little table
	while((row = mysql_fetch_row(res_set)) != NULL)
	{
		cout << left << setw(20) << setfill(' ') << row[i];
    	cout << left << setw(20) << setfill(' ') << row[i+1];
    	cout << left << setw(20) << setfill(' ') << row[i+2];
    	cout << left << setw(9)  << setfill(' ') << row[i+3];
    	cout << endl;
	}
	
	mysql_close(connect);
	return 0;
}