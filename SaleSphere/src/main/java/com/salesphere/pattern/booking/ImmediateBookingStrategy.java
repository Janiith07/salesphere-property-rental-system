package com.salesphere.pattern.booking;

import com.salesphere.model.Booking;
import com.salesphere.model.Property;
import com.salesphere.model.User;
import com.salesphere.pattern.BookingStrategy;
import com.salesphere.service.BookingService;

/**
 * Concrete strategy for immediate bookings
 * This strategy handles bookings that need to be processed immediately
 */
public class ImmediateBookingStrategy implements BookingStrategy {
    
    private BookingService bookingService;
    
    public ImmediateBookingStrategy() {
        this.bookingService = new BookingService();
    }
    
    @Override
    public boolean processBooking(Booking booking, Property property, User user) {
        System.out.println("Processing immediate booking for property: " + property.getTitle());
        
        // Validate the booking first
        if (!validateBooking(booking, property, user)) {
            System.out.println("Immediate booking validation failed");
            return false;
        }
        
        // Set booking status to pending for immediate processing
        booking.setStatus("Pending");
        
        // Process the booking immediately
        boolean success = bookingService.createBooking(booking);
        
        if (success) {
            System.out.println("Immediate booking processed successfully");
            // In a real system, you might trigger notifications here
        } else {
            System.out.println("Failed to process immediate booking");
        }
        
        return success;
    }
    
    @Override
    public boolean validateBooking(Booking booking, Property property, User user) {
        // Check if property is available
        if (!"Available".equals(property.getStatus())) {
            System.out.println("Property is not available for immediate booking");
            return false;
        }
        
        // Check if property is approved
        if (!"Approved".equals(property.getApprovalStatus())) {
            System.out.println("Property is not approved for booking");
            return false;
        }
        
        // Check if user is valid
        if (user == null || user.getUserId() <= 0) {
            System.out.println("Invalid user for booking");
            return false;
        }
        
        // Check if booking has required fields
        if (booking.getTenantId() <= 0 || booking.getPropertyId() <= 0) {
            System.out.println("Invalid booking data - missing tenant or property ID");
            return false;
        }
        
        // Check if booking date is valid (not in the past)
        if (booking.getBookingDate() == null || booking.getBookingDate().trim().isEmpty()) {
            System.out.println("Booking date is required");
            return false;
        }
        
        return true;
    }
    
    @Override
    public double calculateCost(Booking booking, Property property) {
        // For immediate bookings, use the standard property rent
        return property.getRent();
    }
    
    @Override
    public String getStrategyName() {
        return "Immediate Booking";
    }
    
    @Override
    public int getProcessingTimeHours() {
        return 1; // Immediate bookings are processed within 1 hour
    }
}
