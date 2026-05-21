package com.salesphere.servlet;

import com.salesphere.model.Buyer;
import com.salesphere.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String nicNumber = request.getParameter("nic_number");
        String address = request.getParameter("address");

        // Basic password validation
        if (password.length() < 8 ||
            !password.matches(".*[A-Z].*") ||
            !password.matches(".*[a-z].*") ||
            !password.matches(".*\\d.*") ||
            !password.matches(".*[^a-zA-Z0-9].*")) {
            request.setAttribute("error", "Password must include uppercase, lowercase, digit, and symbol.");
            request.getRequestDispatcher("/client/register.jsp").forward(request, response);
            return;
        }

        // NIC validation
        if (!(nicNumber.matches("\\d{12}") || nicNumber.matches("\\d{9}[vV]"))) {
            request.setAttribute("error", "Invalid NIC number format.");
            request.getRequestDispatcher("/client/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (userService.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("/client/register.jsp").forward(request, response);
            return;
        }

        // Create user object
        Buyer user = new Buyer();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setNicNumber(nicNumber);
        user.setAddress(address);

        boolean success = userService.createUser(user);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/client/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.getRequestDispatcher("/client/register.jsp").forward(request, response);
        }
    }
}