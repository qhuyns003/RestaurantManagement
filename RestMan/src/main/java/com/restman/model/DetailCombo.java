package com.restman.model;

import java.io.Serializable;

public class DetailCombo implements Serializable {
    private String id;
    private int quantity;
    private Dish dish;
    private Combo combo;

    public DetailCombo() {}
    public DetailCombo(String id, int quantity, Dish dish, Combo combo) {
        this.id = id;
        this.quantity = quantity;
        this.dish = dish;
        this.combo = combo;
    }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public Dish getDish() { return dish; }
    public void setDish(Dish dish) { this.dish = dish; }
    public Combo getCombo() { return combo; }
    public void setCombo(Combo combo) { this.combo = combo; }
}
