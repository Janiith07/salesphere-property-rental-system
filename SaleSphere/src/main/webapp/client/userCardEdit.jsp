<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./partials/sessionheader.jsp" %>
<%@ page import="com.salesphere.model.PaymentCard" %>

<%
    PaymentCard card = (PaymentCard) request.getAttribute("card");
%>

<section class="min-h-screen bg-gray-100 py-10 px-4 sm:px-8">
  <div class="max-w-5xl mx-auto">
    <h1 class="text-3xl font-bold text-center mb-8 text-gray-800">Edit Your Payment Card</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
      <!-- Card Preview -->
      <div class="relative w-full h-64 rounded-2xl shadow-2xl overflow-hidden text-white p-6 transition-all duration-500 ease-in-out" id="cardPreview"
           style="background: <%= card.getCard_type().equalsIgnoreCase("Visa") ? "linear-gradient(135deg, #1e3a8a, #3b82f6)" : "linear-gradient(135deg, #991b1b, #dc2626)" %>;">
        <div class="flex justify-between text-sm font-semibold tracking-wider mb-4">
          <span id="cardTypePreview"><%= card.getCard_type().toUpperCase() %></span>
          <span id="cardIdPreview">#<%= card.getCard_id() %></span>
        </div>
        <div class="text-xl font-mono tracking-widest mb-6" id="cardNumberPreview">
          <%= card.getMaskedCardNumber() %>
        </div>
        <div class="mb-2">
          <p class="text-xs">Card Holder</p>
          <p class="font-semibold text-lg" id="cardHolderPreview"><%= card.getCard_holder_name() %></p>
        </div>
        <div class="flex justify-between mt-4">
          <div>
            <p class="text-xs">Expiry</p>
            <p class="font-semibold text-md" id="expiryPreview"><%= card.getExpiry_date() %></p>
          </div>
          <div>
            <p class="text-xs">CVV</p>
            <p class="font-semibold text-md"><%= card.getMaskedCvv() %></p>
          </div>
        </div>
      </div>

      <!-- Form Section -->
      <form action="${pageContext.request.contextPath}/paymentcard" method="post" class="bg-white p-6 rounded-2xl shadow-md space-y-5">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="<%= card.getCard_id() %>" />

        <div>
          <label class="block mb-1 font-medium text-gray-700">Card Holder Name</label>
          <input type="text" name="card_holder_name" value="<%= card.getCard_holder_name() %>" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300" oninput="updateCard('holder', this.value)" />
        </div>

        <div>
          <label class="block mb-1 font-medium text-gray-700">Card Number</label>
          <input type="text" value="<%= card.getMaskedCardNumber() %>" readonly class="w-full px-4 py-2 rounded-lg border border-gray-300 bg-gray-100 cursor-not-allowed" />
        </div>

        <div class="grid grid-cols-2 gap-4">
			<div>
			  <label class="block mb-1 font-medium text-gray-700">Expiry Date (MM/YY)</label>
			  <input 
			    type="text" 
			    name="expiry_date" 
			    value="<%= card.getExpiry_date() %>" 
			    maxlength="5"
			    required 
			    class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300" 
			    oninput="formatExpiry(this); updateCard('expiry', this.value)" 
			  />
			</div>
          <div>
            <label class="block mb-1 font-medium text-gray-700">CVV</label>
            <input type="password" value="<%= card.getMaskedCvv() %>" readonly class="w-full px-4 py-2 rounded-lg border border-gray-300 bg-gray-100 cursor-not-allowed" />
          </div>
        </div>

        <div>
          <label class="block mb-1 font-medium text-gray-700">Card Type</label>
          <input type="text" value="<%= card.getCard_type() %>" readonly class="w-full px-4 py-2 rounded-lg border border-gray-300 bg-gray-100 cursor-not-allowed" />
        </div>

        <div class="pt-4">
          <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-xl shadow-md transition">
            💾 Update Card
          </button>
        </div>
      </form>
    </div>
  </div>
</section>

<script>
  function updateCard(field, value) {
    if (field === 'holder') {
      document.getElementById('cardHolderPreview').innerText = value || 'FULL NAME';
    } else if (field === 'expiry') {
      document.getElementById('expiryPreview').innerText = value || 'MM/YY';
    }
  }

  function formatExpiry(input) {
    let value = input.value.replace(/[^\d]/g, '').substring(0, 4);

    if (value.length >= 3) {
      input.value = value.slice(0, 2) + '/' + value.slice(2, 4);
    } else {
      input.value = value;
    }
  }

  function validateExpiry() {
    const expiryInput = document.querySelector('input[name="expiry_date"]');
    const expiryValue = expiryInput.value.trim();
    const regex = /^(0[1-9]|1[0-2])\/\d{2}$/;

    if (!regex.test(expiryValue)) {
      alert("❌ Invalid expiry date format. Please use MM/YY.");
      return false;
    }

    const [month, year] = expiryValue.split('/').map(Number);
    const currentYear = new Date().getFullYear() % 100; // last 2 digits
    const currentMonth = new Date().getMonth() + 1;

    if (month < 1 || month > 12) {
      alert("❌ Expiry month must be between 01 and 12.");
      return false;
    }

    if (year < currentYear || (year === currentYear && month < currentMonth)) {
      alert("❌ Card has already expired.");
      return false;
    }

    return true;
  }

  document.querySelector("form").addEventListener("submit", function (e) {
    if (!validateExpiry()) {
      e.preventDefault();
    }
  });
</script>



<%@ include file="./partials/footer.jsp" %>
