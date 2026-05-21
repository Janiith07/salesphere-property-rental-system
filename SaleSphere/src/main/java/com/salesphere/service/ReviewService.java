package com.salesphere.service;

import com.salesphere.model.Review;
import com.salesphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewService {

    // Create Review
    public boolean createReview(Review review) {
        String query = "INSERT INTO reviews (property_id, tenant_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, review.getPropertyId());
            stmt.setInt(2, review.getTenantId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Review by ID
    public Review getReviewById(int reviewId) {
        String query = "SELECT r.*, " +
                "COALESCE(rv.tenant_name, '') as tenant_name, " +
                "COALESCE(rv.property_title, '') as property_title " +
                "FROM reviews r " +
                "LEFT JOIN reviews_view rv ON r.review_id = rv.review_id " +
                "WHERE r.review_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setPropertyId(rs.getInt("property_id"));
                review.setTenantId(rs.getInt("tenant_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewedAt(rs.getString("reviewed_at"));
                review.setTenantName(rs.getString("tenant_name"));
                review.setPropertyTitle(rs.getString("property_title"));
                return review;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Reviews (with view)
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews_view ORDER BY review_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setPropertyId(rs.getInt("property_id"));
                review.setTenantId(rs.getInt("tenant_id"));
                review.setTenantName(rs.getString("tenant_name"));
                review.setPropertyTitle(rs.getString("property_title"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewedAt(rs.getString("reviewed_at"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Update Review
    public boolean updateReview(Review review) {
        String query = "UPDATE reviews SET rating = ?, comment = ? WHERE review_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComment());
            stmt.setInt(3, review.getReviewId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Review
    public boolean deleteReview(int reviewId) {
        String query = "DELETE FROM reviews WHERE review_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, reviewId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Reviews by Property ID
    public List<Review> getReviewsByPropertyId(int propertyId) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews_view WHERE property_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setPropertyId(rs.getInt("property_id"));
                review.setTenantId(rs.getInt("tenant_id"));
                review.setTenantName(rs.getString("tenant_name"));
                review.setPropertyTitle(rs.getString("property_title"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewedAt(rs.getString("reviewed_at"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Get Reviews by Tenant ID
    public List<Review> getReviewsByTenantId(int tenantId) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews_view WHERE tenant_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, tenantId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setPropertyId(rs.getInt("property_id"));
                review.setTenantId(rs.getInt("tenant_id"));
                review.setTenantName(rs.getString("tenant_name"));
                review.setPropertyTitle(rs.getString("property_title"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewedAt(rs.getString("reviewed_at"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}