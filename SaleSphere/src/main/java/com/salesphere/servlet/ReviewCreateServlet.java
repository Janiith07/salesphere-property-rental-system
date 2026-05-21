package com.salesphere.servlet;

import com.salesphere.model.Review;
import com.salesphere.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/review")
public class ReviewCreateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String propertyIdParam = request.getParameter("propertyId");
        if (propertyIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
            return;
        }

        request.setAttribute("propertyId", propertyIdParam);
        request.setAttribute("isLoggedIn", true);
        request.setAttribute("name", session.getAttribute("name"));
        request.getRequestDispatcher("/client/review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int tenantId = (int) session.getAttribute("userId");
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            Review review = new Review();
            review.setTenantId(tenantId);
            review.setPropertyId(propertyId);
            review.setRating(rating);
            review.setComment(comment);

            boolean success = reviewService.createReview(review);
            if (success) {
                request.setAttribute("success", "Thank you! Your review has been submitted.");
            } else {
                request.setAttribute("error", "Failed to submit review. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
        }

        request.getRequestDispatcher("/client/review.jsp").forward(request, response);
    }
}