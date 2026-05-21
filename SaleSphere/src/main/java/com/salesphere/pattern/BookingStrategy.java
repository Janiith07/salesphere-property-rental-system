package com.salesphere.pattern;

import com.salesphere.model.Booking;
import com.salesphere.model.Property;
import com.salesphere.model.User;

/**
 * Strategy interface for different booking types in the rental system
 * This allows the system to handle various booking scenarios with different business logic
 */
public interface BookingStrategy {
    
    /**
     * Process a booking request using the specific strategy
     * @param booking The booking to process
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if booking was successful, false otherwise
     */
    boolean processBooking(Booking booking, Property property, User user);
    
    /**
     * Validate if the booking is valid for this strategy
     * @param booking The booking to validate
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if valid, false otherwise
     */
    boolean validateBooking(Booking booking, Property property, User user);
    
    /**
     * Calculate the total cost for this booking strategy
     * @param booking The booking to calculate cost for
     * @param property The property being booked
     * @return The total cost
     */
    double calculateCost(Booking booking, Property property);
    
    /**
     * Get the strategy name
     * @return String name of the strategy
     */
    String getStrategyName();
    
    /**
     * Get the estimated processing time for this strategy
     * @return Processing time in hours
     */
    int getProcessingTimeHours();
}
