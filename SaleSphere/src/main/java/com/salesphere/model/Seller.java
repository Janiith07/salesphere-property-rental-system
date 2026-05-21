package com.salesphere.model;

public class Seller extends User {
    private int sellerId;
    private String createdAt;

    public int getSellerId() {
        return sellerId;
    }
    public String getCreatedAt() {
        return createdAt;
    }
    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}