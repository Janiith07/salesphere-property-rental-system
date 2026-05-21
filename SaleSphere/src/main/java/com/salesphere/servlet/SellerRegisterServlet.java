package com.salesphere.servlet;

import com.salesphere.model.Admin;
import com.salesphere.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/seller/register")
public class SellerRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to seller registration page
        request.getRequestDispatcher("/client/seller-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        // Basic password validation
        if (password.length() < 8 ||
                !password.matches(".*[A-Z].*") ||
                !password.matches(".*[a-z].*") ||
                !password.matches(".*\\d.*") ||
                !password.matches(".*[^a-zA-Z0-9].*")) {
            request.setAttribute("error", "Password must include uppercase, lowercase, digit, and symbol.");
            request.getRequestDispatcher("/client/seller-register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (adminService.getAdminByEmail(email) != null) {
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("/client/seller-register.jsp").forward(request, response);
            return;
        }

        // Create new Landlord account
        Admin seller = new Admin();
        seller.setFullName(fullName);
        seller.setEmail(email);
        seller.setPassword(password);
        seller.setPhone(phone);
        seller.setRole("Landlord"); // Set role to Landlord

        boolean success = adminService.createAdmin(seller);

        if (success) {
            request.setAttribute("success", "Registration successful! Please log in as a seller.");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/client/seller-register.jsp").forward(request, response);
        }
    }
}