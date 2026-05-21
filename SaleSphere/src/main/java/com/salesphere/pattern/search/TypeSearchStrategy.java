package com.salesphere.pattern.search;

import com.salesphere.model.Property;
import com.salesphere.pattern.SearchCriteria;
import com.salesphere.pattern.SearchStrategy;
import java.util.ArrayList;
import java.util.List;

/**
 * Concrete strategy for property type-based search
 * This strategy searches properties based on property type criteria
 */
public class TypeSearchStrategy implements SearchStrategy {
    
    @Override
    public List<Property> searchProperties(SearchCriteria searchCriteria, List<Property> allProperties) {
        List<Property> results = new ArrayList<>();
        
        // Check if property type criteria is provided
        if (searchCriteria.getPropertyType() == null || searchCriteria.getPropertyType().trim().isEmpty()) {
            System.out.println("Type search strategy: No property type criteria provided");
            return results;
        }
        
        String searchType = searchCriteria.getPropertyType().toLowerCase().trim();
        System.out.println("Type search strategy: Searching for property type - " + searchType);
        
        for (Property property : allProperties) {
            if (property == null) continue;
            
            // Check if property type matches
            if (property.getType() != null) {
                String propertyType = property.getType().toLowerCase();
                
                if (propertyType.equals(searchType) || 
                    propertyType.contains(searchType) || 
                    searchType.contains(propertyType)) {
                    
                    // Additional filters
                    if (matchesAdditionalCriteria(property, searchCriteria)) {
                        results.add(property);
                        System.out.println("Type match found: " + property.getTitle() + " - " + property.getType());
                    }
                }
            }
        }
        
        System.out.println("Type search strategy: Found " + results.size() + " properties");
        return results;
    }
    
    @Override
    public String getStrategyName() {
        return "Property Type Search";
    }
    
    @Override
    public String getStrategyDescription() {
        return "Searches properties based on property type criteria (Apartment, House, Room)";
    }
    
    @Override
    public boolean supportsCriteria(SearchCriteria searchCriteria) {
        return searchCriteria.getPropertyType() != null && !searchCriteria.getPropertyType().trim().isEmpty();
    }
    
    @Override
    public int getPriority() {
        return 4; // Lower priority for type search
    }
    
    /**
     * Check if property matches additional criteria
     * @param property The property to check
     * @param searchCriteria The search criteria
     * @return true if matches, false otherwise
     */
    private boolean matchesAdditionalCriteria(Property property, SearchCriteria searchCriteria) {
        // Check price range
        if (searchCriteria.getMinPrice() != null) {
            if (property.getRent() < searchCriteria.getMinPrice()) {
                return false;
            }
        }
        
        if (searchCriteria.getMaxPrice() != null) {
            if (property.getRent() > searchCriteria.getMaxPrice()) {
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
