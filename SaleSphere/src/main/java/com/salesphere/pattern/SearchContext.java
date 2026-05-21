package com.salesphere.pattern;

import com.salesphere.model.Property;
import com.salesphere.pattern.search.LocationSearchStrategy;
import com.salesphere.pattern.search.PriceRangeSearchStrategy;
import com.salesphere.pattern.search.TitleSearchStrategy;
import com.salesphere.pattern.search.TypeSearchStrategy;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * Context class for property search operations using Strategy Pattern
 * This class allows the system to use multiple search strategies and combine results
 */
public class SearchContext {
    
    private List<SearchStrategy> searchStrategies;
    
    /**
     * Default constructor - initializes with all available search strategies
     */
    public SearchContext() {
        this.searchStrategies = new ArrayList<>();
        initializeDefaultStrategies();
    }
    
    /**
     * Constructor with specific strategies
     * @param searchStrategies List of search strategies to use
     */
    public SearchContext(List<SearchStrategy> searchStrategies) {
        this.searchStrategies = new ArrayList<>(searchStrategies);
    }
    
    /**
     * Initialize default search strategies
     */
    private void initializeDefaultStrategies() {
        searchStrategies.add(new TitleSearchStrategy());
        searchStrategies.add(new PriceRangeSearchStrategy());
        searchStrategies.add(new LocationSearchStrategy());
        searchStrategies.add(new TypeSearchStrategy());
    }
    
    /**
     * Add a search strategy
     * @param searchStrategy The strategy to add
     */
    public void addSearchStrategy(SearchStrategy searchStrategy) {
        if (searchStrategy != null && !searchStrategies.contains(searchStrategy)) {
            searchStrategies.add(searchStrategy);
        }
    }
    
    /**
     * Remove a search strategy
     * @param searchStrategy The strategy to remove
     */
    public void removeSearchStrategy(SearchStrategy searchStrategy) {
        searchStrategies.remove(searchStrategy);
    }
    
    /**
     * Get all search strategies
     * @return List of search strategies
     */
    public List<SearchStrategy> getSearchStrategies() {
        return new ArrayList<>(searchStrategies);
    }
    
    /**
     * Search properties using all applicable strategies
     * @param searchCriteria The search criteria
     * @param allProperties List of all available properties
     * @return List of properties matching the search criteria
     */
    public List<Property> searchProperties(SearchCriteria searchCriteria, List<Property> allProperties) {
        if (searchCriteria == null || allProperties == null || allProperties.isEmpty()) {
            System.out.println("Invalid search criteria or no properties available");
            return new ArrayList<>();
        }
        
        System.out.println("Starting property search with " + searchStrategies.size() + " strategies");
        System.out.println("Search criteria: " + searchCriteria.toString());
        
        List<Property> combinedResults = new ArrayList<>();
        
        // Use each applicable strategy
        for (SearchStrategy strategy : searchStrategies) {
            if (strategy.supportsCriteria(searchCriteria)) {
                System.out.println("Using strategy: " + strategy.getStrategyName());
                List<Property> strategyResults = strategy.searchProperties(searchCriteria, allProperties);
                
                // Add results that aren't already in the combined results
                for (Property property : strategyResults) {
                    if (!containsProperty(combinedResults, property)) {
                        combinedResults.add(property);
                    }
                }
            }
        }
        
        // Sort results based on criteria
        sortResults(combinedResults, searchCriteria);
        
        System.out.println("Search completed. Found " + combinedResults.size() + " properties");
        return combinedResults;
    }
    
    /**
     * Search properties using a specific strategy
     * @param searchCriteria The search criteria
     * @param allProperties List of all available properties
     * @param strategyName The name of the strategy to use
     * @return List of properties matching the search criteria
     */
    public List<Property> searchWithStrategy(SearchCriteria searchCriteria, List<Property> allProperties, String strategyName) {
        for (SearchStrategy strategy : searchStrategies) {
            if (strategy.getStrategyName().equals(strategyName)) {
                System.out.println("Using specific strategy: " + strategy.getStrategyName());
                return strategy.searchProperties(searchCriteria, allProperties);
            }
        }
        
        System.out.println("Strategy not found: " + strategyName);
        return new ArrayList<>();
    }
    
    /**
     * Get available search strategies
     * @return List of strategy names
     */
    public List<String> getAvailableStrategies() {
        List<String> strategyNames = new ArrayList<>();
        for (SearchStrategy strategy : searchStrategies) {
            strategyNames.add(strategy.getStrategyName());
        }
        return strategyNames;
    }
    
    /**
     * Check if a property is already in the results list
     * @param results The results list
     * @param property The property to check
     * @return true if property is already in the list, false otherwise
     */
    private boolean containsProperty(List<Property> results, Property property) {
        for (Property existingProperty : results) {
            if (existingProperty.getPropertyId() == property.getPropertyId()) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Sort search results based on criteria
     * @param results The results to sort
     * @param searchCriteria The search criteria containing sort information
     */
    private void sortResults(List<Property> results, SearchCriteria searchCriteria) {
        if (searchCriteria.getSortBy() == null || searchCriteria.getSortBy().trim().isEmpty()) {
            return; // No sorting specified
        }
        
        String sortBy = searchCriteria.getSortBy().toLowerCase();
        boolean ascending = !"desc".equalsIgnoreCase(searchCriteria.getSortOrder());
        
        switch (sortBy) {
            case "price":
                results.sort(ascending ? 
                    Comparator.comparing(Property::getRent) : 
                    Comparator.comparing(Property::getRent).reversed());
                break;
                
            case "location":
                results.sort(ascending ? 
                    Comparator.comparing(Property::getAddress, Comparator.nullsFirst(Comparator.naturalOrder())) : 
                    Comparator.comparing(Property::getAddress, Comparator.nullsFirst(Comparator.naturalOrder())).reversed());
                break;
                
            case "type":
                results.sort(ascending ? 
                    Comparator.comparing(Property::getType, Comparator.nullsFirst(Comparator.naturalOrder())) : 
                    Comparator.comparing(Property::getType, Comparator.nullsFirst(Comparator.naturalOrder())).reversed());
                break;
                
            case "title":
                results.sort(ascending ? 
                    Comparator.comparing(Property::getTitle, Comparator.nullsFirst(Comparator.naturalOrder())) : 
                    Comparator.comparing(Property::getTitle, Comparator.nullsFirst(Comparator.naturalOrder())).reversed());
                break;
                
            default:
                // Default sort by property ID
                results.sort(ascending ? 
                    Comparator.comparing(Property::getPropertyId) : 
                    Comparator.comparing(Property::getPropertyId).reversed());
                break;
        }
        
        System.out.println("Results sorted by " + sortBy + " (" + (ascending ? "ascending" : "descending") + ")");
    }
}
