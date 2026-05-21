package com.salesphere.pattern.search;

import com.salesphere.model.Property;
import com.salesphere.pattern.SearchCriteria;
import com.salesphere.pattern.SearchStrategy;
import java.util.ArrayList;
import java.util.List;

/**
 * Concrete strategy for price range-based property search
 * This strategy searches properties based on price criteria
 */
public class PriceRangeSearchStrategy implements SearchStrategy {
    
    @Override
    public List<Property> searchProperties(SearchCriteria searchCriteria, List<Property> allProperties) {
        List<Property> results = new ArrayList<>();
        
        // Check if price criteria is provided
        if (searchCriteria.getMinPrice() == null && searchCriteria.getMaxPrice() == null) {
            System.out.println("Price range search strategy: No price criteria provided");
            return results;
        }
        
        Double minPrice = searchCriteria.getMinPrice();
        Double maxPrice = searchCriteria.getMaxPrice();
        
        System.out.println("Price range search strategy: Searching for price range - Min: " + 
                          (minPrice != null ? "Rs. " + minPrice : "No limit") + 
                          ", Max: " + (maxPrice != null ? "Rs. " + maxPrice : "No limit"));
        
        for (Property property : allProperties) {
            if (property == null) continue;
            
            double propertyRent = property.getRent();
            
            // Check if property rent is within the specified range
            boolean withinRange = true;
            
            if (minPrice != null && propertyRent < minPrice) {
                withinRange = false;
            }
            
            if (maxPrice != null && propertyRent > maxPrice) {
                withinRange = false;
            }
            
            if (withinRange) {
                // Additional filters
                if (matchesAdditionalCriteria(property, searchCriteria)) {
                    results.add(property);
                    System.out.println("Price match found: " + property.getTitle() + " - Rs. " + propertyRent);
                }
            }
        }
        
        System.out.println("Price range search strategy: Found " + results.size() + " properties");
        return results;
    }
    
    @Override
    public String getStrategyName() {
        return "Price Range Search";
    }
    
    @Override
    public String getStrategyDescription() {
        return "Searches properties based on price range criteria";
    }
    
    @Override
    public boolean supportsCriteria(SearchCriteria searchCriteria) {
        return searchCriteria.getMinPrice() != null || searchCriteria.getMaxPrice() != null;
    }
    
    @Override
    public int getPriority() {
        return 2; // High priority for price search (very important for users)
    }
    
    /**
     * Check if property matches additional criteria
     * @param property The property to check
     * @param searchCriteria The search criteria
     * @return true if matches, false otherwise
     */
    private boolean matchesAdditionalCriteria(Property property, SearchCriteria searchCriteria) {
        // Check property type
        if (searchCriteria.getPropertyType() != null && 
            !searchCriteria.getPropertyType().trim().isEmpty()) {
            if (!property.getType().equalsIgnoreCase(searchCriteria.getPropertyType())) {
                return false;
            }
        }
        
        // Check location
        if (searchCriteria.getLocation() != null && 
            !searchCriteria.getLocation().trim().isEmpty()) {
            if (property.getAddress() == null || 
                !property.getAddress().toLowerCase().contains(searchCriteria.getLocation().toLowerCase())) {
                return false;
            }
        }
        
        // Check status
        if (searchCriteria.getStatus() != null && 
            !searchCriteria.getStatus().trim().isEmpty()) {
            if (!property.getStatus().equalsIgnoreCase(searchCriteria.getStatus())) {
                return false;
            }
        }
        
        // Check approval status
        if (searchCriteria.getApprovalStatus() != null && 
            !searchCriteria.getApprovalStatus().trim().isEmpty()) {
            if (!property.getApprovalStatus().equalsIgnoreCase(searchCriteria.getApprovalStatus())) {
                return false;
            }
        }
        
        return true;
    }
}
