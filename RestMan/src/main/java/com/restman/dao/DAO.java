package com.restman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    protected Connection con;

    public DAO() {
        try {
            
            String url = "jdbc:mysql://localhost:3306/restman";
            String user = "root";
            String password = "root";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
