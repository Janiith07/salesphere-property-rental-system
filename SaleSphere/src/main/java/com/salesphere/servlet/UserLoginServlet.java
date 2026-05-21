package com.salesphere.servlet;

import com.salesphere.model.Buyer;
import com.salesphere.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debug logging
        System.out.println("Login attempt for email: " + email);
        
        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
            return;
        }

        // Check if user exists
        Buyer user = userService.getUserByEmail(email);
        if (user == null) {
            System.out.println("User not found for email: " + email);
            request.setAttribute("error", "No account found with this email address.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
            return;
        }

        // Verify password
        boolean passwordValid = userService.verifyPassword(email, password);
        System.out.println("Password verification result: " + passwordValid);

        if (passwordValid) {
            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("name", user.getFullName());
            session.setAttribute("email", user.getEmail());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            System.out.println("Login successful for user: " + user.getFullName());
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            System.out.println("Invalid password for email: " + email);
            request.setAttribute("error", "Invalid password. Please try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        request.getRequestDispatcher("/client/login.jsp").forward(request, response);
    }
}