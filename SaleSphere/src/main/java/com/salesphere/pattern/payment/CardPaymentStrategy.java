package com.salesphere.pattern.payment;

import com.salesphere.model.PaymentCard;
import com.salesphere.model.User;
import com.salesphere.pattern.PaymentStrategy;
import com.salesphere.util.EncryptionUtil;

/**
 * Concrete strategy for credit/debit card payments
 * This strategy handles payments made using stored payment cards
 */
public class CardPaymentStrategy implements PaymentStrategy {
    
    @Override
    public boolean processPayment(User user, PaymentCard paymentCard, double amount) {
        System.out.println("Processing card payment of Rs. " + amount + " for user: " + user.getFullName());
        
        // Validate the payment method first
        if (!validatePaymentMethod(user, paymentCard)) {
            System.out.println("Card payment validation failed");
            return false;
        }
        
        // Simulate card payment processing
        try {
            // In a real system, this would integrate with a payment gateway
            System.out.println("Processing payment with card ending in: " + getLastFourDigits(paymentCard));
            
            // Simulate processing delay
            Thread.sleep(1000);
            
            // Simulate payment success (in real system, this would be based on gateway response)
            boolean paymentSuccess = simulatePaymentGateway(amount, paymentCard);
            
            if (paymentSuccess) {
                System.out.println("Card payment processed successfully");
                return true;
            } else {
                System.out.println("Card payment failed - insufficient funds or card declined");
                return false;
            }
            
        } catch (InterruptedException e) {
            System.out.println("Payment processing interrupted");
            return false;
        } catch (Exception e) {
            System.out.println("Card payment processing error: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean validatePaymentMethod(User user, PaymentCard paymentCard) {
        // Check if user is valid
        if (user == null || user.getUserId() <= 0) {
            System.out.println("Invalid user for card payment");
            return false;
        }
        
        // Check if payment card is valid
        if (paymentCard == null) {
            System.out.println("Payment card is required for card payment");
            return false;
        }
        
        // Check if card belongs to the user
        if (paymentCard.getUser_id() != user.getUserId()) {
            System.out.println("Payment card does not belong to the user");
            return false;
        }
        
        // Check if card number is valid (decrypt and validate)
        try {
            String cardNumber = paymentCard.getCard_number_plain();
            if (cardNumber == null || cardNumber.length() < 13 || cardNumber.length() > 19) {
                System.out.println("Invalid card number");
                return false;
            }
            
            // Check if CVV is valid
            String cvv = paymentCard.getCvv_plain();
            if (cvv == null || cvv.length() < 3 || cvv.length() > 4) {
                System.out.println("Invalid CVV");
                return false;
            }
            
        } catch (Exception e) {
            System.out.println("Error validating card details: " + e.getMessage());
            return false;
        }
        
        return true;
    }
    
    @Override
    public double calculateFees(double amount) {
        // Card payments typically have a 2.5% processing fee
        return amount * 0.025;
    }
    
    @Override
    public String getPaymentMethodName() {
        return "Credit/Debit Card";
    }
    
    @Override
    public int getProcessingTimeMinutes() {
        return 2; // Card payments are processed within 2 minutes
    }
    
    @Override
    public boolean requiresVerification() {
        return true; // Card payments require CVV verification
    }
    
    @Override
    public String getStrategyName() {
        return "Card Payment Strategy";
    }
    
    /**
     * Get the last four digits of the card number for display
     * @param paymentCard The payment card
     * @return Last four digits
     */
    private String getLastFourDigits(PaymentCard paymentCard) {
        try {
            String cardNumber = paymentCard.getCard_number_plain();
            if (cardNumber != null && cardNumber.length() >= 4) {
                return cardNumber.substring(cardNumber.length() - 4);
            }
        } catch (Exception e) {
            System.out.println("Error getting last four digits: " + e.getMessage());
        }
        return "****";
    }
    
    /**
     * Simulate payment gateway processing
     * @param amount The amount to process
     * @param paymentCard The payment card
     * @return true if payment succeeds, false otherwise
     */
    private boolean simulatePaymentGateway(double amount, PaymentCard paymentCard) {
        // In a real system, this would call an actual payment gateway
        // For simulation, we'll randomly succeed 95% of the time
        return Math.random() > 0.05;
    }
}
