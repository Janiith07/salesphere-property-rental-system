package com.salesphere.servlet;

import com.salesphere.model.Review;
import com.salesphere.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyReviewsServlet", urlPatterns = {"/my-reviews"})
public class MyReviewsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        reviewService = new ReviewService();
        System.out.println("MyReviewsServlet initialized successfully!");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int tenantId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        try {
            if (action == null) {
                // Display all reviews by this tenant
                List<Review> reviews = reviewService.getReviewsByTenantId(tenantId);
                System.out.println("Tenant ID: " + tenantId);
                System.out.println("Number of reviews found: " + (reviews != null ? reviews.size() : 0));
                request.setAttribute("reviews", reviews);
                request.setAttribute("isLoggedIn", true);
                request.setAttribute("name", session.getAttribute("name"));
                request.getRequestDispatcher("/client/my-reviews.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                // Show edit form
                int reviewId = Integer.parseInt(request.getParameter("id"));
                Review review = reviewService.getReviewById(reviewId);

                // Verify ownership
                if (review != null && review.getTenantId() == tenantId) {
                    request.setAttribute("review", review);
                    request.setAttribute("isLoggedIn", true);
                    request.setAttribute("name", session.getAttribute("name"));
                    request.getRequestDispatcher("/client/edit-review.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
                }

            } else if ("delete".equals(action)) {
                // Delete review
                int reviewId = Integer.parseInt(request.getParameter("id"));
                Review review = reviewService.getReviewById(reviewId);

                // Verify ownership before deleting
                if (review != null && review.getTenantId() == tenantId) {
                    reviewService.deleteReview(reviewId);
                    response.sendRedirect(request.getContextPath() + "/my-reviews?success=deleted");
                } else {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
                }

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int tenantId = (int) session.getAttribute("userId");

        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            // Verify ownership
            Review existingReview = reviewService.getReviewById(reviewId);
            if (existingReview == null || existingReview.getTenantId() != tenantId) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
                return;
            }

            // Update review
            Review review = new Review();
            review.setReviewId(reviewId);
            review.setRating(rating);
            review.setComment(comment);

            boolean success = reviewService.updateReview(review);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/my-reviews?success=updated");
            } else {
                request.setAttribute("error", "Failed to update review.");
                request.setAttribute("review", review);
                request.getRequestDispatcher("/client/edit-review.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update review.");
        }
    }
}