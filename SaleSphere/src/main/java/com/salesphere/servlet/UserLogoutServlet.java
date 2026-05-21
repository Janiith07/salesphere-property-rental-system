package com.salesphere.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class UserLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("user");
            session.removeAttribute("userId");
            session.removeAttribute("name");
            session.removeAttribute("email");
            session.invalidate(); // Optional: fully invalidate session
        }

        // Remove "remember me" cookie if used
        Cookie rememberCookie = new Cookie("rememberUserEmail", "");
        rememberCookie.setMaxAge(0);
        rememberCookie.setPath(request.getContextPath());
        response.addCookie(rememberCookie);

        response.sendRedirect(request.getContextPath() + "/");
    }
}