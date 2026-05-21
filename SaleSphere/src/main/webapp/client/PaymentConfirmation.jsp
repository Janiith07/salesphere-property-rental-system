<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.salesphere.model.PaymentCard" %>
<%@ include file="./partials/sessionheader.jsp" %>

<%
    List<PaymentCard> cards = (List<PaymentCard>) request.getAttribute("cards");
    String selectedCardId = request.getParameter("cardId");
    PaymentCard selectedCard = null;

    if (selectedCardId != null && cards != null) {
        for (PaymentCard card : cards) {
            if (String.valueOf(card.getCard_id()).equals(selectedCardId)) {
                selectedCard = card;
                break;
            }
        }
    }
%>

<section class="min-h-screen bg-gray-100 py-10 px-4 sm:px-8">
    <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold text-center text-gray-800 mb-8">Confirm Your Payment</h1>

        <% if (selectedCard != null) {
            String type = selectedCard.getCard_type() != null ? selectedCard.getCard_type().toLowerCase() : "";
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

        <!-- Payment Summary Card -->
        <div class="bg-white rounded-2xl shadow-xl p-8 mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Payment Summary</h2>

            <div class="space-y-4 mb-6">
                <div class="flex justify-between py-3 border-b">
                    <span class="text-gray-600">Property Rental</span>
                    <span class="font-semibold text-gray-800">$2,500.00</span>
                </div>
                <div class="flex justify-between py-3 border-b">
                    <span class="text-gray-600">Service Fee</span>
                    <span class="font-semibold text-gray-800">$50.00</span>
                </div>
                <div class="flex justify-between py-3 border-b">
                    <span class="text-gray-600">Security Deposit</span>
                    <span class="font-semibold text-gray-800">$500.00</span>
                </div>
                <div class="flex justify-between py-4 bg-blue-50 px-4 rounded-lg">
                    <span class="text-lg font-bold text-gray-800">Total Amount</span>
                    <span class="text-2xl font-bold text-blue-600">$3,050.00</span>
                </div>
            </div>

            <h3 class="text-xl font-bold text-gray-800 mb-4">Payment Method</h3>

            <!-- Selected Card Display -->
            <div class="<%= bgColor %> text-white p-6 rounded-2xl shadow-lg mb-6">
                <div class="text-sm font-semibold mb-2 flex justify-between">
                    <span class="uppercase tracking-wider"><%= typeLabel %></span>
                    <span class="text-xs">#<%= selectedCard.getCard_id() %></span>
                </div>
                <div class="text-xl font-mono tracking-widest mb-4">
                    <%= selectedCard.getMaskedCardNumber() %>
                </div>
                <div class="mb-2 text-sm">
                    <p>Card Holder</p>
                    <p class="font-semibold"><%= selectedCard.getCard_holder_name() %></p>
                </div>
                <div class="flex justify-between text-sm">
                    <div>
                        <p>Expiry</p>
                        <p class="font-semibold"><%= selectedCard.getExpiry_date() %></p>
                    </div>
                    <div>
                        <p>CVV</p>
                        <p class="font-semibold">•••</p>
                    </div>
                </div>
            </div>

            <!-- Confirmation Form -->
            <form action="${pageContext.request.contextPath}/processPayment" method="post" onsubmit="return confirmPayment();">
                <input type="hidden" name="cardId" value="<%= selectedCard.getCard_id() %>">
                <input type="hidden" name="amount" value="3050.00">

                <div class="mb-6">
                    <label class="flex items-center">
                        <input type="checkbox" name="terms" required class="w-5 h-5 text-blue-600 rounded mr-3">
                        <span class="text-gray-700">I agree to the terms and conditions and authorize this payment</span>
                    </label>
                </div>

                <div class="flex gap-4">
                    <button type="submit" class="flex-1 bg-green-600 hover:bg-green-700 text-white font-bold py-4 px-6 rounded-xl transition-all transform hover:scale-105 shadow-lg">
                        💳 Confirm Payment - $3,050.00
                    </button>
                    <a href="${pageContext.request.contextPath}/paymentcard" class="flex-1 bg-gray-500 hover:bg-gray-600 text-white font-bold py-4 px-6 rounded-xl transition-all text-center">
                        ← Back to Cards
                    </a>
                </div>
            </form>
        </div>

        <% } else { %>

        <!-- No Card Selected -->
        <div class="bg-white rounded-2xl shadow-xl p-8 text-center">
            <div class="mb-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-2">Payment Method Selected</h2>
                <p class="text-gray-600">Please click comfirm button to continue with your payment.</p>
            </div>
            <a href="${pageContext.request.contextPath}/client/PaymentSuccessful.jsp" class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-xl transition-all">
                confirm your payment
            </a>
        </div>

        <% } %>

        <!-- Security Notice -->
        <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 mt-6">
            <div class="flex items-start">
                <i class="fas fa-shield-alt text-blue-600 text-2xl mr-4 mt-1"></i>
                <div>
                    <h4 class="font-bold text-blue-900 mb-1">Secure Payment</h4>
                    <p class="text-blue-800 text-sm">Your payment information is encrypted and secure. We never store your CVV.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    function confirmPayment() {
        return confirm('Are you sure you want to process this payment of $3,050.00?');
    }
</script>

<%@ include file="./partials/footer.jsp" %>