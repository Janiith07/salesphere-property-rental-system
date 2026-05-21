package com.salesphere.pattern.search;

import com.salesphere.model.Property;
import com.salesphere.pattern.SearchCriteria;
import com.salesphere.pattern.SearchStrategy;
import java.util.ArrayList;
import java.util.List;

/**
 * Concrete strategy for title-based property search
 * This strategy searches properties based on title and description criteria
 */
public class TitleSearchStrategy implements SearchStrategy {
    
    @Override
    public List<Property> searchProperties(SearchCriteria searchCriteria, List<Property> allProperties) {
        List<Property> results = new ArrayList<>();
        
        // Check if title or description criteria is provided
        if ((searchCriteria.getTitle() == null || searchCriteria.getTitle().trim().isEmpty()) &&
            (searchCriteria.getDescription() == null || searchCriteria.getDescription().trim().isEmpty())) {
            System.out.println("Title search strategy: No title or description criteria provided");
            return results;
        }
        
        String searchTitle = searchCriteria.getTitle() != null ? searchCriteria.getTitle().toLowerCase().trim() : "";
        String searchDescription = searchCriteria.getDescription() != null ? searchCriteria.getDescription().toLowerCase().trim() : "";
        
        System.out.println("Title search strategy: Searching for title - '" + searchTitle + 
                          "', description - '" + searchDescription + "'");
        
        for (Property property : allProperties) {
            if (property == null) continue;
            
            boolean titleMatch = false;
            boolean descriptionMatch = false;
            
            // Check title match
            if (!searchTitle.isEmpty() && property.getTitle() != null) {
                String propertyTitle = property.getTitle().toLowerCase();
                if (propertyTitle.contains(searchTitle) || searchTitle.contains(propertyTitle)) {
                    titleMatch = true;
                }
            }
            
            // Check description match
            if (!searchDescription.isEmpty() && property.getDescription() != null) {
                String propertyDescription = property.getDescription().toLowerCase();
                if (propertyDescription.contains(searchDescription) || searchDescription.contains(propertyDescription)) {
                    descriptionMatch = true;
                }
            }
            
            // If either title or description matches (or both are empty, meaning no specific search)
            if (titleMatch || descriptionMatch || (searchTitle.isEmpty() && searchDescription.isEmpty())) {
                // Additional filters
                if (matchesAdditionalCriteria(property, searchCriteria)) {
                    results.add(property);
                    System.out.println("Title/Description match found: " + property.getTitle());
                }
            }
        }
        
        System.out.println("Title search strategy: Found " + results.size() + " properties");
        return results;
    }
    
    @Override
    public String getStrategyName() {
        return "Title/Description Search";
    }
    
    @Override
    public String getStrategyDescription() {
        return "Searches properties based on title and description keywords";
    }
    
    @Override
    public boolean supportsCriteria(SearchCriteria searchCriteria) {
        return (searchCriteria.getTitle() != null && !searchCriteria.getTitle().trim().isEmpty()) ||
               (searchCriteria.getDescription() != null && !searchCriteria.getDescription().trim().isEmpty());
    }
    
    @Override
    public int getPriority() {
        return 1; // Highest priority for title search (most specific)
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
