package com.salesphere.servlet;

import com.salesphere.service.PropertyService;
import com.salesphere.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/seller/publish-property")
public class PublishPropertyServlet extends HttpServlet {
    private PropertyService propertyService;

    @Override
    public void init() throws ServletException {
        super.init();
        propertyService = new PropertyService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
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
            request.setAttribute("error", "Access denied. Only sellers can publish properties.");
            request.getRequestDispatcher("/client/my-properties.jsp").forward(request, response);
            return;
        }
        
        String propertyIdStr = request.getParameter("propertyId");
        
        if (propertyIdStr == null) {
            request.setAttribute("error", "Invalid property ID");
            request.getRequestDispatcher("/client/my-properties.jsp").forward(request, response);
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            int sellerId = (Integer) session.getAttribute("adminId");
            
            // Verify that the property belongs to this seller
            Property property = propertyService.getPropertyById(propertyId);
            if (property == null || property.getLandlordId() != sellerId) {
                request.setAttribute("error", "Property not found or access denied");
                request.getRequestDispatcher("/client/my-properties.jsp").forward(request, response);
                return;
            }
            
            // Publish the property (set status to Pending for admin approval)
            boolean success = propertyService.publishProperty(propertyId);
            
            if (success) {
                request.setAttribute("success", "Property submitted for approval successfully!");
            } else {
                request.setAttribute("error", "Failed to submit property for approval");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid property ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request: " + e.getMessage());
        }
        
        // Redirect back to my-properties page
        response.sendRedirect(request.getContextPath() + "/client/my-properties.jsp");
    }
}
