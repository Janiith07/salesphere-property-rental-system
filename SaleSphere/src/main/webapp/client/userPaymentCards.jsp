<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.salesphere.model.PaymentCard" %>
<%@ include file="./partials/sessionheader.jsp" %>

<%
    List<PaymentCard> cards = (List<PaymentCard>) request.getAttribute("cards");
%>

<section class="min-h-screen bg-gray-100 py-10 px-4 sm:px-8">
    <div class="max-w-7xl mx-auto">
        <h1 class="text-4xl font-bold text-center text-gray-800 mb-12">Your Payment Cards</h1>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <% if (cards != null && !cards.isEmpty()) {
                for (PaymentCard card : cards) {
                    String type = card.getCard_type() != null ? card.getCard_type().toLowerCase() : "";
                    String bgColor = "bg-gray-800";
                    String typeLabel = "Card";
                    if (type.contains("visa")) {
                        bgColor = "bg-blue-600";
                        typeLabel = "VISA";
                    } else if (type.contains("master")) {
                        bgColor = "bg-red-600";
                        typeLabel = "MasterCard";
                    }
            %>
            <div class="transform transition hover:scale-105 duration-300">
                <div class="<%= bgColor %> text-white p-6 rounded-2xl shadow-2xl relative overflow-hidden">
                    <div class="text-sm font-semibold mb-2 flex justify-between">
                        <span class="uppercase tracking-wider"><%= typeLabel %></span>
                        <span class="text-xs">#<%= card.getCard_id() %></span>
                    </div>
                    <div class="text-xl font-mono tracking-widest mb-4">
                        <%= card.getMaskedCardNumber() %>
                    </div>
                    <div class="mb-2 text-sm">
                        <p>Card Holder</p>
                        <p class="font-semibold"><%= card.getCard_holder_name() %></p>
                    </div>
                    <div class="flex justify-between text-sm mb-4">
                        <div>
                            <p>Expiry</p>
                            <p class="font-semibold"><%= card.getExpiry_date() %></p>
                        </div>
                        <div>
                            <p>CVV</p>
                            <p class="font-semibold"><%= card.getMaskedCvv() %></p>
                        </div>
                    </div>

                    <!-- Pay with This Card Button -->
                    <a href="${pageContext.request.contextPath}/client/PaymentConfirmation.jsp?cardId=<%= card.getCard_id() %>"
                       class="block w-full bg-green-500 hover:bg-green-600 text-white font-bold py-3 rounded-xl text-center mb-2 transition">
                        💳 Pay with This Card
                    </a>

                    <div class="grid grid-cols-2 gap-2">
                        <a href="paymentcard?action=edit&id=<%= card.getCard_id() %>"
                           class="bg-yellow-500 hover:bg-yellow-600 text-white py-2 rounded-xl text-center block transition">
                            ✏️ Edit
                        </a>
                        <form action="paymentcard" method="post" class="m-0">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="card_id" value="<%= card.getCard_id() %>" />
                            <button type="submit"
                                    onclick="return confirm('Are you sure you want to delete this card?');"
                                    class="w-full bg-red-500 hover:bg-red-600 text-white py-2 rounded-xl transition">
                                🗑️ Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <% }} else { %>
            <div class="col-span-full text-center text-gray-500 text-lg">
                You haven't added any cards yet.
            </div>
            <% } %>
        </div>

        <div class="mt-12 text-center">
            <a href="${pageContext.request.contextPath}/paymentcard?action=create"
               class="btn btn-primary">
                ➕ Add New Card
            </a>
        </div>
    </div>
</section>

<%@ include file="./partials/footer.jsp" %>