package com.salesphere.model;

public class Booking {
	private int bookingId;
	private int tenantId;
	private int propertyId;
	private String bookingDate;
	private String status;

	private String tenantName;
	private String propertyTitle;
	
	public int getBookingId() {
		return bookingId;
	}
	public int getTenantId() {
		return tenantId;
	}
	public int getPropertyId() {
		return propertyId;
	}
	public String getBookingDate() {
		return bookingDate;
	}
	public String getStatus() {
		return status;
	}
	public String getTenantName() {
		return tenantName;
	}
	public String getPropertyTitle() {
		return propertyTitle;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public void setTenantId(int tenantId) {
		this.tenantId = tenantId;
	}
	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}
	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
	}
	public void setPropertyTitle(String propertyTitle) {
		this.propertyTitle = propertyTitle;
	}
}