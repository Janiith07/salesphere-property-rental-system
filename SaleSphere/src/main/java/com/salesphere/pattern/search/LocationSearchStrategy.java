package com.salesphere.pattern.search;

import com.salesphere.model.Property;
import com.salesphere.pattern.SearchCriteria;
import com.salesphere.pattern.SearchStrategy;
import java.util.ArrayList;
import java.util.List;

/**
 * Concrete strategy for location-based property search
 * This strategy searches properties based on location criteria
 */
public class LocationSearchStrategy implements SearchStrategy {
    
    @Override
    public List<Property> searchProperties(SearchCriteria searchCriteria, List<Property> allProperties) {
        List<Property> results = new ArrayList<>();
        
        // Check if location criteria is provided
        if (searchCriteria.getLocation() == null || searchCriteria.getLocation().trim().isEmpty()) {
            System.out.println("Location search strategy: No location criteria provided");
            return results;
        }
        
        String searchLocation = searchCriteria.getLocation().toLowerCase().trim();
        System.out.println("Location search strategy: Searching for location - " + searchLocation);
        
        for (Property property : allProperties) {
            if (property == null) continue;
            
            // Check if property address contains the search location
            if (property.getAddress() != null) {
                String propertyAddress = property.getAddress().toLowerCase();
                
                // Check for exact match or partial match
                if (propertyAddress.contains(searchLocation) || 
                    searchLocation.contains(propertyAddress) ||
                    isLocationMatch(propertyAddress, searchLocation)) {
                    
                    // Additional filters
                    if (matchesAdditionalCriteria(property, searchCriteria)) {
                        results.add(property);
                        System.out.println("Location match found: " + property.getTitle() + " at " + property.getAddress());
                    }
                }
            }
        }
        
        System.out.println("Location search strategy: Found " + results.size() + " properties");
        return results;
    }
    
    @Override
    public String getStrategyName() {
        return "Location Search";
    }
    
    @Override
    public String getStrategyDescription() {
        return "Searches properties based on location/address criteria";
    }
    
    @Override
    public boolean supportsCriteria(SearchCriteria searchCriteria) {
        return searchCriteria.getLocation() != null && !searchCriteria.getLocation().trim().isEmpty();
    }
    
    @Override
    public int getPriority() {
        return 3; // Medium priority for location search
    }
    
    /**
     * Check if two locations match (handles variations in location names)
     * @param propertyAddress The property address
     * @param searchLocation The search location
     * @return true if locations match, false otherwise
     */
    private boolean isLocationMatch(String propertyAddress, String searchLocation) {
        // Handle common location variations
        String[] searchWords = searchLocation.split("\\s+");
        String[] addressWords = propertyAddress.split("\\s+");
        
        // Check if any search word matches any address word
        for (String searchWord : searchWords) {
            for (String addressWord : addressWords) {
                if (searchWord.equals(addressWord) || 
                    addressWord.contains(searchWord) || 
                    searchWord.contains(addressWord)) {
                    return true;
                }
            }
        }
        
        return false;
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
