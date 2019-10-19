import java.sql.*;
import java.sql.Date;

public class program1
{
    public static void main(String args[])
    {
        try
        {
            Statement s;
            ResultSet rs;
            Class.forName("com.mysql.jdbc.Driver");

            //Connect to the local host. Database TTU doesn't exist yet
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306", "root", "coursework");
            s = c.createStatement();
            
            //Drop the database if it exists and then create it
            s.execute("DROP DATABASE IF EXISTS TTU");
            s.execute("CREATE DATABASE TTU");
            
            //Disconnect and reconnect to the database with Tntech in the url
            c.close();
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/TTU", "root", "coursework");
            s = c.createStatement();

            //Create a students table and insert one row and then query everything in the table
            s.execute("CREATE TABLE students(TNumber char(8) PRIMARY KEY, FirstName VARCHAR(20) NOT NULL, LastName VARCHAR(20) NOT NULL, DateOfBirth DATE, INDEX(LastName))ENGINE=INNODB");
            s.execute("INSERT INTO students(TNumber, FirstName, LastName, DateOfBirth) VALUES(12345678, 'John', 'Jones', '1976-07-17')");
            rs = s.executeQuery("SELECT * FROM students");

            //Print out a nice little table of everything in the students table
            while(rs.next())
            {
                String tnum = rs.getString("students.TNumber");
                String fname = rs.getString("students.FirstName");
                String lname = rs.getString("students.LastName");
                Date bdate = rs.getDate("students.DateOfBirth");

                System.out.format("%8s%25s%25s%20tD%n", tnum, fname, lname, bdate);
            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
}