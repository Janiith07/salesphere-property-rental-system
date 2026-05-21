package com.salesphere.pattern;

import com.salesphere.model.PaymentCard;
import com.salesphere.model.User;
import com.salesphere.pattern.payment.BankTransferStrategy;
import com.salesphere.pattern.payment.CardPaymentStrategy;
import com.salesphere.pattern.payment.DigitalWalletStrategy;

/**
 * Context class for payment operations using Strategy Pattern
 * This class allows the system to switch between different payment strategies at runtime
 */
public class PaymentContext {
    
    private PaymentStrategy paymentStrategy;
    
    /**
     * Default constructor - uses card payment strategy by default
     */
    public PaymentContext() {
        this.paymentStrategy = new CardPaymentStrategy();
    }
    
    /**
     * Constructor with specific strategy
     * @param paymentStrategy The payment strategy to use
     */
    public PaymentContext(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }
    
    /**
     * Set the payment strategy
     * @param paymentStrategy The strategy to use for payment
     */
    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }
    
    /**
     * Get the current payment strategy
     * @return The current payment strategy
     */
    public PaymentStrategy getPaymentStrategy() {
        return paymentStrategy;
    }
    
    /**
     * Process payment using the current strategy
     * @param amount The amount to be paid
     * @param user The user making the payment
     * @param paymentCard The payment card to use (if applicable)
     * @param description Description of the payment
     * @return true if payment was successful, false otherwise
     */
    public boolean processPayment(User user, PaymentCard paymentCard, double amount) {
        if (paymentStrategy == null) {
            System.out.println("No payment strategy set");
            return false;
        }
        
        System.out.println("Using payment strategy: " + paymentStrategy.getPaymentMethodName());
        return paymentStrategy.processPayment(user, paymentCard, amount);
    }
    
    /**
     * Validate payment method using the current strategy
     * @param user The user making the payment
     * @param paymentCard The payment card to validate (if applicable)
     * @return true if valid, false otherwise
     */
    public boolean validatePaymentMethod(User user, PaymentCard paymentCard) {
        if (paymentStrategy == null) {
            System.out.println("No payment strategy set");
            return false;
        }
        
        return paymentStrategy.validatePaymentMethod(user, paymentCard);
    }
    
    /**
     * Calculate fees using the current strategy
     * @param amount The base amount
     * @return Additional fees
     */
    public double calculateFees(double amount) {
        if (paymentStrategy == null) {
            System.out.println("No payment strategy set");
            return 0.0;
        }
        
        return paymentStrategy.calculateFees(amount);
    }
    
    /**
     * Process card payment (convenience method)
     * @param amount The amount to be paid
     * @param user The user making the payment
     * @param paymentCard The payment card to use
     * @param description Description of the payment
     * @return true if payment was successful, false otherwise
     */
    public boolean processCardPayment(User user, PaymentCard paymentCard, double amount) {
        setPaymentStrategy(new CardPaymentStrategy());
        return processPayment(user, paymentCard, amount);
    }
    
    /**
     * Process bank transfer payment (convenience method)
     * @param amount The amount to be paid
     * @param user The user making the payment
     * @param description Description of the payment
     * @return true if payment was successful, false otherwise
     */
    public boolean processBankTransferPayment(User user, double amount) {
        setPaymentStrategy(new BankTransferStrategy());
        return processPayment(user, null, amount);
    }
    
    /**
     * Process digital wallet payment (convenience method)
     * @param amount The amount to be paid
     * @param user The user making the payment
     * @param walletType The type of digital wallet
     * @param description Description of the payment
     * @return true if payment was successful, false otherwise
     */
    public boolean processDigitalWalletPayment(User user, String walletType, double amount) {
        setPaymentStrategy(new DigitalWalletStrategy(walletType));
        return processPayment(user, null, amount);
    }
    
    /**
     * Get information about the current payment strategy
     * @return String containing payment strategy information
     */
    public String getPaymentInfo() {
        if (paymentStrategy == null) {
            return "No payment strategy set";
        }
        
        return String.format("Payment Method: %s, Processing Time: %d minutes, Requires Verification: %s", 
                           paymentStrategy.getPaymentMethodName(), 
                           paymentStrategy.getProcessingTimeMinutes(),
                           paymentStrategy.requiresVerification() ? "Yes" : "No");
    }
}
