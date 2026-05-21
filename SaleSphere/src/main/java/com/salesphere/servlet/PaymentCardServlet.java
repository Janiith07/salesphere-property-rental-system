package com.salesphere.servlet;

import com.salesphere.model.PaymentCard;
import com.salesphere.service.PaymentCardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/paymentcard")  // Changed mapping to /paymentcard
public class PaymentCardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentCardService cardService;

    @Override
    public void init() throws ServletException {
        cardService = new PaymentCardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        if (action == null) {
            List<PaymentCard> cards = cardService.getCardsByUserId(userId);
            request.setAttribute("cards", cards);
            request.getRequestDispatcher("/client/userPaymentCards.jsp").forward(request, response);

        } else if ("create".equals(action)) {
            request.getRequestDispatcher("/client/userCardCreate.jsp").forward(request, response);

        } else if ("edit".equals(action)) {
            int cardId = Integer.parseInt(request.getParameter("id"));
            PaymentCard card = cardService.getCard(cardId);
            if (card != null && card.getUser_id() == userId) {
                request.setAttribute("card", card);
                request.getRequestDispatcher("/client/userCardEdit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/paymentcard");
            }

        } else if ("delete".equals(action)) {
            int cardId = Integer.parseInt(request.getParameter("id"));
            PaymentCard card = cardService.getCard(cardId);
            if (card != null && card.getUser_id() == userId) {
                cardService.deleteCard(cardId);
            }
            response.sendRedirect(request.getContextPath() + "/paymentcard");

        } else if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        if ("create".equals(action)) {
            PaymentCard card = new PaymentCard();
            card.setUser_id(userId);
            card.setCard_holder_name(request.getParameter("card_holder_name"));
            card.setCard_number(request.getParameter("card_number"));
            card.setExpiry_date(request.getParameter("expiry_date"));
            card.setCvv(request.getParameter("cvv"));
            card.setCard_type(request.getParameter("card_type"));

            if (cardService.addCard(card)) {
                response.sendRedirect(request.getContextPath() + "/paymentcard");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

        } else if ("update".equals(action)) {
            try {
                int cardId = Integer.parseInt(request.getParameter("id"));
                PaymentCard card = cardService.getCard(cardId);
                if (card != null && card.getUser_id() == userId) {
                    card.setCard_holder_name(request.getParameter("card_holder_name"));
                    card.setExpiry_date(request.getParameter("expiry_date"));

                    if (cardService.updateCard(card)) {
                        response.sendRedirect(request.getContextPath() + "/paymentcard");
                    } else {
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/paymentcard");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid card update request.");
            }

        } else if ("delete".equals(action)) {
            int cardId = Integer.parseInt(request.getParameter("card_id"));
            PaymentCard card = cardService.getCard(cardId);
            if (card != null && card.getUser_id() == userId) {
                cardService.deleteCard(cardId);
            }
            response.sendRedirect(request.getContextPath() + "/paymentcard");
        }
    }
}
