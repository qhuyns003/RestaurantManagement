package com.restman.model;

import java.io.Serializable;

public class DetailDishBill implements Serializable {
    private String id;
    private int quantity;
    private float price;
    private Bill bill;
    private Dish dish;

    public DetailDishBill() {}
    public DetailDishBill(String id, int quantity, float price, Bill bill, Dish dish) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.bill = bill;
        this.dish = dish;
    }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }
    public Bill getBill() { return bill; }
    public void setBill(Bill bill) { this.bill = bill; }
    public Dish getDish() { return dish; }
    public void setDish(Dish dish) { this.dish = dish; }
}
