package com.salesphere.servlet;

import com.salesphere.model.Booking;
import com.salesphere.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

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

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int tenantId = (int) session.getAttribute("userId");

        // Fetch bookings by tenant ID
        List<Booking> bookings = bookingService.getBookingsByTenantId(tenantId);

        // Set attributes for JSP
        request.setAttribute("bookings", bookings);
        request.setAttribute("today", LocalDate.now().toString());
        request.setAttribute("isLoggedIn", true);
        request.setAttribute("userFullName", session.getAttribute("name"));

        // Forward to bookings JSP
        request.getRequestDispatcher("/client/my-bookings.jsp").forward(request, response);
    }
}