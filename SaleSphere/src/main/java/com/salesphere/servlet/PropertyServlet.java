package com.salesphere.servlet;

import com.salesphere.service.PropertyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/property")
public class PropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"Admin".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('You do not have permission to access this page.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/logout';</script>");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action == null) {
                request.setAttribute("properties", propertyService.getAllPropertiesForAdmin());
                request.getRequestDispatcher("/admin/properties/index.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                propertyService.deleteProperty(id);
                response.sendRedirect(request.getContextPath() + "/admin/property");

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}