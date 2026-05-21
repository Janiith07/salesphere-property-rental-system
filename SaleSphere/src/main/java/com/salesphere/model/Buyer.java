package com.salesphere.model;

public class Buyer extends User {
	private String nicNumber;
	private String address;
	private String createdAt;
	public String getNicNumber() {
		return nicNumber;
	}
	public String getAddress() {
		return address;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setNicNumber(String nicNumber) {
		this.nicNumber = nicNumber;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}