package com.salesphere.model;

public class Property {
	private int propertyId;
	private int landlordId;
	private String title;
	private String address;
	private String type;
	private double rent;
	private String status;
	private String approvalStatus;
	private String description;
	private String createdAt;

	private String landlordName;
	private String landlordEmail;
	
	// Image management fields
	private String mainImage;
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	private String image5;
	
	public int getPropertyId() {
		return propertyId;
	}
	public int getLandlordId() {
		return landlordId;
	}
	public String getTitle() {
		return title;
	}
	public String getAddress() {
		return address;
	}
	public String getType() {
		return type;
	}
	public double getRent() {
		return rent;
	}
	public String getStatus() {
		return status;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public String getDescription() {
		return description;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public String getLandlordName() {
		return landlordName;
	}
	public String getLandlordEmail() {
		return landlordEmail;
	}
	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}
	public void setLandlordId(int landlordId) {
		this.landlordId = landlordId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setRent(double rent) {
		this.rent = rent;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public void setLandlordName(String landlordName) {
		this.landlordName = landlordName;
	}
	public void setLandlordEmail(String landlordEmail) {
		this.landlordEmail = landlordEmail;
	}
	
	// Image management getters
	public String getMainImage() {
		return mainImage;
	}
	public String getImage1() {
		return image1;
	}
	public String getImage2() {
		return image2;
	}
	public String getImage3() {
		return image3;
	}
	public String getImage4() {
		return image4;
	}
	public String getImage5() {
		return image5;
	}
	
	// Image management setters
	public void setMainImage(String mainImage) {
		this.mainImage = mainImage;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	public void setImage4(String image4) {
		this.image4 = image4;
	}
	public void setImage5(String image5) {
		this.image5 = image5;
	}
}