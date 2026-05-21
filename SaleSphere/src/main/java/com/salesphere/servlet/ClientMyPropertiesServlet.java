package com.salesphere.servlet;

import com.salesphere.model.Property;
import com.salesphere.service.PropertyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/client/my-properties")
public class ClientMyPropertiesServlet extends HttpServlet {
    private PropertyService propertyService;

    @Override
    public void init() throws ServletException {
        super.init();
        propertyService = new PropertyService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if user is logged in as seller
        if (session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }
        
        // Check if user has seller role (Landlord)
        String role = (String) session.getAttribute("role");
        if (!"Landlord".equals(role)) {
            request.setAttribute("error", "Access denied. Only sellers can view their properties.");
            request.getRequestDispatcher("/client/my-properties.jsp").forward(request, response);
            return;
        }
        
        try {
            int sellerId = (Integer) session.getAttribute("adminId");
            
            // Get properties for this seller with approval status
            List<Property> properties = propertyService.getPropertiesByLandlordIdWithApproval(sellerId);
            request.setAttribute("properties", properties);
            
            // Forward to my-properties page
            request.getRequestDispatcher("/client/my-properties.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading properties: " + e.getMessage());
            request.getRequestDispatcher("/client/my-properties.jsp").forward(request, response);
        }
    }
}
