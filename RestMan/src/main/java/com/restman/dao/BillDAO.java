package com.restman.dao;

import com.restman.model.Bill;
import com.restman.model.Customer;

import java.util.List;

public class BillDAO extends DAO {
    public List<Bill> getHistoryBill(String customerId) {
        List<Bill> result = new java.util.ArrayList<>();
        String sql = "SELECT b.id, b.datetime, b.code, b.discount, b.waitStaffId as waitStaff, " +
                "t.id as tableId, t.number as tableName, t.maxPeople as tableCapacity " +
                "FROM Bill b LEFT JOIN TableRestaurant t ON b.tableId = t.id " +
                "WHERE b.customerId = ? ORDER BY b.datetime DESC";
        try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customerId);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String billId = rs.getString("id");
                    
                    com.restman.model.Table table = new com.restman.model.Table(
                        rs.getString("tableId"),
                        rs.getInt("tableName"),
                        rs.getInt("tableCapacity")
                    );
                    
                    // Tính total từ DetailDishBill và DetailComboBill
                    float calculatedTotal = 0;

                    // Tính tổng từ món ăn (DetailDishBill)
                    String dishSql = "SELECT SUM(quantity * price) as dishTotal FROM DetailDishBill WHERE billId = ?";
                    try (java.sql.PreparedStatement ps2 = con.prepareStatement(dishSql)) {
                        ps2.setString(1, billId);
                        try (java.sql.ResultSet rs2 = ps2.executeQuery()) {
                            if (rs2.next()) {
                                calculatedTotal += rs2.getFloat("dishTotal");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    // Tính tổng từ combo (DetailComboBill)
                    String comboSql = "SELECT SUM(quantity * price) as comboTotal FROM DetailComboBill WHERE billId = ?";
                    try (java.sql.PreparedStatement ps2 = con.prepareStatement(comboSql)) {
                        ps2.setString(1, billId);
                        try (java.sql.ResultSet rs2 = ps2.executeQuery()) {
                            if (rs2.next()) {
                                calculatedTotal += rs2.getFloat("comboTotal");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    
                    com.restman.model.Bill bill = new com.restman.model.Bill(
                        billId,
                        rs.getTimestamp("datetime") != null ? rs.getTimestamp("datetime").toLocalDateTime() : null,
                        calculatedTotal- rs.getFloat("discount"), // Dùng total tính được thay vì lấy từ DB
                        rs.getString("code"),
                        rs.getFloat("discount"),
                        rs.getString("waitStaff"),
                        null, // customer object không cần thiết ở đây
                        table
                    );
                    result.add(bill);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
//    /**
//     * Tính tổng tiền hóa đơn từ DetailDishBill và DetailComboBill
//     */
//    private float calculateBillTotal(String billId) {
//        float total = 0;
//
//        // Tính tổng từ món ăn (DetailDishBill)
//        String dishSql = "SELECT SUM(quantity * price) as dishTotal FROM DetailDishBill WHERE billId = ?";
//        try (java.sql.PreparedStatement ps = con.prepareStatement(dishSql)) {
//            ps.setString(1, billId);
//            try (java.sql.ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    total += rs.getFloat("dishTotal");
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        // Tính tổng từ combo (DetailComboBill)
//        String comboSql = "SELECT SUM(quantity * price) as comboTotal FROM DetailComboBill WHERE billId = ?";
//        try (java.sql.PreparedStatement ps = con.prepareStatement(comboSql)) {
//            ps.setString(1, billId);
//            try (java.sql.ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    total += rs.getFloat("comboTotal");
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return total;
//    }


    public Bill getDetailBill(String billId) {
        Bill bill = null;
        String sql = "SELECT b.id, b.datetime, b.code, b.discount, b.waitStaffId as waitStaff, " +
                    "t.id as tableId, t.number as tableName, t.maxPeople as tableCapacity, " +
                    "c.id as customerId, c.fullname as customerName, c.phone as phoneNumber, c.address " +
                    "FROM Bill b " +
                    "LEFT JOIN TableRestaurant t ON b.tableId = t.id " +
                    "LEFT JOIN Customer c ON b.customerId = c.id " +
                    "WHERE b.id = ?";
        try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, billId);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Tạo đối tượng Table
                    com.restman.model.Table table = new com.restman.model.Table(
                        rs.getString("tableId"),
                        rs.getInt("tableName"),
                        rs.getInt("tableCapacity")
                    );
                    
                    // Tạo đối tượng Customer
                    Customer customer = new Customer();
                    customer.setId(rs.getString("customerId"));
                    customer.setFullname(rs.getString("customerName"));
                    customer.setPhone(rs.getString("phoneNumber"));
                    customer.setAddress(rs.getString("address"));
                    
                    // Tạo đối tượng Bill
                    bill = new com.restman.model.Bill(
                        rs.getString("id"),
                        rs.getTimestamp("datetime") != null ? rs.getTimestamp("datetime").toLocalDateTime() : null,

                        rs.getString("code"),
                        rs.getFloat("discount"),
                        rs.getString("waitStaff"),
                        customer,
                        table
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bill;
    }
}
