package com.restman.dao;

import com.restman.model.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffDAO extends DAO {
    public Staff checkLogin(String username, String password) {
        String sql = "SELECT * FROM staff WHERE username = ? AND password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Staff staff = new Staff();
                    staff.setId(rs.getString("id"));
                    staff.setUsername(rs.getString("username"));
                    staff.setFullname(rs.getString("fullname"));
                    staff.setRole(rs.getString("role"));
                    return staff;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
