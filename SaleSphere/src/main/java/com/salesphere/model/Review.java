package com.salesphere.model;

public class Review {
	private int reviewId;
	private int propertyId;
	private int tenantId;
	private int rating;
	private String comment;
	private String reviewedAt;

	private String tenantName;
	private String propertyTitle;
	
	public int getReviewId() {
		return reviewId;
	}
	public int getPropertyId() {
		return propertyId;
	}
	public int getTenantId() {
		return tenantId;
	}
	public int getRating() {
		return rating;
	}
	public String getComment() {
		return comment;
	}
	public String getReviewedAt() {
		return reviewedAt;
	}
	public String getTenantName() {
		return tenantName;
	}
	public String getPropertyTitle() {
		return propertyTitle;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}
	public void setTenantId(int tenantId) {
		this.tenantId = tenantId;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public void setReviewedAt(String reviewedAt) {
		this.reviewedAt = reviewedAt;
	}
	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
	}
	public void setPropertyTitle(String propertyTitle) {
		this.propertyTitle = propertyTitle;
	}
}