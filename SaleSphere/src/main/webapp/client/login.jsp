<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login | RentSphere</title>
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
      <h1 class="text-4xl font-bold text-teal-400 mb-4">Welcome Back</h1>
      <p class="text-lg text-slate-300 max-w-2xl mx-auto">Log in to manage your properties, bookings, and more.</p>
    </div>
  </section>

  <!-- Login Box -->
  <section class="py-16">
    <div class="max-w-md mx-auto bg-slate-800 border border-slate-700 p-10 rounded-xl shadow-2xl">
      <div class="text-center mb-6">
        <h2 class="text-2xl font-bold text-teal-400">Sign In</h2>
        <p class="text-sm text-slate-400">Access your SaleSphere account</p>
      </div>

      <!-- Error Message -->
      <c:if test="${not empty error}">
        <div class="mb-4 p-4 text-sm text-red-400 bg-red-900/20 border border-red-500/40 rounded-lg">
          <i class="fas fa-exclamation-circle mr-2"></i> ${error}
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-6">
        <!-- Email -->
        <div>
          <label for="email" class="block text-sm font-medium text-slate-300 mb-1">Email</label>
          <input type="email" id="email" name="email" required
                 class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 text-white"
                 placeholder="lakshitha@example.com"
                 value="${email != null ? email : ''}">
        </div>

        <!-- Password -->
        <div>
          <label for="password" class="block text-sm font-medium text-slate-300 mb-1">Password</label>
          <div class="relative">
            <input type="password" id="password" name="password" required
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 text-white"
                   placeholder="••••••••">
            <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-teal-400">
              <i class="fas fa-eye"></i>
            </button>
          </div>
        </div>

        <!-- Forgot -->
        <div class="text-right">
          <a href="#" class="text-sm text-slate-400 hover:text-white transition">Forgot password?</a>
        </div>

        <!-- Submit -->
        <button type="submit"
                class="w-full flex items-center justify-center gap-2 px-4 py-2 bg-teal-500 hover:bg-teal-600 text-white text-sm font-semibold rounded-lg transition">
          <i class="fas fa-sign-in-alt"></i> Sign In
        </button>
      </form>
    </div>
  </section>
</main>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<!-- JS for Password Toggle -->
<script>
  const passwordInput = document.getElementById("password");
  const togglePassword = document.getElementById("togglePassword");

  togglePassword.addEventListener("click", () => {
    const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", type);
    togglePassword.querySelector("i").classList.toggle("fa-eye");
    togglePassword.querySelector("i").classList.toggle("fa-eye-slash");
  });
</script>
</body>
</html>