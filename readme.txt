Installation and Usage Guide
This guide provides instructions on how to install and run the testsql Java program along with the associated SQL script.

Prerequisites
Java Development Kit (JDK) installed on your system
IntelliJ IDEA (or any Java IDE of your choice) installed on your system
Microsoft SQL Server installed and running on your system
Setup Instructions

Open the project in IntelliJ IDEA.

Open the SQL Server Management Studio and connect to your SQL Server instance.

Execute the provided SQL script (MovieDB.sql) to create the MovieDB database and populate it with sample data. Make sure the script is executed successfully without errors.

Running the Program
Open the testsql.java file in IntelliJ IDEA.

Ensure that your SQL Server connection details are correctly set in the testsql class. Modify the following lines in the main method with your SQL Server details:

ds.setUser("sa");
ds.setPassword("123");
ds.setServerName("DESKTOP-8KSDRJ8");
ds.setPortNumber(1433);
Run the testsql program. The program will prompt you to enter 1 to display Genre or 2 to display Media Type.

Enter your choice and press Enter. The program will execute the corresponding SQL query and display the results.