package com.salesphere.service;

import com.salesphere.model.Buyer;
import com.salesphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {

    // Create User (Tenant)
    public boolean createUser(Buyer user) {
        String query = "INSERT INTO users (full_name, email, password, phone, nic_number, address) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getNicNumber());
            stmt.setString(6, user.getAddress());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get User by ID
    public Buyer getUserById(int userId) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Buyer user = new Buyer();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Hashed password
                user.setPhone(rs.getString("phone"));
                user.setNicNumber(rs.getString("nic_number"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getString("created_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Users
    public List<Buyer> getAllUsers() {
        List<Buyer> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY user_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Buyer user = new Buyer();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Hashed password
                user.setPhone(rs.getString("phone"));
                user.setNicNumber(rs.getString("nic_number"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getString("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Update User
    public boolean updateUser(Buyer user) {
        String query = "UPDATE users SET full_name = ?, email = ?, password = ?, phone = ?, nic_number = ?, address = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getNicNumber());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete User
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get User by Email (for login)
    public Buyer getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Buyer user = new Buyer();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Hashed password
                user.setPhone(rs.getString("phone"));
                user.setNicNumber(rs.getString("nic_number"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getString("created_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Verify Password
    public boolean verifyPassword(String email, String password) {
        try {
            Buyer user = getUserByEmail(email);
            if (user != null) {
                String hashedPassword = user.getPassword();
                if (hashedPassword != null && !hashedPassword.isEmpty()) {
                    return BCrypt.checkpw(password, hashedPassword);
                } else {
                    System.err.println("Error: User password is null or empty for email: " + email);
                }
            } else {
                System.err.println("Error: User not found for email: " + email);
            }
        } catch (Exception e) {
            System.err.println("Error verifying password for email " + email + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}