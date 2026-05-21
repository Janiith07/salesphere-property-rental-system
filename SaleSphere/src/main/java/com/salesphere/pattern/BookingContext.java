package com.salesphere.pattern;

import com.salesphere.model.Booking;
import com.salesphere.model.Property;
import com.salesphere.model.User;
import com.salesphere.pattern.booking.GroupBookingStrategy;
import com.salesphere.pattern.booking.ImmediateBookingStrategy;
import com.salesphere.pattern.booking.ScheduledBookingStrategy;

/**
 * Context class for booking operations using Strategy Pattern
 * This class allows the system to switch between different booking strategies at runtime
 */
public class BookingContext {
    
    private BookingStrategy bookingStrategy;
    
    /**
     * Default constructor - uses immediate booking strategy by default
     */
    public BookingContext() {
        this.bookingStrategy = new ImmediateBookingStrategy();
    }
    
    /**
     * Constructor with specific strategy
     * @param bookingStrategy The booking strategy to use
     */
    public BookingContext(BookingStrategy bookingStrategy) {
        this.bookingStrategy = bookingStrategy;
    }
    
    /**
     * Set the booking strategy
     * @param bookingStrategy The strategy to use for booking
     */
    public void setBookingStrategy(BookingStrategy bookingStrategy) {
        this.bookingStrategy = bookingStrategy;
    }
    
    /**
     * Get the current booking strategy
     * @return The current booking strategy
     */
    public BookingStrategy getBookingStrategy() {
        return bookingStrategy;
    }
    
    /**
     * Process booking using the current strategy
     * @param booking The booking to process
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if booking was successful, false otherwise
     */
    public boolean processBooking(Booking booking, Property property, User user) {
        if (bookingStrategy == null) {
            System.out.println("No booking strategy set");
            return false;
        }
        
        System.out.println("Using booking strategy: " + bookingStrategy.getStrategyName());
        return bookingStrategy.processBooking(booking, property, user);
    }
    
    /**
     * Validate booking using the current strategy
     * @param booking The booking to validate
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if valid, false otherwise
     */
    public boolean validateBooking(Booking booking, Property property, User user) {
        if (bookingStrategy == null) {
            System.out.println("No booking strategy set");
            return false;
        }
        
        return bookingStrategy.validateBooking(booking, property, user);
    }
    
    /**
     * Calculate cost using the current strategy
     * @param booking The booking to calculate cost for
     * @param property The property being booked
     * @return The total cost
     */
    public double calculateCost(Booking booking, Property property) {
        if (bookingStrategy == null) {
            System.out.println("No booking strategy set");
            return 0.0;
        }
        
        return bookingStrategy.calculateCost(booking, property);
    }
    
    /**
     * Process immediate booking (convenience method)
     * @param booking The booking to process immediately
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if booking was successful, false otherwise
     */
    public boolean processImmediateBooking(Booking booking, Property property, User user) {
        setBookingStrategy(new ImmediateBookingStrategy());
        return processBooking(booking, property, user);
    }
    
    /**
     * Process scheduled booking (convenience method)
     * @param booking The booking to schedule
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if booking was successful, false otherwise
     */
    public boolean processScheduledBooking(Booking booking, Property property, User user) {
        setBookingStrategy(new ScheduledBookingStrategy());
        return processBooking(booking, property, user);
    }
    
    /**
     * Process group booking (convenience method)
     * @param booking The booking to process as group
     * @param property The property being booked
     * @param user The user making the booking
     * @return true if booking was successful, false otherwise
     */
    public boolean processGroupBooking(Booking booking, Property property, User user) {
        setBookingStrategy(new GroupBookingStrategy());
        return processBooking(booking, property, user);
    }
    
    /**
     * Get information about the current strategy
     * @return String containing strategy information
     */
    public String getStrategyInfo() {
        if (bookingStrategy == null) {
            return "No strategy set";
        }
        
        return String.format("Strategy: %s, Processing Time: %d hours", 
                           bookingStrategy.getStrategyName(), 
                           bookingStrategy.getProcessingTimeHours());
    }
}
