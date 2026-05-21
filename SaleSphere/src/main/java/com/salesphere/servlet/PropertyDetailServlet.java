package com.salesphere.servlet;

import com.salesphere.model.Property;
import com.salesphere.model.Review;
import com.salesphere.service.PropertyService;
import com.salesphere.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/property-detail")
public class PropertyDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
        reviewService = new ReviewService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyIdParam = request.getParameter("id");
        if (propertyIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required.");
            return;
        }

        try {
            System.out.println("PropertyDetailServlet: Processing request for property ID: " + propertyIdParam);
            int propertyId = Integer.parseInt(propertyIdParam);
            
            // Get property details
            Property property = propertyService.getPropertyById(propertyId);
            if (property == null) {
                System.out.println("PropertyDetailServlet: Property not found for ID: " + propertyId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Property not found.");
                return;
            }
            
            System.out.println("PropertyDetailServlet: Found property: " + property.getTitle());

            // Get reviews for this property
            List<Review> reviews = reviewService.getReviewsByPropertyId(propertyId);
            System.out.println("PropertyDetailServlet: Found " + reviews.size() + " reviews");
            
            // Get review statistics
            Map<String, Object> reviewStats = propertyService.getReviewStatistics(propertyId);
            System.out.println("PropertyDetailServlet: Review stats: " + reviewStats);
            
            // Get similar properties
            List<Property> similarProperties = propertyService.getSimilarProperties(propertyId, property.getType());
            System.out.println("PropertyDetailServlet: Found " + similarProperties.size() + " similar properties");

            // Set attributes for JSP
            request.setAttribute("property", property);
            request.setAttribute("reviews", reviews);
            request.setAttribute("reviewStats", reviewStats);
            request.setAttribute("similarProperties", similarProperties);

            // Check login status
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                request.setAttribute("isLoggedIn", true);
            } else {
                request.setAttribute("isLoggedIn", false);
            }

            System.out.println("PropertyDetailServlet: Forwarding to property-detail.jsp");
            request.getRequestDispatcher("/client/property-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("PropertyDetailServlet: Invalid property ID format: " + propertyIdParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID format.");
        } catch (Exception e) {
            System.out.println("PropertyDetailServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading property details: " + e.getMessage());
        }
    }
}
