package com.restman.model;

import java.io.Serializable;

public class Table implements Serializable {
    private String id;
    private int number;
    private int maxPeople;

    public Table() {}
    public Table(String id, int number, int maxPeople) {
        this.id = id;
        this.number = number;
        this.maxPeople = maxPeople;
    }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public int getNumber() { return number; }
    public void setNumber(int number) { this.number = number; }
    public int getMaxPeople() { return maxPeople; }
    public void setMaxPeople(int maxPeople) { this.maxPeople = maxPeople; }
    
    public String getName() { return String.valueOf(number); }
    public void setName(String name) { 
        try { 
            this.number = Integer.parseInt(name); 
        } catch (NumberFormatException e) { 
            
        }
    }
    public int getCapacity() { return maxPeople; }
    public void setCapacity(int capacity) { this.maxPeople = capacity; }
}
