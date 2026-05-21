package com.salesphere.servlet;

import com.google.gson.Gson;
import com.salesphere.model.Property;
import com.salesphere.service.PropertyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/properties/search")
public class PropertySearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Get search and filter parameters
        String searchTerm = request.getParameter("search");
        String statusFilter = request.getParameter("status");

        try {
            // Fetch properties based on search/filter
            List<Property> properties;
            if ((searchTerm != null && !searchTerm.trim().isEmpty()) ||
                    (statusFilter != null && !statusFilter.trim().isEmpty() && !"all".equalsIgnoreCase(statusFilter))) {
                properties = propertyService.searchAndFilterProperties(searchTerm, statusFilter);
            } else {
                properties = propertyService.getAllProperties();
            }

            // Convert to JSON and send response
            String jsonResponse = gson.toJson(properties);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to fetch properties\"}");
        }
    }
}