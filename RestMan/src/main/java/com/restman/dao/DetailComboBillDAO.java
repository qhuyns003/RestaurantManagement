package com.restman.dao;

import com.restman.model.DetailComboBill;
import java.util.List;

public class DetailComboBillDAO extends DAO {
    public List<DetailComboBill> getDetailComboBill(String billId) {
        List<DetailComboBill> result = new java.util.ArrayList<>();
        String sql = "SELECT dcb.id, dcb.billId, dcb.comboId, dcb.quantity, dcb.price, " +
                "c.name as comboName, c.description, c.price as comboPrice " +
                "FROM DetailComboBill dcb " +
                "JOIN Combo c ON dcb.comboId = c.id " +
                "WHERE dcb.billId = ?";
        try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, billId);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng Combo
                    com.restman.model.Combo combo = new com.restman.model.Combo();
                    combo.setId(rs.getString("comboId"));
                    combo.setName(rs.getString("comboName"));
                    combo.setDescription(rs.getString("description"));
                    combo.setPrice(rs.getFloat("comboPrice"));
                    
                    // Tạo đối tượng DetailComboBill
                    com.restman.model.DetailComboBill detailComboBill = new com.restman.model.DetailComboBill();
                    detailComboBill.setId(rs.getString("id"));
                    detailComboBill.setQuantity(rs.getInt("quantity"));
                    detailComboBill.setPrice(rs.getFloat("price"));
                    detailComboBill.setCombo(combo);
                    // Bill object không cần thiết ở đây
                    result.add(detailComboBill);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
