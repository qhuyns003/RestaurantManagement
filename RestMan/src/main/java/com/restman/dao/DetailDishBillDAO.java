package com.restman.dao;

import com.restman.model.DetailDishBill;
import java.util.List;

public class DetailDishBillDAO extends DAO {
    public List<DetailDishBill> getDetailDishBill(String billId) {
        List<DetailDishBill> result = new java.util.ArrayList<>();
        String sql = "SELECT ddb.id, ddb.billId, ddb.dishId, ddb.quantity, ddb.price, " +
                "d.name as dishName, d.description, d.price as dishPrice " +
                "FROM DetailDishBill ddb " +
                "JOIN Dish d ON ddb.dishId = d.id " +
                "WHERE ddb.billId = ?";
        try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, billId);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng Dish
                    com.restman.model.Dish dish = new com.restman.model.Dish();
                    dish.setId(rs.getString("dishId"));
                    dish.setName(rs.getString("dishName"));
                    dish.setDescription(rs.getString("description"));
                    dish.setPrice(rs.getFloat("dishPrice"));
                    
                    // Tạo đối tượng DetailDishBill
                    com.restman.model.DetailDishBill detailDishBill = new com.restman.model.DetailDishBill();
                    detailDishBill.setId(rs.getString("id"));
                    detailDishBill.setQuantity(rs.getInt("quantity"));
                    detailDishBill.setPrice(rs.getFloat("price"));
                    detailDishBill.setDish(dish);
                    // Bill object không cần thiết ở đây
                    result.add(detailDishBill);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
