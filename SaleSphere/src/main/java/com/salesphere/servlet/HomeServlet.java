package com.salesphere.servlet;

import com.salesphere.model.Buyer;
import com.salesphere.model.Review;
import com.salesphere.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        boolean isLoggedIn = false;

        if (session != null && session.getAttribute("user") != null) {
            isLoggedIn = true;
            int userId = (int) session.getAttribute("userId");
            Buyer user = userService.getUserById(userId);
            request.setAttribute("user", user);
            request.setAttribute("userFullName", session.getAttribute("name"));
        }

        // Fetch top 3 reviews (most starred)
        List<Review> topReviews = new ArrayList<>();
        String query = "SELECT * FROM reviews_view ORDER BY rating DESC, reviewed_at DESC LIMIT 3";
        try (Connection connection = com.salesphere.util.DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setTenantName(rs.getString("tenant_name"));
                review.setPropertyTitle(rs.getString("property_title"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewedAt(rs.getString("reviewed_at"));
                topReviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("isLoggedIn", isLoggedIn);
        request.setAttribute("topReviews", topReviews);
        request.getRequestDispatcher("/client/home.jsp").forward(request, response);
    }
}