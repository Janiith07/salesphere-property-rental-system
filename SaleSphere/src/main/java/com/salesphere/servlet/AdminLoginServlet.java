package com.salesphere.servlet;

import com.salesphere.model.Admin;
import com.salesphere.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            String role = (String) session.getAttribute("role");
            if ("Admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/property");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/my-property");
            }
            return;
        }

        Admin admin = adminService.getAdminByEmail(email);
        if (admin != null && admin.getPassword().equals(password)) {
            session = request.getSession(true);
            session.setAttribute("admin", admin);
            session.setAttribute("adminId", admin.getAdminId());
            session.setAttribute("adminName", admin.getFullName());
            session.setAttribute("adminEmail", admin.getEmail());
            session.setAttribute("role", admin.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            if ("Admin".equals(admin.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/property");
            } else if ("Landlord".equals(admin.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/my-property");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/login");
            }
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            String role = (String) session.getAttribute("role");
            if ("Admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/property");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/my-property");
            }
        } else {
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}