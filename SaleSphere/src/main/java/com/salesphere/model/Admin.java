package com.salesphere.model;

public class Admin extends User {
	private int adminId;
    private String role;
    private String createdAt;
    
	public int getAdminId() {
		return adminId;
	}
	public String getRole() {
		return role;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}