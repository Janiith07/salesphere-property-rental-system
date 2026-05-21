<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <title>User Settings | RentSphere</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-white font-sans">

<!-- Header -->
<%@ include file="./partials/sessionheader.jsp" %>

<!-- Page Layout -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 flex flex-col lg:flex-row gap-8">

  <!-- Sidebar -->
  <%@ include file="./partials/sidebar.jsp" %>

  <!-- Main Content -->
  <main class="flex-1 bg-slate-800 border border-slate-700 rounded-xl p-8 shadow-lg">
    <h1 class="text-3xl font-bold text-teal-400 mb-8">Edit Your Profile</h1>

    <!-- Success & Error Messages -->
    <c:if test="${not empty success}">
      <div class="mb-6 p-4 bg-green-900/30 text-green-300 border border-green-600 rounded">
        <i class="fas fa-check-circle mr-2"></i> ${success}
      </div>
    </c:if>

    <c:if test="${not empty error}">
      <div class="mb-6 p-4 bg-red-900/30 text-red-300 border border-red-600 rounded">
        <i class="fas fa-exclamation-circle mr-2"></i> ${error}
      </div>
    </c:if>

    <form action="settings" method="POST" class="space-y-6">

      <!-- Full Name -->
      <div>
        <label for="full_name" class="block text-sm font-medium text-slate-300 mb-1">Full Name</label>
        <input type="text" id="full_name" name="full_name" required
               value="${user.fullName}"
               class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-yellow-500"/>
      </div>

      <!-- Email -->
      <div>
        <label for="email" class="block text-sm font-medium text-slate-300 mb-1">Email</label>
        <input type="email" id="email" name="email" required
               value="${user.email}"
               class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-yellow-500"/>
      </div>

      <!-- Phone -->
      <div>
        <label for="phone" class="block text-sm font-medium text-slate-300 mb-1">Phone</label>
        <input type="number" id="phone" name="phone" required
               value="${user.phone}"
               class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-yellow-500"/>
      </div>

      <!-- NIC Number -->
      <div>
        <label for="nic_number" class="block text-sm font-medium text-slate-300 mb-1">NIC Number</label>
        <input type="text" id="nic_number" name="nic_number" required
               value="${user.nicNumber}"
               class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-yellow-500"/>
      </div>

      <!-- Address -->
      <div>
        <label for="address" class="block text-sm font-medium text-slate-300 mb-1">Address</label>
        <textarea id="address" name="address" rows="3" required
                  class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-yellow-500">${user.address}</textarea>
      </div>

      <!-- Password -->
      <div>
        <label for="password" class="block text-sm font-medium text-slate-300 mb-1">Password</label>
        <div class="relative">
          <input type="password" id="password" name="password" required
                 value="${user.password}"
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-yellow-500"/>
          <i id="togglePassword" class="fas fa-eye absolute top-1/2 right-3 transform -translate-y-1/2 text-gray-400 cursor-pointer"></i>
        </div>
        <div class="mt-2 text-sm text-red-400 space-y-1">
          <p id="lengthHint">• At least 8 characters</p>
          <p id="uppercaseHint">• At least one uppercase letter</p>
          <p id="lowercaseHint">• At least one lowercase letter</p>
          <p id="digitHint">• At least one digit</p>
        </div>
      </div>

      <!-- Submit Button -->
      <div>
        <button type="submit" id="submitBtn"
                class="w-full py-2 px-4 bg-yellow-500 text-slate-900 font-semibold rounded-lg transition opacity-50 cursor-not-allowed">
          <i class="fas fa-save mr-2"></i> Save Changes
        </button>
      </div>
    </form>
  </main>
</div>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<!-- JS: Password Validation & Toggle -->
<script>
  const passwordInput = document.getElementById("password");
  const lengthHint = document.getElementById("lengthHint");
  const uppercaseHint = document.getElementById("uppercaseHint");
  const lowercaseHint = document.getElementById("lowercaseHint");
  const digitHint = document.getElementById("digitHint");
  const submitBtn = document.getElementById("submitBtn");
  const toggleBtn = document.getElementById("togglePassword");

  function validatePassword() {
    const val = passwordInput.value;
    const hasLength = val.length >= 8;
    const hasUpper = /[A-Z]/.test(val);
    const hasLower = /[a-z]/.test(val);
    const hasDigit = /\d/.test(val);

    lengthHint.className = hasLength ? "text-green-400" : "text-red-400";
    uppercaseHint.className = hasUpper ? "text-green-400" : "text-red-400";
    lowercaseHint.className = hasLower ? "text-green-400" : "text-red-400";
    digitHint.className = hasDigit ? "text-green-400" : "text-red-400";

    const isValid = hasLength && hasUpper && hasLower && hasDigit;
    submitBtn.disabled = !isValid;
    submitBtn.classList.toggle("opacity-50", !isValid);
    submitBtn.classList.toggle("cursor-not-allowed", !isValid);
    submitBtn.classList.toggle("hover:bg-yellow-600", isValid);
  }

  passwordInput.addEventListener("input", validatePassword);
  validatePassword();

  toggleBtn.addEventListener("click", () => {
    const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", type);
    toggleBtn.classList.toggle("fa-eye");
    toggleBtn.classList.toggle("fa-eye-slash");
  });
</script>
</body>
</html>