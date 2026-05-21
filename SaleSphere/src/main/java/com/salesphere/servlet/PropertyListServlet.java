package com.salesphere.servlet;

import com.salesphere.model.Property;
import com.salesphere.service.PropertyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/properties")
public class PropertyListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("PropertyListServlet: Starting request processing");
            
            // Get search and filter parameters
            String searchTerm = request.getParameter("search");
            String statusFilter = request.getParameter("status");

            System.out.println("PropertyListServlet: Search term: " + searchTerm + ", Status filter: " + statusFilter);

            // Fetch properties based on search/filter or get all approved properties
            List<Property> properties;
            if ((searchTerm != null && !searchTerm.trim().isEmpty()) ||
                    (statusFilter != null && !statusFilter.trim().isEmpty() && !"all".equalsIgnoreCase(statusFilter))) {
                properties = propertyService.searchAndFilterProperties(searchTerm, statusFilter);
            } else {
                properties = propertyService.getApprovedProperties();
            }

            System.out.println("PropertyListServlet: Found " + (properties != null ? properties.size() : 0) + " properties");

            request.setAttribute("properties", properties);
            request.setAttribute("searchTerm", searchTerm != null ? searchTerm : "");
            request.setAttribute("statusFilter", statusFilter != null ? statusFilter : "all");

            // Check login status and set session attributes
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                request.setAttribute("isLoggedIn", true);
                request.setAttribute("userFullName", session.getAttribute("name"));
            } else {
                request.setAttribute("isLoggedIn", false);
            }

            System.out.println("PropertyListServlet: Forwarding to properties.jsp");
            
            // Forward to property listing page
            request.getRequestDispatcher("/client/properties.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("PropertyListServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading properties: " + e.getMessage());
        }
    }
}