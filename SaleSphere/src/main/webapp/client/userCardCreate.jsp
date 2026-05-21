<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./partials/sessionheader.jsp" %>

<section class="min-h-screen bg-gray-100 py-10 px-4 sm:px-8">
  <div class="max-w-5xl mx-auto">
    <h1 class="text-3xl font-bold text-center mb-8 text-gray-800">Add a New Payment Card</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
      <!-- Card Preview -->
      <div class="relative w-full h-64 rounded-2xl shadow-2xl overflow-hidden text-white p-6 transition-all duration-500 ease-in-out" id="cardPreview" style="background: linear-gradient(135deg, #1e3a8a, #3b82f6);">
        <div class="flex justify-between text-sm font-semibold tracking-wider mb-4">
          <span id="cardTypePreview">VISA</span>
          <span id="cardIdPreview">#1234</span>
        </div>
        <div class="text-xl font-mono tracking-widest mb-6" id="cardNumberPreview">•••• •••• •••• ••••</div>
        <div class="mb-2">
          <p class="text-xs">Card Holder</p>
          <p class="font-semibold text-lg" id="cardHolderPreview">FULL NAME</p>
        </div>
        <div class="flex justify-between mt-4">
          <div>
            <p class="text-xs">Expiry</p>
            <p class="font-semibold text-md" id="expiryPreview">MM/YY</p>
          </div>
          <div>
            <p class="text-xs">CVV</p>
            <p class="font-semibold text-md">•••</p>
          </div>
        </div>
      </div>

      <!-- Form Section -->
      <form action="${pageContext.request.contextPath}/paymentcard" method="post" onsubmit="return validateExpiry()" class="bg-white p-6 rounded-2xl shadow-md space-y-5">
        <input type="hidden" name="action" value="create" />

        <div>
          <label class="block mb-1 font-medium text-gray-700">Card Holder Name</label>
          <input type="text" name="card_holder_name" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300" oninput="updateCard('holder', this.value)" />
        </div>

        <div>
          <label class="block mb-1 font-medium text-gray-700">Card Number</label>
          <input type="text" name="card_number" maxlength="16" required pattern="\d{16}" class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300" oninput="updateCard('number', this.value)" />
        </div>

        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block mb-1 font-medium text-gray-700">Expiry Date (MM/YY)</label>
            <input 
              type="text" 
              name="expiry_date" 
              placeholder="MM/YY" 
              maxlength="5" 
              required 
              class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300" 
              oninput="formatExpiry(this); updateCard('expiry', this.value)" 
            />
          </div>

          <div>
            <label class="block mb-1 font-medium text-gray-700">CVV</label>
            <input type="password" name="cvv" maxlength="4" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300" />
          </div>
        </div>

        <div>
          <label class="block mb-1 font-medium text-gray-700">Card Type</label>
          <select name="card_type" onchange="updateCardType(this.value)" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring focus:ring-blue-300">
            <option value="Visa">Visa</option>
            <option value="MasterCard">MasterCard</option>
          </select>
        </div>

        <div class="pt-4">
          <button type="submit" class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-3 px-6 rounded-xl shadow-md transition">
            💾 Save Card
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
    } else if (field === 'number') {
      const cleaned = value.replace(/\D/g, '').padEnd(16, '•');
      const formatted = cleaned.match(/.{1,4}/g)?.join(' ') || '•••• •••• •••• ••••';
      document.getElementById('cardNumberPreview').innerText = formatted;
    } else if (field === 'expiry') {
      document.getElementById('expiryPreview').innerText = value || 'MM/YY';
    }
  }

  function updateCardType(type) {
    const preview = document.getElementById('cardPreview');
    const typeText = document.getElementById('cardTypePreview');

    if (type === 'Visa') {
      preview.style.background = 'linear-gradient(135deg, #1e3a8a, #3b82f6)';
      typeText.innerText = 'VISA';
    } else if (type === 'MasterCard') {
      preview.style.background = 'linear-gradient(135deg, #991b1b, #dc2626)';
      typeText.innerText = 'MasterCard';
    }
  }

  function formatExpiry(input) {
    let value = input.value.replace(/[^\d]/g, '');
    if (value.length >= 3) {
      input.value = value.slice(0, 2) + '/' + value.slice(2, 4);
    } else {
      input.value = value;
    }
  }

  function validateExpiry() {
    const input = document.querySelector('input[name="expiry_date"]');
    const value = input.value.trim();
    const regex = /^(0[1-9]|1[0-2])\/\d{2}$/;

    if (!regex.test(value)) {
      alert("❌ Please enter expiry date in MM/YY format.");
      return false;
    }

    const [month, year] = value.split('/').map(Number);
    const current = new Date();
    const currentYear = current.getFullYear() % 100;
    const currentMonth = current.getMonth() + 1;

    if (year < currentYear || (year === currentYear && month < currentMonth)) {
      alert("❌ This card has already expired.");
      return false;
    }

    return true;
  }
</script>

<%@ include file="./partials/footer.jsp" %>
