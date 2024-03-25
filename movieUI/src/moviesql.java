import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import com.microsoft.sqlserver.jdbc.SQLServerException;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;


public class moviesql {
    public static void main(String[] args) {
        SQLServerDataSource ds = new SQLServerDataSource();
        ds.setUser("sa");
        ds.setPassword("123");
        ds.setServerName("DESKTOP-8KSDRJ8");
        ds.setPortNumber(1433); //port tcp/ip
        ds.setDatabaseName("MovieDB");
        ds.setTrustServerCertificate(true);
        Scanner console = new Scanner(System.in);
        System.out.println("Enter 1 to display Genre or 2 to display Media Type:");
        int queryChoice = console.nextInt();

        String sqlQuery;
        String column1;
        String column2;
        if (queryChoice == 1) {
            sqlQuery = "SELECT * FROM GENRE";
            column1 = "Genre";
            column2 = "GenreDescription";
        } else if (queryChoice == 2) {
            sqlQuery = "SELECT * FROM MEDIA_TYPE_NAME";
            column1 = "MediaType";
            column2 = "TypeDescription";
        } else {
            System.out.println("Invalid choice. Exiting program.");
            return;
        }


        try(Connection conn = ds.getConnection()){
            System.out.println("Connection success");
            System.out.println(conn.getMetaData());
            Statement stmt = conn.createStatement();

            // Execute the query
            ResultSet rs = stmt.executeQuery(sqlQuery);

            // Process the results
            while (rs.next()) {
                // Retrieve data from the result set
                String genre = rs.getString(column1);
                String description = rs.getString(column2);
                // Display the data
                System.out.println("Genre: " + genre + ", Description: " + description);
            }

            // Close the ResultSet, Statement, and Connection
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLServerException throwables) {
            throwables.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
