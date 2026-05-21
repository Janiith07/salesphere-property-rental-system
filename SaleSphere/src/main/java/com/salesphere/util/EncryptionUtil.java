package com.salesphere.util;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class for encrypting and decrypting sensitive data like payment card numbers
 * Uses AES encryption with a fixed key for consistency
 */
public class EncryptionUtil {
    
    private static final String ALGORITHM = "AES";
    private static final String TRANSFORMATION = "AES/ECB/PKCS5Padding";
    
    // In production, this key should be stored securely (environment variable, config file, etc.)
    // For now, using a fixed key for demonstration purposes
    private static final String SECRET_KEY = "MySecretKey12345"; // 16 characters for AES-128
    
    /**
     * Encrypts the given plain text using AES encryption
     * @param plainText The text to encrypt
     * @return Base64 encoded encrypted string
     */
    public static String encrypt(String plainText) {
        try {
            if (plainText == null || plainText.isEmpty()) {
                return plainText;
            }
            
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), ALGORITHM);
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            
            byte[] encryptedBytes = cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(encryptedBytes);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Encryption failed", e);
        }
    }
    
    /**
     * Decrypts the given encrypted text using AES decryption
     * @param encryptedText Base64 encoded encrypted string
     * @return Decrypted plain text
     */
    public static String decrypt(String encryptedText) {
        try {
            if (encryptedText == null || encryptedText.isEmpty()) {
                return encryptedText;
            }
            
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), ALGORITHM);
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            
            byte[] decodedBytes = Base64.getDecoder().decode(encryptedText);
            byte[] decryptedBytes = cipher.doFinal(decodedBytes);
            return new String(decryptedBytes, StandardCharsets.UTF_8);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Decryption failed", e);
        }
    }
    
    /**
     * Masks a card number showing only the last 4 digits
     * @param cardNumber The full card number
     * @return Masked card number (e.g., **** **** **** 1234)
     */
    public static String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) {
            return cardNumber;
        }
        
        String lastFour = cardNumber.substring(cardNumber.length() - 4);
        int maskLength = cardNumber.length() - 4;
        StringBuilder masked = new StringBuilder();
        
        for (int i = 0; i < maskLength; i++) {
            if (i > 0 && i % 4 == 0) {
                masked.append(" ");
            }
            masked.append("*");
        }
        
        return masked.toString() + " " + lastFour;
    }
    
    /**
     * Masks a CVV showing only asterisks
     * @param cvv The CVV to mask
     * @return Masked CVV (e.g., ***)
     */
    public static String maskCVV(String cvv) {
        if (cvv == null || cvv.isEmpty()) {
            return cvv;
        }
        StringBuilder masked = new StringBuilder();
        for (int i = 0; i < cvv.length(); i++) {
            masked.append("*");
        }
        return masked.toString();
    }
    
    /**
     * Validates if a string is a valid encrypted format (Base64)
     * @param text The text to validate
     * @return true if it appears to be encrypted, false otherwise
     */
    public static boolean isEncrypted(String text) {
        if (text == null || text.isEmpty()) {
            return false;
        }
        
        try {
            Base64.getDecoder().decode(text);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
