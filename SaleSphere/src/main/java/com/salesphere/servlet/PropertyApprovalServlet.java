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

@WebServlet("/admin/property-approval")
public class PropertyApprovalServlet extends HttpServlet {
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
        
        // Check if user is logged in as admin
        if (session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }
        
        // Check if user has admin role
        String role = (String) session.getAttribute("role");
        if (!"Admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }
        
        try {
            // Get pending properties for approval
            List<Property> pendingProperties = propertyService.getPropertiesPendingApproval();
            request.setAttribute("pendingProperties", pendingProperties);
            
            // Forward to approval page
            request.getRequestDispatcher("/admin/property-approval.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading pending properties: " + e.getMessage());
            request.getRequestDispatcher("/admin/property-approval.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if user is logged in as admin
        if (session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }
        
        // Check if user has admin role
        String role = (String) session.getAttribute("role");
        if (!"Admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String propertyIdStr = request.getParameter("propertyId");
        
        if (action == null || propertyIdStr == null) {
            request.setAttribute("error", "Invalid request parameters");
            doGet(request, response);
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "approve":
                    success = propertyService.approveProperty(propertyId);
                    message = success ? "Property approved successfully!" : "Failed to approve property";
                    break;
                case "reject":
                    success = propertyService.rejectProperty(propertyId);
                    message = success ? "Property rejected successfully!" : "Failed to reject property";
                    break;
                default:
                    message = "Invalid action";
                    break;
            }
            
            if (success) {
                request.setAttribute("success", message);
            } else {
                request.setAttribute("error", message);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid property ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request: " + e.getMessage());
        }
        
        // Redirect back to approval page
        doGet(request, response);
    }
}
