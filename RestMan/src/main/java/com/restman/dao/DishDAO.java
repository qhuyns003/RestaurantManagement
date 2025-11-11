package com.restman.dao;

import com.restman.model.Dish;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class DishDAO extends DAO {



    public DishDAO() {
        super();
    }

    public List<Dish> searchByName(String key) {
        if (key == null || key.trim().isEmpty()) {
            return Collections.emptyList();
        }
        List<Dish> result = new ArrayList<>();
        String sql = "SELECT id, name, description, price FROM dish WHERE LOWER(name) LIKE ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + key.trim().toLowerCase() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Dish d = new Dish();
                    d.setId(rs.getString("id"));
                    d.setName(rs.getString("name"));
                    d.setDescription(rs.getString("description"));
                    d.setPrice(rs.getFloat("price"));
                    result.add(d);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public Dish getDetailDishInfo(String dishId) {
        if (dishId == null) return null;
        String sql = "SELECT id, name, description, price FROM dish WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dishId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Dish d = new Dish();
                    d.setId(rs.getString("id"));
                    d.setName(rs.getString("name"));
                    d.setDescription(rs.getString("description"));
                    d.setPrice(rs.getFloat("price"));
                    return d;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
