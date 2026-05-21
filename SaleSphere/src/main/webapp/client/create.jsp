<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Add Admin</title>
  <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-gray-100 min-h-screen flex">


  <!-- Main Content -->
  <div class="flex-1 md:ml-30 flex flex-col min-h-screen">

    <!-- Topbar -->
    <%@ include file="./partials/header.jsp" %>

    <!-- Form Content -->
    <main class="flex-1 p-6 overflow-y-auto">
      <div class="mx-auto bg-slate-800 border border-slate-700 rounded-2xl shadow-xl p-8 space-y-6">

        <div class="flex justify-between items-center">
          <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-user-plus mr-2"></i> New Seller</h3>
          <a href="${pageContext.request.contextPath}/admin/login" class="text-sm text-blue-400 hover:underline">
            ← Are u you a Seller? Login Here
          </a>
        </div>

        <form action="${pageContext.request.contextPath}/seller/register" method="POST" class="grid md:grid-cols-2 gap-6">
          <!-- Full Name -->
          <div>
            <label class="block text-sm mb-1" for="full_name">Full Name</label>
            <input type="text" id="full_name" name="full_name" required
                   placeholder="Enter full name"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Email -->
          <div>
            <label class="block text-sm mb-1" for="email">Email</label>
            <input type="email" id="email" name="email" required
                   placeholder="seller@example.com"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Phone -->
          <div>
            <label class="block text-sm mb-1" for="phone">Phone</label>
            <input type="number" id="phone" name="phone" required
                   placeholder="07XXXXXXXX"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Role -->
          <div>
            <label class="block text-sm mb-1" for="role">Role</label>
            <select id="role" name="role" required
                    class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
              <option value="" disabled selected>Select Role</option>
              <option value="Landlord">Landlord</option>
            </select>
          </div>

          <!-- Password -->
          <div class="md:col-span-2">
            <label class="block text-sm mb-1" for="password">Password</label>
            <input type="password" id="password" name="password" required
                   placeholder="Enter password"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <div class="mt-2 text-sm space-y-1">
              <p id="lengthHint" class="text-red-500">• At least 8 characters</p>
              <p id="uppercaseHint" class="text-red-500">• At least one uppercase letter</p>
              <p id="lowercaseHint" class="text-red-500">• At least one lowercase letter</p>
              <p id="digitHint" class="text-red-500">• At least one digit</p>
            </div>
          </div>

          <!-- Submit -->
          <div class="md:col-span-2">
            <button id="submitBtn" type="submit" disabled
                    class="w-full py-2 px-4 bg-blue-500 text-white font-semibold rounded-lg transition opacity-50 cursor-not-allowed">
              <i class="fas fa-save mr-2"></i> Save Seller
            </button>
          </div>
        </form>
      </div>
    </main>
  </div>

  <!-- Live Password Validation -->
  <script>
    const passwordInput = document.getElementById("password");
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
      submitBtn.classList.toggle("hover:bg-blue-600", isValid);
    }

    passwordInput.addEventListener("input", validatePassword);
  </script>

</body>
</html>