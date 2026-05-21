package com.salesphere.service;

import com.salesphere.model.PaymentCard;
import com.salesphere.util.DBConnection;
import com.salesphere.util.EncryptionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentCardService {

    // Add a new card with encryption
    public boolean addCard(PaymentCard card) {
        String query = "INSERT INTO PaymentCards (user_id, card_holder_name, card_number, expiry_date, cvv, card_type) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, card.getUser_id());
            stmt.setString(2, card.getCard_holder_name());
            
            // Always encrypt card number and CVV before storing
            String cardNumber = card.getCard_number();
            String cvv = card.getCvv();
            
            String encryptedCardNumber = EncryptionUtil.encrypt(cardNumber);
            String encryptedCvv = EncryptionUtil.encrypt(cvv);
            
            stmt.setString(3, encryptedCardNumber);
            stmt.setString(4, card.getExpiry_date());
            stmt.setString(5, encryptedCvv);
            stmt.setString(6, card.getCard_type());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get cards by user ID with decryption
    public List<PaymentCard> getCardsByUserId(int userId) {
        List<PaymentCard> cards = new ArrayList<>();
        String query = "SELECT * FROM PaymentCards WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                PaymentCard card = new PaymentCard();
                card.setCard_id(rs.getInt("card_id"));
                card.setUser_id(rs.getInt("user_id"));
                card.setCard_holder_name(rs.getString("card_holder_name"));
                
                // Store encrypted data directly (will be decrypted when needed)
                card.setCard_number_encrypted(rs.getString("card_number"));
                card.setCvv_encrypted(rs.getString("cvv"));
                
                card.setExpiry_date(rs.getString("expiry_date"));
                card.setCard_type(rs.getString("card_type"));
                cards.add(card);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cards;
    }

    // Get single card by ID with decryption
    public PaymentCard getCard(int cardId) {
        String query = "SELECT * FROM PaymentCards WHERE card_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, cardId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                PaymentCard card = new PaymentCard();
                card.setCard_id(rs.getInt("card_id"));
                card.setUser_id(rs.getInt("user_id"));
                card.setCard_holder_name(rs.getString("card_holder_name"));
                
                // Store encrypted data directly (will be decrypted when needed)
                card.setCard_number_encrypted(rs.getString("card_number"));
                card.setCvv_encrypted(rs.getString("cvv"));
                
                card.setExpiry_date(rs.getString("expiry_date"));
                card.setCard_type(rs.getString("card_type"));
                return card;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a card with encryption
    public boolean updateCard(PaymentCard card) {
        String query = "UPDATE PaymentCards SET card_holder_name = ?, card_number = ?, expiry_date = ?, cvv = ?, card_type = ? WHERE card_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, card.getCard_holder_name());
            
            // Always encrypt card number and CVV before storing
            String cardNumber = card.getCard_number();
            String cvv = card.getCvv();
            
            String encryptedCardNumber = EncryptionUtil.encrypt(cardNumber);
            String encryptedCvv = EncryptionUtil.encrypt(cvv);
            
            stmt.setString(2, encryptedCardNumber);
            stmt.setString(3, card.getExpiry_date());
            stmt.setString(4, encryptedCvv);
            stmt.setString(5, card.getCard_type());
            stmt.setInt(6, card.getCard_id());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a card
    public boolean deleteCard(int cardId) {
        String query = "DELETE FROM PaymentCards WHERE card_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, cardId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
