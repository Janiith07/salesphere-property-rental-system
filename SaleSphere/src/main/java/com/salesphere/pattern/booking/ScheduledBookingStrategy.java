package com.salesphere.pattern.booking;

import com.salesphere.model.Booking;
import com.salesphere.model.Property;
import com.salesphere.model.User;
import com.salesphere.pattern.BookingStrategy;
import com.salesphere.service.BookingService;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Concrete strategy for scheduled bookings
 * This strategy handles bookings that are scheduled for future dates
 */
public class ScheduledBookingStrategy implements BookingStrategy {
    
    private BookingService bookingService;
    
    public ScheduledBookingStrategy() {
        this.bookingService = new BookingService();
    }
    
    @Override
    public boolean processBooking(Booking booking, Property property, User user) {
        System.out.println("Processing scheduled booking for property: " + property.getTitle());
        
        // Validate the booking first
        if (!validateBooking(booking, property, user)) {
            System.out.println("Scheduled booking validation failed");
            return false;
        }
        
        // Set booking status to pending for scheduled processing
        booking.setStatus("Pending");
        
        // Process the scheduled booking
        boolean success = bookingService.createBooking(booking);
        
        if (success) {
            System.out.println("Scheduled booking processed successfully");
            // In a real system, you might schedule reminders here
        } else {
            System.out.println("Failed to process scheduled booking");
        }
        
        return success;
    }
    
    @Override
    public boolean validateBooking(Booking booking, Property property, User user) {
        // Check if property is available
        if (!"Available".equals(property.getStatus())) {
            System.out.println("Property is not available for scheduled booking");
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
        
        // Check if booking date is valid and in the future
        if (booking.getBookingDate() == null || booking.getBookingDate().trim().isEmpty()) {
            System.out.println("Booking date is required");
            return false;
        }
        
        // Check if booking date is at least 24 hours in the future
        LocalDate bookingDate = LocalDate.parse(booking.getBookingDate());
        LocalDate today = LocalDate.now();
        long daysBetween = ChronoUnit.DAYS.between(today, bookingDate);
        
        if (daysBetween < 1) {
            System.out.println("Scheduled bookings must be at least 24 hours in advance");
            return false;
        }
        
        // Check if booking date is not more than 1 year in the future
        if (daysBetween > 365) {
            System.out.println("Scheduled bookings cannot be more than 1 year in advance");
            return false;
        }
        
        return true;
    }
    
    @Override
    public double calculateCost(Booking booking, Property property) {
        // For scheduled bookings, use the standard property rent
        // In a real system, you might apply discounts for advance bookings
        return property.getRent();
    }
    
    @Override
    public String getStrategyName() {
        return "Scheduled Booking";
    }
    
    @Override
    public int getProcessingTimeHours() {
        return 24; // Scheduled bookings are processed within 24 hours
    }
}
