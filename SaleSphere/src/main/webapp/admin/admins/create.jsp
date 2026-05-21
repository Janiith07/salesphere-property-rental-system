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
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

    * {
      font-family: 'Inter', sans-serif;
    }

    /* Smooth animations */
    .fade-in {
      animation: fadeIn 0.6s ease-out forwards;
    }

    .slide-up {
      animation: slideUp 0.5s ease-out forwards;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes slideUp {
      from { opacity: 0; transform: translateY(30px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes pulse {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.05); }
    }

    /* Glass effect */
    .glass {
      background: rgba(15, 23, 42, 0.85);
      backdrop-filter: blur(12px);
      border: 1px solid rgba(148, 163, 184, 0.1);
    }

    /* Input styling */
    .form-input {
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .form-input:focus {
      transform: translateY(-1px);
      box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
    }

    /* Button styling */
    .btn-primary {
      background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .btn-primary:before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s;
    }

    .btn-primary:hover:before {
      left: 100%;
    }

    .btn-primary:disabled {
      background: #374151;
      cursor: not-allowed;
    }

    .btn-primary:disabled:before {
      display: none;
    }

    /* Success indicators */
    .requirement-met {
      color: #10b981 !important;
    }

    .requirement-met .requirement-icon {
      background-color: #10b981;
      border-color: #10b981;
    }

    .requirement-not-met {
      color: #ef4444 !important;
    }

    .requirement-not-met .requirement-icon {
      background-color: transparent;
      border-color: #ef4444;
    }

    /* Loading spinner */
    .spinner {
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }

    /* Notification */
    .notification {
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 1000;
      transform: translateX(100%);
      transition: transform 0.3s ease;
    }

    .notification.show {
      transform: translateX(0);
    }
  </style>
</head>
<body class="bg-gradient-to-br from-slate-900 to-slate-800 text-gray-100 min-h-screen">

<!-- Notification -->
<div id="notification" class="notification">
  <div class="bg-green-600 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-3">
    <i class="fas fa-check-circle"></i>
    <span id="notificationText">Success!</span>
  </div>
</div>

<div class="flex min-h-screen">
  <!-- Sidebar -->
  <%@ include file="../partials/sidebar.jsp" %>

  <!-- Main Content -->
  <div class="flex-1 md:ml-60 flex flex-col">

    <!-- Header -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Content -->
    <main class="flex-1 p-6">
      <div class="max-w-4xl mx-auto fade-in">

        <!-- Page Header -->
        <div class="glass rounded-xl p-6 mb-8 shadow-xl">
          <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div class="flex items-center space-x-4">
              <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center">
                <i class="fas fa-user-plus text-white text-xl"></i>
              </div>
              <div>
                <h1 class="text-2xl font-bold text-white">Create New Admin</h1>
                <p class="text-gray-400 text-sm">Add a new administrator to the system</p>
              </div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/admin"
               class="inline-flex items-center space-x-2 text-blue-400 hover:text-blue-300 transition-colors duration-200 group">
              <i class="fas fa-arrow-left group-hover:-translate-x-1 transition-transform duration-200"></i>
              <span>Back to Admin List</span>
            </a>
          </div>
        </div>

        <!-- Form Card -->
        <div class="glass rounded-xl shadow-xl overflow-hidden slide-up">
          <div class="bg-gradient-to-r from-blue-600 to-indigo-600 p-4">
            <h2 class="text-lg font-semibold text-white flex items-center">
              <i class="fas fa-form mr-3"></i>
              Admin Information
            </h2>
          </div>

          <div class="p-8">
            <form id="adminForm" action="${pageContext.request.contextPath}/admin/admin?action=create" method="POST">

              <div class="grid md:grid-cols-2 gap-6 mb-8">

                <!-- Full Name -->
                <div class="space-y-2">
                  <label for="full_name" class="block text-sm font-medium text-gray-300">
                    <i class="fas fa-user mr-2 text-blue-400"></i>Full Name
                  </label>
                  <input type="text"
                         id="full_name"
                         name="full_name"
                         required
                         placeholder="Enter full name"
                         class="form-input w-full px-4 py-3 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
                </div>

                <!-- Email -->
                <div class="space-y-2">
                  <label for="email" class="block text-sm font-medium text-gray-300">
                    <i class="fas fa-envelope mr-2 text-blue-400"></i>Email Address
                  </label>
                  <input type="email"
                         id="email"
                         name="email"
                         required
                         placeholder="admin@example.com"
                         class="form-input w-full px-4 py-3 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
                </div>

                <!-- Phone -->
                <div class="space-y-2">
                  <label for="phone" class="block text-sm font-medium text-gray-300">
                    <i class="fas fa-phone mr-2 text-blue-400"></i>Phone Number
                  </label>
                  <input type="tel"
                         id="phone"
                         name="phone"
                         required
                         placeholder="07XXXXXXXX"
                         pattern="[0-9]{10}"
                         class="form-input w-full px-4 py-3 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
                </div>

                <!-- Role -->
                <div class="space-y-2">
                  <label for="role" class="block text-sm font-medium text-gray-300">
                    <i class="fas fa-user-tag mr-2 text-blue-400"></i>Role
                  </label>
                  <select id="role"
                          name="role"
                          required
                          class="form-input w-full px-4 py-3 bg-slate-700 border border-slate-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <option value="" disabled selected>Select Role</option>
                    <option value="Admin">Admin</option>
                    <option value="Landlord">Landlord</option>
                  </select>
                </div>
              </div>

              <!-- Password Section -->
              <div class="space-y-6 mb-8">
                <div class="flex items-center space-x-3">
                  <div class="w-8 h-8 bg-gradient-to-r from-red-500 to-pink-500 rounded-lg flex items-center justify-center">
                    <i class="fas fa-lock text-white text-sm"></i>
                  </div>
                  <h3 class="text-lg font-semibold text-white">Security</h3>
                </div>

                <div class="space-y-4">
                  <div class="space-y-2">
                    <label for="password" class="block text-sm font-medium text-gray-300">
                      <i class="fas fa-key mr-2 text-blue-400"></i>Password
                    </label>
                    <div class="relative">
                      <input type="password"
                             id="password"
                             name="password"
                             required
                             placeholder="Enter secure password"
                             class="form-input w-full px-4 py-3 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent pr-12" />
                      <button type="button"
                              id="togglePassword"
                              class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-white transition-colors">
                        <i class="fas fa-eye"></i>
                      </button>
                    </div>
                  </div>

                  <!-- Password Requirements -->
                  <div class="bg-slate-800 rounded-lg p-4 border border-slate-700">
                    <h4 class="text-sm font-medium text-gray-300 mb-3">Password Requirements:</h4>
                    <div class="grid md:grid-cols-2 gap-3">
                      <div id="lengthHint" class="requirement-not-met flex items-center space-x-2 text-sm transition-all duration-300">
                        <div class="requirement-icon w-4 h-4 rounded-full border-2 flex items-center justify-center">
                          <i class="fas fa-times text-xs"></i>
                        </div>
                        <span>At least 8 characters</span>
                      </div>
                      <div id="uppercaseHint" class="requirement-not-met flex items-center space-x-2 text-sm transition-all duration-300">
                        <div class="requirement-icon w-4 h-4 rounded-full border-2 flex items-center justify-center">
                          <i class="fas fa-times text-xs"></i>
                        </div>
                        <span>One uppercase letter</span>
                      </div>
                      <div id="lowercaseHint" class="requirement-not-met flex items-center space-x-2 text-sm transition-all duration-300">
                        <div class="requirement-icon w-4 h-4 rounded-full border-2 flex items-center justify-center">
                          <i class="fas fa-times text-xs"></i>
                        </div>
                        <span>One lowercase letter</span>
                      </div>
                      <div id="digitHint" class="requirement-not-met flex items-center space-x-2 text-sm transition-all duration-300">
                        <div class="requirement-icon w-4 h-4 rounded-full border-2 flex items-center justify-center">
                          <i class="fas fa-times text-xs"></i>
                        </div>
                        <span>One digit</span>
                      </div>
                    </div>

                    <!-- Strength Indicator -->
                    <div class="mt-4">
                      <div class="flex justify-between text-xs text-gray-400 mb-2">
                        <span>Password Strength</span>
                        <span id="strengthText">Weak</span>
                      </div>
                      <div class="w-full bg-slate-700 rounded-full h-2">
                        <div id="strengthBar" class="h-2 rounded-full transition-all duration-500 bg-red-500" style="width: 0%"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Submit Button -->
              <div class="border-t border-slate-700 pt-6">
                <button type="submit"
                        id="submitBtn"
                        disabled
                        class="btn-primary w-full py-3 px-6 text-white font-semibold rounded-lg transition-all duration-300 disabled:opacity-50">
                  <div class="flex items-center justify-center space-x-2">
                    <i id="submitIcon" class="fas fa-save"></i>
                    <span id="submitText">Create Admin</span>
                    <div id="loadingSpinner" class="hidden w-5 h-5 border-2 border-white border-t-transparent rounded-full spinner"></div>
                  </div>
                </button>
              </div>

            </form>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<script>
  // Elements
  const passwordInput = document.getElementById('password');
  const togglePassword = document.getElementById('togglePassword');
  const submitBtn = document.getElementById('submitBtn');
  const form = document.getElementById('adminForm');

  // Password requirements elements
  const requirements = {
    length: document.getElementById('lengthHint'),
    uppercase: document.getElementById('uppercaseHint'),
    lowercase: document.getElementById('lowercaseHint'),
    digit: document.getElementById('digitHint')
  };

  const strengthBar = document.getElementById('strengthBar');
  const strengthText = document.getElementById('strengthText');

  // Password toggle functionality
  togglePassword.addEventListener('click', function() {
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    this.querySelector('i').className = type === 'password' ? 'fas fa-eye' : 'fas fa-eye-slash';
  });

  // Password validation
  function validatePassword() {
    const password = passwordInput.value;

    const checks = {
      length: password.length >= 8,
      uppercase: /[A-Z]/.test(password),
      lowercase: /[a-z]/.test(password),
      digit: /\d/.test(password)
    };

    // Update each requirement
    Object.keys(checks).forEach(key => {
      const element = requirements[key];
      const icon = element.querySelector('i');

      if (checks[key]) {
        element.className = 'requirement-met flex items-center space-x-2 text-sm transition-all duration-300';
        icon.className = 'fas fa-check text-xs text-white';
      } else {
        element.className = 'requirement-not-met flex items-center space-x-2 text-sm transition-all duration-300';
        icon.className = 'fas fa-times text-xs';
      }
    });

    // Calculate strength
    const strength = Object.values(checks).filter(Boolean).length;
    const percentage = (strength / 4) * 100;

    strengthBar.style.width = percentage + '%';

    if (percentage === 0) {
      strengthBar.className = 'h-2 rounded-full transition-all duration-500 bg-gray-500';
      strengthText.textContent = 'None';
    } else if (percentage <= 25) {
      strengthBar.className = 'h-2 rounded-full transition-all duration-500 bg-red-500';
      strengthText.textContent = 'Weak';
    } else if (percentage <= 50) {
      strengthBar.className = 'h-2 rounded-full transition-all duration-500 bg-orange-500';
      strengthText.textContent = 'Fair';
    } else if (percentage <= 75) {
      strengthBar.className = 'h-2 rounded-full transition-all duration-500 bg-yellow-500';
      strengthText.textContent = 'Good';
    } else {
      strengthBar.className = 'h-2 rounded-full transition-all duration-500 bg-green-500';
      strengthText.textContent = 'Strong';
    }

    // Enable/disable submit button
    const allValid = Object.values(checks).every(Boolean);
    submitBtn.disabled = !allValid;

    if (allValid) {
      submitBtn.classList.remove('opacity-50');
      submitBtn.classList.add('hover:bg-blue-600');
    } else {
      submitBtn.classList.add('opacity-50');
      submitBtn.classList.remove('hover:bg-blue-600');
    }
  }

  // Form submission
  form.addEventListener('submit', function(e) {
    const submitIcon = document.getElementById('submitIcon');
    const submitText = document.getElementById('submitText');
    const loadingSpinner = document.getElementById('loadingSpinner');

    // Show loading state
    submitIcon.classList.add('hidden');
    submitText.textContent = 'Creating...';
    loadingSpinner.classList.remove('hidden');
    submitBtn.disabled = true;
  });

  // Notification function
  function showNotification(message, type = 'success') {
    const notification = document.getElementById('notification');
    const notificationText = document.getElementById('notificationText');

    notificationText.textContent = message;

    if (type === 'success') {
      notification.querySelector('div').className = 'bg-green-600 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-3';
      notification.querySelector('i').className = 'fas fa-check-circle';
    } else {
      notification.querySelector('div').className = 'bg-red-600 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-3';
      notification.querySelector('i').className = 'fas fa-exclamation-circle';
    }

    notification.classList.add('show');

    setTimeout(() => {
      notification.classList.remove('show');
    }, 4000);
  }

  // Event listeners
  passwordInput.addEventListener('input', validatePassword);

  // Initialize
  validatePassword();

  // Check for success/error messages from server
  <c:if test="${not empty sessionScope.successMessage}">
  showNotification('${sessionScope.successMessage}', 'success');
  <c:remove var="successMessage" scope="session"/>
  </c:if>

  <c:if test="${not empty sessionScope.errorMessage}">
  showNotification('${sessionScope.errorMessage}', 'error');
  <c:remove var="errorMessage" scope="session"/>
  </c:if>
</script>

</body>
</html>