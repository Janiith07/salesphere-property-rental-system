package com.salesphere.pattern.payment;

import com.salesphere.model.PaymentCard;
import com.salesphere.model.User;
import com.salesphere.pattern.PaymentStrategy;

/**
 * Concrete strategy for bank transfer payments
 * This strategy handles payments made through bank transfers
 */
public class BankTransferStrategy implements PaymentStrategy {
    
    @Override
    public boolean processPayment(User user, PaymentCard paymentCard, double amount) {
        System.out.println("Processing bank transfer payment of Rs. " + amount + " for user: " + user.getFullName());
        
        // Validate the payment method first
        if (!validatePaymentMethod(user, paymentCard)) {
            System.out.println("Bank transfer validation failed");
            return false;
        }
        
        // Simulate bank transfer processing
        try {
            System.out.println("Initiating bank transfer for amount: Rs. " + amount);
            
            // Simulate processing delay (bank transfers take longer)
            Thread.sleep(2000);
            
            // Simulate bank transfer success
            boolean transferSuccess = simulateBankTransfer(amount, user);
            
            if (transferSuccess) {
                System.out.println("Bank transfer initiated successfully");
                System.out.println("Transfer reference: BT" + System.currentTimeMillis());
                return true;
            } else {
                System.out.println("Bank transfer failed - insufficient funds or invalid account");
                return false;
            }
            
        } catch (InterruptedException e) {
            System.out.println("Bank transfer processing interrupted");
            return false;
        } catch (Exception e) {
            System.out.println("Bank transfer processing error: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean validatePaymentMethod(User user, PaymentCard paymentCard) {
        // Check if user is valid
        if (user == null || user.getUserId() <= 0) {
            System.out.println("Invalid user for bank transfer");
            return false;
        }
        
        // For bank transfers, we don't need a payment card
        // We would typically validate bank account details here
        // For this simulation, we'll just check if user has valid details
        
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            System.out.println("User name is required for bank transfer");
            return false;
        }
        
        return true;
    }
    
    @Override
    public double calculateFees(double amount) {
        // Bank transfers typically have a flat fee of Rs. 50
        return 50.0;
    }
    
    @Override
    public String getPaymentMethodName() {
        return "Bank Transfer";
    }
    
    @Override
    public int getProcessingTimeMinutes() {
        return 30; // Bank transfers take up to 30 minutes
    }
    
    @Override
    public boolean requiresVerification() {
        return true; // Bank transfers require account verification
    }
    
    @Override
    public String getStrategyName() {
        return "Bank Transfer Strategy";
    }
    
    /**
     * Simulate bank transfer processing
     * @param amount The amount to transfer
     * @param user The user making the transfer
     * @return true if transfer succeeds, false otherwise
     */
    private boolean simulateBankTransfer(double amount, User user) {
        // In a real system, this would integrate with banking APIs
        // For simulation, we'll randomly succeed 98% of the time
        return Math.random() > 0.02;
    }
}
