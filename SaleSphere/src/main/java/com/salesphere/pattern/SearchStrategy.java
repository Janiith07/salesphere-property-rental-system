package com.salesphere.pattern;

import com.salesphere.model.Property;
import java.util.List;

/**
 * Strategy interface for different property search methods in the rental system
 * This allows the system to provide various search functionalities with different algorithms
 */
public interface SearchStrategy {
    
    /**
     * Search for properties using the specific strategy
     * @param searchCriteria The search criteria object containing search parameters
     * @param allProperties List of all available properties to search through
     * @return List of properties matching the search criteria
     */
    List<Property> searchProperties(SearchCriteria searchCriteria, List<Property> allProperties);
    
    /**
     * Get the search strategy name
     * @return String name of the search strategy
     */
    String getStrategyName();
    
    /**
     * Get the search strategy description
     * @return String description of what this strategy does
     */
    String getStrategyDescription();
    
    /**
     * Check if this strategy supports the given search criteria
     * @param searchCriteria The search criteria to check
     * @return true if supported, false otherwise
     */
    boolean supportsCriteria(SearchCriteria searchCriteria);
    
    /**
     * Get the priority/weight of this strategy when combining multiple strategies
     * @return Priority value (higher = more important)
     */
    int getPriority();
}
