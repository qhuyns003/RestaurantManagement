package com.restman.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Bill implements Serializable {
    private String id;
    private LocalDateTime dateTime;
    private float total;
    private String code;
    private float discount;
    private String waitStaff;
    private Customer customer;
    private Table table;

    public Bill() {}
    public Bill(String id, LocalDateTime dateTime, float total, String code, float discount, String waitStaff, Customer customer, Table table) {
        this.id = id;
        this.dateTime = dateTime;
        this.total = total;
        this.code = code;
        this.discount = discount;
        this.waitStaff = waitStaff;
        this.customer = customer;
        this.table = table;
    }
    public Bill(String id, LocalDateTime dateTime, String code, float discount, String waitStaff, Customer customer, Table table) {
        this.id = id;
        this.dateTime = dateTime;
        this.code = code;
        this.discount = discount;
        this.waitStaff = waitStaff;
        this.customer = customer;
        this.table = table;
    }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public LocalDateTime getDateTime() { return dateTime; }
    public void setDateTime(LocalDateTime dateTime) { this.dateTime = dateTime; }
    
    public String getFormattedDateTime() {
        if (dateTime == null) return "";
        try {
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            return dateTime.format(formatter);
        } catch (Exception e) {
            return dateTime.toString();
        }
    }
    public float getTotal() { return total; }
    public void setTotal(float total) { this.total = total; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public float getDiscount() { return discount; }
    public void setDiscount(float discount) { this.discount = discount; }
    public String getWaitStaff() { return waitStaff; }
    public void setWaitStaff(String waitStaff) { this.waitStaff = waitStaff; }
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    public Table getTable() { return table; }
    public void setTable(Table table) { this.table = table; }
}
