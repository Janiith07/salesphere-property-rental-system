package com.salesphere.service;

import com.salesphere.model.Property;
import com.salesphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyService {

    public PropertyService() {
        initializeDatabase();
    }

    // Create property and return generated ID (robust for subsequent image updates)
    public int createPropertyReturningId(Property property) {
        String queryWithImages = "INSERT INTO properties (landlord_id, title, address, type, rent, status, approval_status, description, main_image, image1, image2, image3, image4, image5) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(queryWithImages, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, property.getLandlordId());
            stmt.setString(2, property.getTitle());
            stmt.setString(3, property.getAddress());
            stmt.setString(4, property.getType());
            stmt.setDouble(5, property.getRent());
            stmt.setString(6, property.getStatus());
            stmt.setString(7, property.getApprovalStatus() != null ? property.getApprovalStatus() : "Pending");
            stmt.setString(8, property.getDescription());
            stmt.setString(9, property.getMainImage());
            stmt.setString(10, property.getImage1());
            stmt.setString(11, property.getImage2());
            stmt.setString(12, property.getImage3());
            stmt.setString(13, property.getImage4());
            stmt.setString(14, property.getImage5());
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                ResultSet keys = stmt.getGeneratedKeys();
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("createPropertyReturningId failed: " + e.getMessage());
            // Fallback without image columns
            try (Connection connection = DBConnection.getConnection();
                 PreparedStatement fallbackStmt = connection.prepareStatement(
                         "INSERT INTO properties (landlord_id, title, address, type, rent, status, approval_status, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                         Statement.RETURN_GENERATED_KEYS)) {
                fallbackStmt.setInt(1, property.getLandlordId());
                fallbackStmt.setString(2, property.getTitle());
                fallbackStmt.setString(3, property.getAddress());
                fallbackStmt.setString(4, property.getType());
                fallbackStmt.setDouble(5, property.getRent());
                fallbackStmt.setString(6, property.getStatus());
                fallbackStmt.setString(7, property.getApprovalStatus() != null ? property.getApprovalStatus() : "Pending");
                fallbackStmt.setString(8, property.getDescription());
                int affected = fallbackStmt.executeUpdate();
                if (affected > 0) {
                    ResultSet keys = fallbackStmt.getGeneratedKeys();
                    if (keys.next()) {
                        return keys.getInt(1);
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return -1;
    }

    // Get Property by ID
    public Property getPropertyById(int propertyId) {
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setLandlordId(rs.getInt("landlord_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setApprovalStatus(rs.getString("approval_status"));
                property.setDescription(rs.getString("description"));
                property.setCreatedAt(rs.getString("created_at"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                
                // Set image fields (handle missing columns gracefully)
                try {
                    property.setMainImage(rs.getString("main_image"));
                    property.setImage1(rs.getString("image1"));
                    property.setImage2(rs.getString("image2"));
                    property.setImage3(rs.getString("image3"));
                    property.setImage4(rs.getString("image4"));
                    property.setImage5(rs.getString("image5"));
                } catch (SQLException e) {
                    // Image columns don't exist yet, set to null
                    property.setMainImage(null);
                    property.setImage1(null);
                    property.setImage2(null);
                    property.setImage3(null);
                    property.setImage4(null);
                    property.setImage5(null);
                }
                
                return property;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Properties for Admin (including pending/rejected)
    public List<Property> getAllPropertiesForAdmin() {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "ORDER BY p.property_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setApprovalStatus(rs.getString("approval_status"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                
                // Handle main_image column (may not exist in older database)
                try {
                    property.setMainImage(rs.getString("main_image"));
                } catch (SQLException e) {
                    property.setMainImage(null);
                }
                
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    // Get All Properties (view) - Only approved properties for public
    public List<Property> getAllProperties() {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.approval_status = 'Approved' " +
                "ORDER BY p.property_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                
                // Handle main_image column (may not exist in older database)
                try {
                    property.setMainImage(rs.getString("main_image"));
                } catch (SQLException e) {
                    property.setMainImage(null);
                }
                
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    //Search and Filter Properties
    public List<Property> searchAndFilterProperties(String searchTerm, String statusFilter) {
        List<Property> properties = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.approval_status = 'Approved'"
        );

        List<String> params = new ArrayList<>();

        // Add search condition
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            query.append(" AND (LOWER(p.title) LIKE ? OR LOWER(p.address) LIKE ? OR " +
                    "LOWER(a.full_name) LIKE ? OR LOWER(p.type) LIKE ?)");
            String searchPattern = "%" + searchTerm.toLowerCase() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Add status filter
        if (statusFilter != null && !statusFilter.trim().isEmpty() && !"all".equalsIgnoreCase(statusFilter)) {
            query.append(" AND p.status = ?");
            params.add(statusFilter);
        }

        query.append(" ORDER BY p.property_id");

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setString(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                property.setMainImage(rs.getString("main_image"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    // Get Properties by Landlord ID (view)
    public List<Property> getPropertiesByLandlordId(int landlordId) {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.landlord_id = ? " +
                "ORDER BY p.property_id";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, landlordId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setDescription(rs.getString("description"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                property.setCreatedAt(rs.getString("created_at"));
                
                // Set image fields
                property.setMainImage(rs.getString("main_image"));
                property.setImage1(rs.getString("image1"));
                property.setImage2(rs.getString("image2"));
                property.setImage3(rs.getString("image3"));
                property.setImage4(rs.getString("image4"));
                property.setImage5(rs.getString("image5"));
                
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    // Update Property
    public boolean updateProperty(Property property) {
        String query = "UPDATE properties SET title = ?, address = ?, type = ?, rent = ?, status = ?, description = ? WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, property.getTitle());
            stmt.setString(2, property.getAddress());
            stmt.setString(3, property.getType());
            stmt.setDouble(4, property.getRent());
            stmt.setString(5, property.getStatus());
            stmt.setString(6, property.getDescription());
            stmt.setInt(7, property.getPropertyId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update Property with Images
    public boolean updatePropertyWithImages(Property property) {
        String query = "UPDATE properties SET title = ?, address = ?, type = ?, rent = ?, status = ?, description = ?, " +
                "main_image = ?, image1 = ?, image2 = ?, image3 = ?, image4 = ?, image5 = ? WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, property.getTitle());
            stmt.setString(2, property.getAddress());
            stmt.setString(3, property.getType());
            stmt.setDouble(4, property.getRent());
            stmt.setString(5, property.getStatus());
            stmt.setString(6, property.getDescription());
            stmt.setString(7, property.getMainImage());
            stmt.setString(8, property.getImage1());
            stmt.setString(9, property.getImage2());
            stmt.setString(10, property.getImage3());
            stmt.setString(11, property.getImage4());
            stmt.setString(12, property.getImage5());
            stmt.setInt(13, property.getPropertyId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Property
    public boolean deleteProperty(int propertyId) {
        String query = "DELETE FROM properties WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get Review Statistics for a Property
    public java.util.Map<String, Object> getReviewStatistics(int propertyId) {
        String query = "SELECT " +
                "COUNT(*) as total_reviews, " +
                "AVG(rating) as average_rating, " +
                "SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as five_star_count, " +
                "SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as four_star_count, " +
                "SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as three_star_count, " +
                "SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as two_star_count, " +
                "SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as one_star_count " +
                "FROM reviews WHERE property_id = ?";
        
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int totalReviews = rs.getInt("total_reviews");
                double averageRating = rs.getDouble("average_rating");
                
                stats.put("totalReviews", totalReviews);
                stats.put("averageRating", totalReviews > 0 ? Math.round(averageRating * 10.0) / 10.0 : 0.0);
                
                if (totalReviews > 0) {
                    stats.put("fiveStarPercent", Math.round((rs.getInt("five_star_count") * 100.0) / totalReviews));
                    stats.put("fourStarPercent", Math.round((rs.getInt("four_star_count") * 100.0) / totalReviews));
                    stats.put("threeStarPercent", Math.round((rs.getInt("three_star_count") * 100.0) / totalReviews));
                    stats.put("twoStarPercent", Math.round((rs.getInt("two_star_count") * 100.0) / totalReviews));
                    stats.put("oneStarPercent", Math.round((rs.getInt("one_star_count") * 100.0) / totalReviews));
                } else {
                    stats.put("fiveStarPercent", 0);
                    stats.put("fourStarPercent", 0);
                    stats.put("threeStarPercent", 0);
                    stats.put("twoStarPercent", 0);
                    stats.put("oneStarPercent", 0);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    // Get Similar Properties (same type, different property)
    public List<Property> getSimilarProperties(int propertyId, String propertyType) {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.property_id != ? AND p.type = ? AND p.status = 'Available' " +
                "ORDER BY RAND() LIMIT 3";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            stmt.setString(2, propertyType);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setDescription(rs.getString("description"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                property.setMainImage(rs.getString("main_image"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }
    
    // Get Properties Pending Approval
    public List<Property> getPropertiesPendingApproval() {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.approval_status = 'Pending' " +
                "ORDER BY p.created_at ASC";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setLandlordId(rs.getInt("landlord_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setApprovalStatus(rs.getString("approval_status"));
                property.setDescription(rs.getString("description"));
                property.setCreatedAt(rs.getString("created_at"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                
                // Set image fields
                try {
                    property.setMainImage(rs.getString("main_image"));
                    property.setImage1(rs.getString("image1"));
                    property.setImage2(rs.getString("image2"));
                    property.setImage3(rs.getString("image3"));
                    property.setImage4(rs.getString("image4"));
                    property.setImage5(rs.getString("image5"));
                } catch (SQLException e) {
                    // Image columns don't exist yet, set to null
                    property.setMainImage(null);
                    property.setImage1(null);
                    property.setImage2(null);
                    property.setImage3(null);
                    property.setImage4(null);
                    property.setImage5(null);
                }
                
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }
    
    // Approve Property
    public boolean approveProperty(int propertyId) {
        String query = "UPDATE properties SET approval_status = 'Approved' WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Reject Property
    public boolean rejectProperty(int propertyId) {
        String query = "UPDATE properties SET approval_status = 'Rejected' WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Publish Property (for sellers)
    public boolean publishProperty(int propertyId) {
        String query = "UPDATE properties SET approval_status = 'Pending' WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get Properties by Landlord ID with Approval Status
    public List<Property> getPropertiesByLandlordIdWithApproval(int landlordId) {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.landlord_id = ? " +
                "ORDER BY p.created_at DESC";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, landlordId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setApprovalStatus(rs.getString("approval_status"));
                property.setDescription(rs.getString("description"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                property.setCreatedAt(rs.getString("created_at"));
                
                // Set image fields
                property.setMainImage(rs.getString("main_image"));
                property.setImage1(rs.getString("image1"));
                property.setImage2(rs.getString("image2"));
                property.setImage3(rs.getString("image3"));
                property.setImage4(rs.getString("image4"));
                property.setImage5(rs.getString("image5"));
                
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }
    
    // Get Only Approved Properties for Public View
    public List<Property> getApprovedProperties() {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT p.*, COALESCE(s.full_name, a.full_name) AS landlord_name, COALESCE(s.email, a.email) AS landlord_email " +
                "FROM properties p " +
                "JOIN admins a ON p.landlord_id = a.admin_id " +
                "LEFT JOIN sellers s ON s.admin_id = a.admin_id " +
                "WHERE p.approval_status = 'Approved' " +
                "ORDER BY p.property_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("property_id"));
                property.setTitle(rs.getString("title"));
                property.setAddress(rs.getString("address"));
                property.setType(rs.getString("type"));
                property.setRent(rs.getDouble("rent"));
                property.setStatus(rs.getString("status"));
                property.setApprovalStatus(rs.getString("approval_status"));
                property.setLandlordName(rs.getString("landlord_name"));
                property.setLandlordEmail(rs.getString("landlord_email"));
                
                // Handle main_image column (may not exist in older database)
                try {
                    property.setMainImage(rs.getString("main_image"));
                } catch (SQLException e) {
                    property.setMainImage(null);
                }
                
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }

    // Initialize database with image columns and approval_status if they don't exist
    private void initializeDatabase() {
        try (Connection connection = DBConnection.getConnection()) {
            // Check if image columns exist and add them if they don't
            String[] imageColumns = {"main_image", "image1", "image2", "image3", "image4", "image5"};
            
            for (String column : imageColumns) {
                try {
                    String alterQuery = "ALTER TABLE properties ADD COLUMN " + column + " VARCHAR(255)";
                    connection.createStatement().execute(alterQuery);
                    System.out.println("Added column: " + column);
                } catch (SQLException e) {
                    // Column already exists, ignore error
                    if (!e.getMessage().contains("Duplicate column name")) {
                        System.out.println("Could not add column " + column + ": " + e.getMessage());
                    }
                }
            }
            
            // Add approval_status column if it doesn't exist
            try {
                String alterQuery = "ALTER TABLE properties ADD COLUMN approval_status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending'";
                connection.createStatement().execute(alterQuery);
                System.out.println("Added column: approval_status");
                
                // Update existing properties to have 'Approved' status
                connection.createStatement().execute("UPDATE properties SET approval_status = 'Approved' WHERE approval_status IS NULL OR approval_status = ''");
                System.out.println("Updated existing properties to Approved status");
            } catch (SQLException e) {
                // Column already exists, ignore error
                if (!e.getMessage().contains("Duplicate column name")) {
                    System.out.println("Could not add column approval_status: " + e.getMessage());
                }
            }
        } catch (SQLException e) {
            System.out.println("Error initializing database: " + e.getMessage());
        }
    }
}