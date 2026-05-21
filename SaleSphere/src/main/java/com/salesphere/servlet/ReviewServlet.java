package com.salesphere.servlet;

import com.salesphere.service.ReviewService;
import com.salesphere.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/review")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        reviewService = new ReviewService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session and Role Check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"Admin".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Access denied. Only Admins can view feedbacks.');</script>");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/logout';");
            return;
        }

        try {
            List<Review> reviews = reviewService.getAllReviews();
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/admin/reviews/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load feedbacks.");
        }
    }
}