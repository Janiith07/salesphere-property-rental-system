package com.salesphere.servlet;

import com.salesphere.model.Booking;
import com.salesphere.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/book-property")
public class MakeBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String propertyIdParam = request.getParameter("id");
        if (propertyIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required.");
            return;
        }

        request.setAttribute("propertyId", propertyIdParam);
        request.setAttribute("isLoggedIn", true);
        request.getRequestDispatcher("/client/book.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int tenantId = (int) session.getAttribute("userId");
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        String bookingDate = LocalDate.now().format(DateTimeFormatter.ISO_DATE); // e.g., "2025-05-04"

        Booking booking = new Booking();
        booking.setTenantId(tenantId);
        booking.setPropertyId(propertyId);
        booking.setBookingDate(bookingDate);
        booking.setStatus("Pending");

        boolean created = bookingService.createBooking(booking);

        if (created) {
            request.setAttribute("success", "Booking successful! You will be contacted by the property owner.");
        } else {
            request.setAttribute("error", "Booking failed. Please try again.");
        }

        request.setAttribute("propertyId", propertyId);
        request.setAttribute("isLoggedIn", true);
        request.getRequestDispatcher("/client/userPaymentCards.jsp").forward(request, response);
    }
}