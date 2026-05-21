package com.salesphere.pattern.booking;

import com.salesphere.model.Booking;
import com.salesphere.model.Property;
import com.salesphere.model.User;
import com.salesphere.pattern.BookingStrategy;
import com.salesphere.service.BookingService;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Concrete strategy for group bookings
 * This strategy handles bookings for multiple people or long-term rentals
 */
public class GroupBookingStrategy implements BookingStrategy {
    
    private BookingService bookingService;
    private int minimumGroupSize;
    private int minimumDurationDays;
    
    public GroupBookingStrategy() {
        this.bookingService = new BookingService();
        this.minimumGroupSize = 2; // Minimum 2 people for group booking
        this.minimumDurationDays = 7; // Minimum 7 days for group booking
    }
    
    @Override
    public boolean processBooking(Booking booking, Property property, User user) {
        System.out.println("Processing group booking for property: " + property.getTitle());
        
        // Validate the booking first
        if (!validateBooking(booking, property, user)) {
            System.out.println("Group booking validation failed");
            return false;
        }
        
        // Set booking status to pending for group processing
        booking.setStatus("Pending");
        
        // Process the group booking
        boolean success = bookingService.createBooking(booking);
        
        if (success) {
            System.out.println("Group booking processed successfully");
            // In a real system, you might trigger special group notifications here
        } else {
            System.out.println("Failed to process group booking");
        }
        
        return success;
    }
    
    @Override
    public boolean validateBooking(Booking booking, Property property, User user) {
        // Check if property is available
        if (!"Available".equals(property.getStatus())) {
            System.out.println("Property is not available for group booking");
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
        
        // Check if booking date is at least 7 days in the future for group bookings
        LocalDate bookingDate = LocalDate.parse(booking.getBookingDate());
        LocalDate today = LocalDate.now();
        long daysBetween = ChronoUnit.DAYS.between(today, bookingDate);
        
        if (daysBetween < minimumDurationDays) {
            System.out.println("Group bookings must be at least " + minimumDurationDays + " days in advance");
            return false;
        }
        
        // Check if property type is suitable for group bookings
        if (!isPropertySuitableForGroup(property)) {
            System.out.println("Property type is not suitable for group bookings");
            return false;
        }
        
        return true;
    }
    
    @Override
    public double calculateCost(Booking booking, Property property) {
        // For group bookings, apply a discount
        double baseCost = property.getRent();
        double groupDiscount = 0.15; // 15% discount for group bookings
        return baseCost * (1 - groupDiscount);
    }
    
    @Override
    public String getStrategyName() {
        return "Group Booking";
    }
    
    @Override
    public int getProcessingTimeHours() {
        return 48; // Group bookings are processed within 48 hours
    }
    
    /**
     * Check if the property is suitable for group bookings
     * @param property The property to check
     * @return true if suitable, false otherwise
     */
    private boolean isPropertySuitableForGroup(Property property) {
        // Group bookings are suitable for houses and large apartments
        String propertyType = property.getType();
        return "House".equals(propertyType) || "Apartment".equals(propertyType);
    }
}
