package com.salesphere.model;

import com.salesphere.util.EncryptionUtil;

public class PaymentCard {
    private int card_id;
    private int user_id;
    private String card_holder_name;
    private String card_number;
    private String expiry_date; // format: MM/YY
    private String cvv;
    private String card_type; // e.g., Visa, MasterCard

    public int getCard_id() {
        return card_id;
    }

    public void setCard_id(int card_id) {
        this.card_id = card_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getCard_holder_name() {
        return card_holder_name;
    }

    public void setCard_holder_name(String card_holder_name) {
        this.card_holder_name = card_holder_name;
    }

    public String getCard_number() {
        return card_number;
    }

    public void setCard_number(String card_number) {
        this.card_number = card_number;
    }

    public String getExpiry_date() {
        return expiry_date;
    }

    public void setExpiry_date(String expiry_date) {
        this.expiry_date = expiry_date;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getCard_type() {
        return card_type;
    }

    public void setCard_type(String card_type) {
        this.card_type = card_type;
    }
    
    // Encryption/Decryption methods for card number
    public void setCard_number_encrypted(String encryptedCardNumber) {
        this.card_number = encryptedCardNumber;
    }
    
    public String getCard_number_encrypted() {
        return this.card_number;
    }
    
    public void setCard_number_plain(String plainCardNumber) {
        this.card_number = EncryptionUtil.encrypt(plainCardNumber);
    }
    
    public String getCard_number_plain() {
        if (this.card_number == null) {
            return null;
        }
        try {
            // Check if the data is encrypted by trying to decrypt it
            if (EncryptionUtil.isEncrypted(this.card_number)) {
                return EncryptionUtil.decrypt(this.card_number);
            } else {
                // Data is not encrypted (backward compatibility)
                return this.card_number;
            }
        } catch (Exception e) {
            // If decryption fails, assume it's already plain text (for backward compatibility)
            return this.card_number;
        }
    }
    
    // Encryption/Decryption methods for CVV
    public void setCvv_encrypted(String encryptedCvv) {
        this.cvv = encryptedCvv;
    }
    
    public String getCvv_encrypted() {
        return this.cvv;
    }
    
    public void setCvv_plain(String plainCvv) {
        this.cvv = EncryptionUtil.encrypt(plainCvv);
    }
    
    public String getCvv_plain() {
        if (this.cvv == null) {
            return null;
        }
        try {
            // Check if the data is encrypted by trying to decrypt it
            if (EncryptionUtil.isEncrypted(this.cvv)) {
                return EncryptionUtil.decrypt(this.cvv);
            } else {
                // Data is not encrypted (backward compatibility)
                return this.cvv;
            }
        } catch (Exception e) {
            // If decryption fails, assume it's already plain text (for backward compatibility)
            return this.cvv;
        }
    }
    
    // Utility methods for display
    public String getMaskedCardNumber() {
        if (this.card_number == null) {
            return null;
        }
        try {
            String plainNumber = getCard_number_plain();
            return EncryptionUtil.maskCardNumber(plainNumber);
        } catch (Exception e) {
            // If anything fails, return a safe masked version
            return "**** **** **** ****";
        }
    }
    
    public String getMaskedCvv() {
        if (this.cvv == null) {
            return null;
        }
        return EncryptionUtil.maskCVV(this.cvv);
    }
}
