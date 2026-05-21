package com.salesphere.pattern;

/**
 * Search criteria class to hold all possible search parameters
 * This allows different search strategies to use the same criteria object
 */
public class SearchCriteria {
    
    private String location;
    private Double minPrice;
    private Double maxPrice;
    private String propertyType;
    private String title;
    private String description;
    private String status;
    private String approvalStatus;
    private Integer minRooms;
    private Integer maxRooms;
    private Boolean hasParking;
    private Boolean hasGarden;
    private Boolean hasBalcony;
    private String sortBy; // "price", "location", "type", "date"
    private String sortOrder; // "asc", "desc"
    
    // Constructors
    public SearchCriteria() {
        // Default constructor
    }
    
    public SearchCriteria(String location, Double minPrice, Double maxPrice, String propertyType) {
        this.location = location;
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
        this.propertyType = propertyType;
    }
    
    // Getters and Setters
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public Double getMinPrice() {
        return minPrice;
    }
    
    public void setMinPrice(Double minPrice) {
        this.minPrice = minPrice;
    }
    
    public Double getMaxPrice() {
        return maxPrice;
    }
    
    public void setMaxPrice(Double maxPrice) {
        this.maxPrice = maxPrice;
    }
    
    public String getPropertyType() {
        return propertyType;
    }
    
    public void setPropertyType(String propertyType) {
        this.propertyType = propertyType;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getApprovalStatus() {
        return approvalStatus;
    }
    
    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }
    
    public Integer getMinRooms() {
        return minRooms;
    }
    
    public void setMinRooms(Integer minRooms) {
        this.minRooms = minRooms;
    }
    
    public Integer getMaxRooms() {
        return maxRooms;
    }
    
    public void setMaxRooms(Integer maxRooms) {
        this.maxRooms = maxRooms;
    }
    
    public Boolean getHasParking() {
        return hasParking;
    }
    
    public void setHasParking(Boolean hasParking) {
        this.hasParking = hasParking;
    }
    
    public Boolean getHasGarden() {
        return hasGarden;
    }
    
    public void setHasGarden(Boolean hasGarden) {
        this.hasGarden = hasGarden;
    }
    
    public Boolean getHasBalcony() {
        return hasBalcony;
    }
    
    public void setHasBalcony(Boolean hasBalcony) {
        this.hasBalcony = hasBalcony;
    }
    
    public String getSortBy() {
        return sortBy;
    }
    
    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }
    
    public String getSortOrder() {
        return sortOrder;
    }
    
    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }
    
    @Override
    public String toString() {
        return "SearchCriteria{" +
                "location='" + location + '\'' +
                ", minPrice=" + minPrice +
                ", maxPrice=" + maxPrice +
                ", propertyType='" + propertyType + '\'' +
                ", title='" + title + '\'' +
                ", status='" + status + '\'' +
                ", approvalStatus='" + approvalStatus + '\'' +
                '}';
    }
}
