package com.restman.dao;

import com.restman.model.CustomerRevenueStatistics;
import java.time.LocalDateTime;
import java.util.List;

public class CustomerRevenueStatisticsDAO extends DAO {
    public List<CustomerRevenueStatistics> getRevenueCustomer(LocalDateTime start, LocalDateTime end) {
        List<CustomerRevenueStatistics> result = new java.util.ArrayList<>();
        
        // Tính tổng doanh thu từ DetailDishBill và DetailComboBill trừ tổng discount
        String sql = "SELECT c.id, c.username, c.password, c.fullname, c.dob, c.email, c.phone, c.address, " +
            "(COALESCE(SUM(ddb.quantity * ddb.price), 0) + COALESCE(SUM(dcb.quantity * dcb.price), 0) - COALESCE(SUM(b.discount), 0)) as totalRevenue " +
            "FROM customer c " +
            "JOIN bill b ON b.customerId = c.id " +
            "LEFT JOIN DetailDishBill ddb ON ddb.billId = b.id " +
            "LEFT JOIN DetailComboBill dcb ON dcb.billId = b.id " +
            "WHERE b.datetime >= ? AND b.datetime <= ? " +
            "GROUP BY c.id, c.username, c.password, c.fullname, c.dob, c.email, c.phone, c.address " +
            "ORDER BY totalRevenue DESC";
            
        try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, java.sql.Timestamp.valueOf(start));
            ps.setObject(2, java.sql.Timestamp.valueOf(end));
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerRevenueStatistics stat = new CustomerRevenueStatistics(
                        rs.getString("id"),
                        rs.getString("fullname"),
                        rs.getTimestamp("dob") != null ? rs.getTimestamp("dob").toLocalDateTime() : null,
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getFloat("totalRevenue")
                    );
                    result.add(stat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
