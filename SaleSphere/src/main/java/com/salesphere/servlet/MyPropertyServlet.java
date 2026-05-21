package com.salesphere.servlet;

import com.salesphere.model.Property;
import com.salesphere.service.PropertyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/my-property")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,  // 1MB
        maxFileSize = 1024 * 1024 * 5,             // 5MB
        maxRequestSize = 1024 * 1024 * 10)         // 10MB
public class MyPropertyServlet extends HttpServlet {
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
        if ("Admin".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Access denied. Only Admins can view feedbacks.');</script>");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/logout';");
            return;
        }

        int landlordId = (int) session.getAttribute("adminId");
        String action = request.getParameter("action");

        try {
            if (action == null) {
                List<Property> properties = propertyService.getPropertiesByLandlordIdWithApproval(landlordId);
                request.setAttribute("properties", properties);
                request.getRequestDispatcher("/admin/my-properties/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                request.getRequestDispatcher("/admin/my-properties/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Property property = propertyService.getPropertyById(id);
                if (property != null && property.getLandlordId() == landlordId) {
                    request.setAttribute("property", property);
                    request.getRequestDispatcher("/admin/my-properties/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                propertyService.deleteProperty(id);
                response.sendRedirect(request.getContextPath() + "/admin/my-property");

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if ("Admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        int landlordId = (int) session.getAttribute("adminId");
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                Property property = new Property();
                property.setLandlordId(landlordId);
                property.setTitle(request.getParameter("title"));
                property.setAddress(request.getParameter("address"));
                property.setType(request.getParameter("type"));
                property.setRent(Double.parseDouble(request.getParameter("rent")));
                property.setStatus(request.getParameter("status"));
                property.setDescription(request.getParameter("description"));

                int newId = propertyService.createPropertyReturningId(property);
                if (newId > 0) {
                    property.setPropertyId(newId);

                        String uploadPath = getServletContext().getRealPath("/") + "assets/properties/";
                        File dir = new File(uploadPath);
                        if (!dir.exists()) dir.mkdirs();

                    // Handle main image (fallback to default.jpg if none)
                    Part mainImagePart = request.getPart("main_image");
                    if (mainImagePart != null && mainImagePart.getSize() > 0) {
                        String mainImageFileName = "main_" + newId + "_" + System.currentTimeMillis() + ".jpg";
                        mainImagePart.write(uploadPath + File.separator + mainImageFileName);
                        property.setMainImage(mainImageFileName);
                    } else {
                        property.setMainImage("default.jpg");
                    }

                    // Handle additional images
                    String[] imageNames = {"image1", "image2", "image3", "image4", "image5"};
                    String[] imageFields = {"image1", "image2", "image3", "image4", "image5"};
                    
                    for (int i = 0; i < imageNames.length; i++) {
                        Part imagePart = request.getPart(imageNames[i]);
                        if (imagePart != null && imagePart.getSize() > 0) {
                            String imageFileName = "img" + (i+1) + "_" + newId + "_" + System.currentTimeMillis() + ".jpg";
                            imagePart.write(uploadPath + File.separator + imageFileName);
                            
                            switch (i) {
                                case 0: property.setImage1(imageFileName); break;
                                case 1: property.setImage2(imageFileName); break;
                                case 2: property.setImage3(imageFileName); break;
                                case 3: property.setImage4(imageFileName); break;
                                case 4: property.setImage5(imageFileName); break;
                            }
                        }
                    }

                    // Update property with image information
                    propertyService.updatePropertyWithImages(property);

                    response.sendRedirect(request.getContextPath() + "/admin/my-property");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create property.");
                }

            } else if ("update".equals(action)) {
                int propertyId = Integer.parseInt(request.getParameter("id"));
                Property existing = propertyService.getPropertyById(propertyId);
                if (existing == null || existing.getLandlordId() != landlordId) {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
                    return;
                }

                existing.setTitle(request.getParameter("title"));
                existing.setAddress(request.getParameter("address"));
                existing.setType(request.getParameter("type"));
                existing.setRent(Double.parseDouble(request.getParameter("rent")));
                existing.setStatus(request.getParameter("status"));
                existing.setDescription(request.getParameter("description"));

                        String uploadPath = getServletContext().getRealPath("/") + "assets/properties/";
                        File dir = new File(uploadPath);
                        if (!dir.exists()) dir.mkdirs();

                // Handle main image update (keep current or set default if missing)
                Part mainImagePart = request.getPart("main_image");
                if (mainImagePart != null && mainImagePart.getSize() > 0) {
                    String mainImageFileName = "main_" + propertyId + "_" + System.currentTimeMillis() + ".jpg";
                    mainImagePart.write(uploadPath + File.separator + mainImageFileName);
                    existing.setMainImage(mainImageFileName);
                } else if (existing.getMainImage() == null || existing.getMainImage().trim().isEmpty()) {
                    existing.setMainImage("default.jpg");
                }

                // Handle additional images update
                String[] imageNames = {"image1", "image2", "image3", "image4", "image5"};
                
                for (int i = 0; i < imageNames.length; i++) {
                    Part imagePart = request.getPart(imageNames[i]);
                    if (imagePart != null && imagePart.getSize() > 0) {
                        String imageFileName = "img" + (i+1) + "_" + propertyId + "_" + System.currentTimeMillis() + ".jpg";
                        imagePart.write(uploadPath + File.separator + imageFileName);
                        
                        switch (i) {
                            case 0: existing.setImage1(imageFileName); break;
                            case 1: existing.setImage2(imageFileName); break;
                            case 2: existing.setImage3(imageFileName); break;
                            case 3: existing.setImage4(imageFileName); break;
                            case 4: existing.setImage5(imageFileName); break;
                        }
                    }
                }

                if (propertyService.updatePropertyWithImages(existing)) {
                    response.sendRedirect(request.getContextPath() + "/admin/my-property");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update property.");
                }

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in MyPropertyServlet: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to process form: " + e.getMessage());
        }
    }
}
