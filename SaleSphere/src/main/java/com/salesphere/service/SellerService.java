package com.salesphere.service;

import com.salesphere.model.Seller;
import com.salesphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SellerService {

    // Create Seller
    public boolean createSeller(Seller seller) {
        String query = "INSERT INTO sellers (full_name, email, password, phone, created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, seller.getFullName());
            stmt.setString(2, seller.getEmail());
            stmt.setString(3, seller.getPassword());
            stmt.setString(4, seller.getPhone());
            stmt.setString(5, seller.getCreatedAt());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Seller by ID
    public Seller getSellerById(int sellerId) {
        String query = "SELECT * FROM sellers WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Seller seller = new Seller();
                seller.setSellerId(rs.getInt("seller_id"));
                seller.setFullName(rs.getString("full_name"));
                seller.setEmail(rs.getString("email"));
                seller.setPassword(rs.getString("password"));
                seller.setPhone(rs.getString("phone"));
                seller.setCreatedAt(rs.getString("created_at"));
                return seller;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Sellers
    public List<Seller> getAllSellers() {
        List<Seller> sellers = new ArrayList<>();
        String query = "SELECT * FROM sellers ORDER BY seller_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Seller seller = new Seller();
                seller.setSellerId(rs.getInt("seller_id"));
                seller.setFullName(rs.getString("full_name"));
                seller.setEmail(rs.getString("email"));
                seller.setPassword(rs.getString("password"));
                seller.setPhone(rs.getString("phone"));
                seller.setCreatedAt(rs.getString("created_at"));
                sellers.add(seller);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sellers;
    }

    // Update Seller
    public boolean updateSeller(Seller seller) {
        String query = "UPDATE sellers SET full_name = ?, email = ?, password = ?, phone = ?, created_at = ? WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, seller.getFullName());
            stmt.setString(2, seller.getEmail());
            stmt.setString(3, seller.getPassword());
            stmt.setString(4, seller.getPhone());
            stmt.setString(5, seller.getCreatedAt());
            stmt.setInt(6, seller.getSellerId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Seller
    public boolean deleteSeller(int sellerId) {
        String query = "DELETE FROM sellers WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, sellerId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Seller by Email (for login)
    public Seller getSellerByEmail(String email) {
        String query = "SELECT * FROM sellers WHERE email = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Seller seller = new Seller();
                seller.setSellerId(rs.getInt("seller_id"));
                seller.setFullName(rs.getString("full_name"));
                seller.setEmail(rs.getString("email"));
                seller.setPassword(rs.getString("password"));
                seller.setPhone(rs.getString("phone"));
                seller.setCreatedAt(rs.getString("created_at"));
                return seller;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}