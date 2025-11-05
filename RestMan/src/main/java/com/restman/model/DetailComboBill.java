package com.restman.model;

import java.io.Serializable;

public class DetailComboBill implements Serializable {
    private String id;
    private int quantity;
    private float price;
    private Combo combo;
    private Bill bill;

    public DetailComboBill() {}
    public DetailComboBill(String id, int quantity, float price, Combo combo, Bill bill) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.combo = combo;
        this.bill = bill;
    }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }
    public Combo getCombo() { return combo; }
    public void setCombo(Combo combo) { this.combo = combo; }
    public Bill getBill() { return bill; }
    public void setBill(Bill bill) { this.bill = bill; }
}
