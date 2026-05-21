<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Register | RentSphere</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-white font-sans">

<!-- Header -->
<%@ include file="./partials/header.jsp" %>

<main class="border-b border-slate-700">
  <!-- Hero -->
  <section class="relative py-20 bg-slate-800 shadow-inner">
    <div class="container mx-auto px-6 text-center">
      <h1 class="text-4xl font-bold text-teal-400 mb-4">Create Your SaleSphere Account</h1>
      <p class="text-lg text-slate-300 max-w-2xl mx-auto">Book, rent, and manage properties with ease.</p>
    </div>
  </section>

  <!-- Form -->
  <section class="py-16">
    <div class="max-w-xl mx-auto bg-slate-800 border border-slate-700 p-10 rounded-xl shadow-2xl">
      <div class="text-center mb-6">
        <h2 class="text-2xl font-bold text-teal-400">Register</h2>
        <p class="text-sm text-slate-400">Join the SaleSphere community</p>
      </div>

      <!-- Error Message -->
      <c:if test="${not empty error}">
        <div class="mb-4 p-4 text-sm text-red-400 bg-red-900/20 border border-red-500/40 rounded-lg">
          <i class="fas fa-exclamation-circle mr-2"></i> ${error}
        </div>
      </c:if>

      <!-- Success Message -->
      <c:if test="${not empty success}">
        <div class="mb-4 p-4 text-sm text-green-400 bg-green-900/20 border border-green-500/40 rounded-lg">
          <i class="fas fa-check-circle mr-2"></i> ${success}
        </div>
      </c:if>

      <form action="register" method="POST" class="space-y-6" autocomplete="off">
        <!-- Full Name -->
        <div>
          <label for="full_name" class="block text-sm font-medium text-slate-300 mb-1">Full Name</label>
          <input type="text" id="full_name" name="full_name" required
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-teal-500"
                 placeholder="John Doe" />
        </div>

        <!-- Email -->
        <div>
          <label for="email" class="block text-sm font-medium text-slate-300 mb-1">Email</label>
          <input type="email" id="email" name="email" required
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-teal-500"
                 placeholder="lakshitha@example.com" />
        </div>

        <!-- Phone -->
        <div>
          <label for="phone" class="block text-sm font-medium text-slate-300 mb-1">Phone</label>
          <input type="number" id="phone" name="phone" required
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-teal-500"
                 placeholder="07XXXXXXXX" />
        </div>

        <!-- NIC -->
        <div>
          <label for="nic_number" class="block text-sm font-medium text-slate-300 mb-1">NIC Number</label>
          <input type="text" id="nic_number" name="nic_number" required
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-teal-500"
                 placeholder="200012345678 / 123456789V" />
        </div>

        <!-- Address -->
        <div>
          <label for="address" class="block text-sm font-medium text-slate-300 mb-1">Address</label>
          <input type="text" id="address" name="address" required
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-teal-500"
                 placeholder="123 Main Street, Colombo" />
        </div>

        <!-- Password -->
        <div>
          <label for="password" class="block text-sm font-medium text-slate-300 mb-1">Password</label>
          <div class="relative">
            <input type="password" id="password" name="password" required
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white focus:ring-2 focus:ring-teal-500"
                   placeholder="••••••••" />
            <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-teal-400">
              <i class="fas fa-eye"></i>
            </button>
          </div>
          <div class="mt-2 text-sm space-y-1">
            <p id="lengthHint" class="text-red-500">• At least 8 characters</p>
            <p id="uppercaseHint" class="text-red-500">• At least one uppercase letter</p>
            <p id="lowercaseHint" class="text-red-500">• At least one lowercase letter</p>
            <p id="digitHint" class="text-red-500">• At least one digit</p>
          </div>
        </div>

        <!-- Submit Button -->
        <button id="submitBtn" type="submit" disabled
                class="w-full py-2 px-4 bg-teal-500 text-slate-900 font-semibold rounded-lg transition opacity-50 cursor-not-allowed">
          <i class="fas fa-user-plus mr-2"></i> Register
        </button>
      </form>
    </div>
  </section>
</main>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<!-- JS for Password Validation and Toggle -->
<script>
  const passwordInput = document.getElementById("password");
  const togglePassword = document.getElementById("togglePassword");
  const lengthHint = document.getElementById("lengthHint");
  const uppercaseHint = document.getElementById("uppercaseHint");
  const lowercaseHint = document.getElementById("lowercaseHint");
  const digitHint = document.getElementById("digitHint");
  const submitBtn = document.getElementById("submitBtn");

  function validatePassword() {
    const val = passwordInput.value;
    const hasLength = val.length >= 8;
    const hasUpper = /[A-Z]/.test(val);
    const hasLower = /[a-z]/.test(val);
    const hasDigit = /\d/.test(val);

    lengthHint.className = hasLength ? "text-green-500" : "text-red-500";
    uppercaseHint.className = hasUpper ? "text-green-500" : "text-red-500";
    lowercaseHint.className = hasLower ? "text-green-500" : "text-red-500";
    digitHint.className = hasDigit ? "text-green-500" : "text-red-500";

    const isValid = hasLength && hasUpper && hasLower && hasDigit;
    submitBtn.disabled = !isValid;
    submitBtn.classList.toggle("opacity-50", !isValid);
    submitBtn.classList.toggle("cursor-not-allowed", !isValid);
    submitBtn.classList.toggle("hover:bg-teal-600", isValid);
  }

  togglePassword.addEventListener("click", () => {
    const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", type);
    togglePassword.querySelector("i").classList.toggle("fa-eye");
    togglePassword.querySelector("i").classList.toggle("fa-eye-slash");
  });

  passwordInput.addEventListener("input", validatePassword);
</script>
</body>
</html>