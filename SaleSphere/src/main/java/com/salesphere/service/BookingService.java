package com.salesphere.service;

import com.salesphere.model.Booking;
import com.salesphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    // Create Booking
    public boolean createBooking(Booking booking) {
        String query = "INSERT INTO bookings (tenant_id, property_id, booking_date, status) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, booking.getTenantId());
            stmt.setInt(2, booking.getPropertyId());
            stmt.setString(3, booking.getBookingDate());
            stmt.setString(4, booking.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Booking by ID
    public Booking getBookingById(int bookingId) {
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setTenantId(rs.getInt("tenant_id"));
                booking.setPropertyId(rs.getInt("property_id"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setStatus(rs.getString("status"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Bookings (view)
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings_view ORDER BY booking_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setTenantName(rs.getString("tenant_name"));
                booking.setPropertyTitle(rs.getString("property_title"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Update Booking Status
    public boolean updateBookingStatus(int bookingId, String status) {
        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Booking
    public boolean deleteBooking(int bookingId) {
        String query = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Bookings by Tenant ID (view)
    public List<Booking> getBookingsByTenantId(int tenantId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT b.booking_id, b.property_id, u.full_name AS tenant_name, p.title AS property_title, b.booking_date, b.status " +
                       "FROM bookings b " +
                       "JOIN users u ON b.tenant_id = u.user_id " +
                       "JOIN properties p ON b.property_id = p.property_id " +
                       "WHERE b.tenant_id = ? " +
                       "ORDER BY b.booking_date DESC";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, tenantId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setPropertyId(rs.getInt("property_id")); // new line
                booking.setTenantName(rs.getString("tenant_name"));
                booking.setPropertyTitle(rs.getString("property_title"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}