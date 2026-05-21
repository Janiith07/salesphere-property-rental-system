package com.salesphere.pattern;

import com.salesphere.model.PaymentCard;
import com.salesphere.model.User;

/**
 * Strategy interface for different payment methods in the rental system
 * This allows the system to handle various payment scenarios with different processing logic
 */
public interface PaymentStrategy {
    
    /**
     * Process a payment using the specific strategy
     * @param user The user making the payment
     * @param paymentCard The payment card to use (if applicable)
     * @param amount The amount to be paid
     * @return true if payment was successful, false otherwise
     */
    boolean processPayment(User user, PaymentCard paymentCard, double amount);
    
    /**
     * Validate if the payment method is available and valid
     * @param user The user making the payment
     * @param paymentCard The payment card to validate (if applicable)
     * @return true if valid, false otherwise
     */
    boolean validatePaymentMethod(User user, PaymentCard paymentCard);
    
    /**
     * Calculate any additional fees for this payment method
     * @param amount The base amount
     * @return Additional fees
     */
    double calculateFees(double amount);
    
    /**
     * Get the payment method name
     * @return String name of the payment method
     */
    String getPaymentMethodName();
    
    /**
     * Get the estimated processing time for this payment method
     * @return Processing time in minutes
     */
    int getProcessingTimeMinutes();
    
    /**
     * Check if this payment method requires additional verification
     * @return true if verification is required, false otherwise
     */
    boolean requiresVerification();
    
    /**
     * Get the strategy name
     * @return String name of the strategy
     */
    String getStrategyName();
}
