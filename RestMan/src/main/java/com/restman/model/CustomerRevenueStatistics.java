package com.restman.model;

import java.io.Serializable;

public class CustomerRevenueStatistics extends Customer implements Serializable {
    private float totalRevenue;

    public CustomerRevenueStatistics() {}
    public CustomerRevenueStatistics(String id, String fullname, java.time.LocalDateTime dob, String email, String phone, String address, float totalRevenue) {
        super(id, fullname, dob, email, phone, address);
        this.totalRevenue = totalRevenue;
    }
    public float getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(float totalRevenue) { this.totalRevenue = totalRevenue; }
}
