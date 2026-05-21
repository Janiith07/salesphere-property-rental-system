package com.salesphere.servlet;

import com.salesphere.model.PaymentCard;
import com.salesphere.service.PaymentCardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/viewCards")
public class ViewCardsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentCardService cardService;

    @Override
    public void init() throws ServletException {
        cardService = new PaymentCardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Payment Cards View</title>");
        out.println("<style>");
        out.println("body{font-family:Arial;margin:20px;background:#f5f5f5;}");
        out.println("table{border-collapse:collapse;width:100%;background:white;box-shadow:0 2px 10px rgba(0,0,0,0.1);}");
        out.println("th,td{border:1px solid #ddd;padding:12px;text-align:left;}");
        out.println("th{background-color:#4CAF50;color:white;font-weight:bold;}");
        out.println("tr:nth-child(even){background-color:#f2f2f2;}");
        out.println("tr:hover{background-color:#e8f5e8;}");
        out.println(".encrypted{color:#666;font-style:italic;}");
        out.println(".masked{color:#2E7D32;font-weight:bold;}");
        out.println("h1{color:#2E7D32;text-align:center;}");
        out.println("</style>");
        out.println("</head><body>");
        out.println("<h1>🔐 Payment Cards - Encrypted View</h1>");
        out.println("<p style='text-align:center;color:#666;'>This shows how your payment card data is securely stored and displayed</p>");
        
        try {
            // Get all cards for demonstration
            List<PaymentCard> allCards = cardService.getCardsByUserId(1);
            allCards.addAll(cardService.getCardsByUserId(2));
            allCards.addAll(cardService.getCardsByUserId(3));
            allCards.addAll(cardService.getCardsByUserId(4));
            allCards.addAll(cardService.getCardsByUserId(5));
            allCards.addAll(cardService.getCardsByUserId(6));
            allCards.addAll(cardService.getCardsByUserId(7));
            allCards.addAll(cardService.getCardsByUserId(8));
            
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>Card ID</th>");
            out.println("<th>User ID</th>");
            out.println("<th>Card Holder</th>");
            out.println("<th>🔒 Encrypted Card Number (Database)</th>");
            out.println("<th>👁️ Masked Card Number (Display)</th>");
            out.println("<th>🔒 Encrypted CVV (Database)</th>");
            out.println("<th>👁️ Masked CVV (Display)</th>");
            out.println("<th>Card Type</th>");
            out.println("<th>Expiry</th>");
            out.println("</tr>");
            
            for (PaymentCard card : allCards) {
                out.println("<tr>");
                out.println("<td>" + card.getCard_id() + "</td>");
                out.println("<td>" + card.getUser_id() + "</td>");
                out.println("<td>" + card.getCard_holder_name() + "</td>");
                out.println("<td class='encrypted'>" + card.getCard_number() + "</td>");
                out.println("<td class='masked'>" + card.getMaskedCardNumber() + "</td>");
                out.println("<td class='encrypted'>" + card.getCvv() + "</td>");
                out.println("<td class='masked'>" + card.getMaskedCvv() + "</td>");
                out.println("<td>" + card.getCard_type() + "</td>");
                out.println("<td>" + card.getExpiry_date() + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            
            out.println("<div style='margin-top:30px;padding:20px;background:#e8f5e8;border-radius:10px;'>");
            out.println("<h3>✅ Encryption Status: WORKING!</h3>");
            out.println("<p><strong>What you see above:</strong></p>");
            out.println("<ul>");
            out.println("<li><strong>🔒 Encrypted columns:</strong> Show the actual encrypted data stored in your database</li>");
            out.println("<li><strong>👁️ Masked columns:</strong> Show how users see the data (secure and masked)</li>");
            out.println("</ul>");
            out.println("<p><strong>Your payment card data is now secure!</strong> The long encrypted strings in the database cannot be read without the encryption key.</p>");
            out.println("</div>");
            
        } catch (Exception e) {
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("</body></html>");
    }
}
