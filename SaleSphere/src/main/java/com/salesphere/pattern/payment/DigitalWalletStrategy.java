package com.salesphere.pattern.payment;

import com.salesphere.model.PaymentCard;
import com.salesphere.model.User;
import com.salesphere.pattern.PaymentStrategy;

/**
 * Concrete strategy for digital wallet payments
 * This strategy handles payments made through digital wallets like PayPal, Apple Pay, etc.
 */
public class DigitalWalletStrategy implements PaymentStrategy {
    
    private String walletType; // e.g., "PayPal", "Apple Pay", "Google Pay"
    
    public DigitalWalletStrategy() {
        this.walletType = "Digital Wallet";
    }
    
    public DigitalWalletStrategy(String walletType) {
        this.walletType = walletType;
    }
    
    @Override
    public boolean processPayment(User user, PaymentCard paymentCard, double amount) {
        System.out.println("Processing " + walletType + " payment of Rs. " + amount + " for user: " + user.getFullName());
        
        // Validate the payment method first
        if (!validatePaymentMethod(user, paymentCard)) {
            System.out.println(walletType + " payment validation failed");
            return false;
        }
        
        // Simulate digital wallet payment processing
        try {
            System.out.println("Connecting to " + walletType + " service...");
            System.out.println("Processing payment for amount: Rs. " + amount);
            
            // Simulate processing delay
            Thread.sleep(1500);
            
            // Simulate digital wallet payment success
            boolean paymentSuccess = simulateDigitalWalletPayment(amount, user);
            
            if (paymentSuccess) {
                System.out.println(walletType + " payment processed successfully");
                System.out.println("Transaction ID: DW" + System.currentTimeMillis());
                return true;
            } else {
                System.out.println(walletType + " payment failed - insufficient balance or service unavailable");
                return false;
            }
            
        } catch (InterruptedException e) {
            System.out.println(walletType + " payment processing interrupted");
            return false;
        } catch (Exception e) {
            System.out.println(walletType + " payment processing error: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean validatePaymentMethod(User user, PaymentCard paymentCard) {
        // Check if user is valid
        if (user == null || user.getUserId() <= 0) {
            System.out.println("Invalid user for " + walletType + " payment");
            return false;
        }
        
        // Check if user has email (required for most digital wallets)
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            System.out.println("Email is required for " + walletType + " payment");
            return false;
        }
        
        // Validate email format
        if (!isValidEmail(user.getEmail())) {
            System.out.println("Invalid email format for " + walletType + " payment");
            return false;
        }
        
        return true;
    }
    
    @Override
    public double calculateFees(double amount) {
        // Digital wallets typically have a 1.5% processing fee
        return amount * 0.015;
    }
    
    @Override
    public String getPaymentMethodName() {
        return walletType;
    }
    
    @Override
    public int getProcessingTimeMinutes() {
        return 1; // Digital wallet payments are very fast
    }
    
    @Override
    public boolean requiresVerification() {
        return false; // Digital wallets handle their own verification
    }
    
    @Override
    public String getStrategyName() {
        return "Digital Wallet Strategy";
    }
    
    /**
     * Simulate digital wallet payment processing
     * @param amount The amount to process
     * @param user The user making the payment
     * @return true if payment succeeds, false otherwise
     */
    private boolean simulateDigitalWalletPayment(double amount, User user) {
        // In a real system, this would integrate with digital wallet APIs
        // For simulation, we'll randomly succeed 97% of the time
        return Math.random() > 0.03;
    }
    
    /**
     * Basic email validation
     * @param email The email to validate
     * @return true if valid, false otherwise
     */
    private boolean isValidEmail(String email) {
        return email != null && email.contains("@") && email.contains(".");
    }
}
