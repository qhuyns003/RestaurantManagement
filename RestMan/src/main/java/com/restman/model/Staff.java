package com.restman.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Staff implements Serializable {
    private String id;
    private String username;
    private String password;
    private String fullname;
    private LocalDateTime dob;
    private String phone;
    private String address;
    private String role;

    public Staff() {}
    public Staff(String id, String username, String password, String fullname, LocalDateTime dob, String phone, String address, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.role = role;
    }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public LocalDateTime getDob() { return dob; }
    public void setDob(LocalDateTime dob) { this.dob = dob; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
