
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>RentSphere | Seller Registration</title>
  <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
      background: #0f172a;
      color: #f1f5f9;
      min-height: 100vh;
      overflow-x: hidden;
    }

    .container {
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 1rem;
      position: relative;
      z-index: 10;
    }

    .floating-bg {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      overflow: hidden;
      z-index: 1;
      pointer-events: none;
    }

    .floating-shape {
      position: absolute;
      border-radius: 50%;
      opacity: 0.1;
      animation: float 8s ease-in-out infinite;
    }

    .shape1 {
      width: 200px;
      height: 200px;
      background: linear-gradient(45deg, #3b82f6, #8b5cf6);
      top: 20%;
      left: 10%;
      animation-delay: -2s;
    }

    .shape2 {
      width: 150px;
      height: 150px;
      background: linear-gradient(45deg, #06b6d4, #3b82f6);
      bottom: 20%;
      right: 15%;
      animation-delay: -4s;
    }

    .grid-bg {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.15) 1px, transparent 0);
      background-size: 50px 50px;
      opacity: 0.2;
      z-index: 2;
      pointer-events: none;
    }

    .main-content {
      width: 100%;
      max-width: 600px;
      position: relative;
      z-index: 10;
      animation: fadeInUp 0.8s ease-out;
    }

    .header-section {
      text-align: center;
      margin-bottom: 2rem;
      animation: slideDown 0.6s ease-out;
    }

    .logo-icon {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 4rem;
      height: 4rem;
      background: #3b82f6;
      border-radius: 50%;
      margin-bottom: 1rem;
      animation: pulse 3s infinite;
    }

    .main-title {
      font-size: 2.5rem;
      font-weight: 700;
      background: linear-gradient(135deg, #60a5fa, #a78bfa);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-bottom: 0.5rem;
    }

    .subtitle {
      color: #94a3b8;
      font-size: 1.125rem;
    }

    .form-container {
      background: rgba(30, 41, 59, 0.8);
      backdrop-filter: blur(12px);
      border: 1px solid rgba(148, 163, 184, 0.1);
      border-radius: 1.5rem;
      padding: 2rem;
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
      animation: slideUp 0.6s ease-out 0.2s both;
    }

    .form-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .form-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: #60a5fa;
    }

    .login-link {
      color: #60a5fa;
      text-decoration: none;
      font-size: 0.875rem;
      transition: all 0.3s ease;
    }

    .login-link:hover {
      color: #93c5fd;
      text-decoration: underline;
    }

    .form-group {
      margin-bottom: 1.5rem;
      animation: slideUp 0.6s ease-out both;
    }

    .form-group:nth-child(1) { animation-delay: 0.3s; }
    .form-group:nth-child(2) { animation-delay: 0.4s; }
    .form-group:nth-child(3) { animation-delay: 0.5s; }
    .form-group:nth-child(4) { animation-delay: 0.6s; }
    .form-group:nth-child(5) { animation-delay: 0.7s; }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.5rem;
    }

    @media (max-width: 768px) {
      .form-row {
        grid-template-columns: 1fr;
      }

      .form-header {
        flex-direction: column;
        text-align: center;
      }
    }

    .form-label {
      display: block;
      font-size: 0.875rem;
      font-weight: 500;
      color: #cbd5e1;
      margin-bottom: 0.5rem;
    }

    .form-input {
      width: 100%;
      padding: 0.75rem 1rem;
      background: rgba(51, 65, 85, 0.5);
      border: 1px solid #475569;
      border-radius: 0.75rem;
      color: #f1f5f9;
      font-size: 0.875rem;
      transition: all 0.3s ease;
    }

    .form-input::placeholder {
      color: #94a3b8;
    }

    .form-input:focus {
      outline: none;
      border-color: #3b82f6;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
      transform: translateY(-2px);
    }

    .password-container {
      position: relative;
    }

    .password-toggle {
      position: absolute;
      right: 0.75rem;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      color: #94a3b8;
      cursor: pointer;
      transition: color 0.3s ease;
    }

    .password-toggle:hover {
      color: #cbd5e1;
    }

    .strength-container {
      margin-top: 0.75rem;
    }

    .strength-bar-container {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-bottom: 0.5rem;
    }

    .strength-bar {
      flex: 1;
      height: 0.5rem;
      background: #475569;
      border-radius: 0.25rem;
      overflow: hidden;
    }

    .strength-fill {
      height: 100%;
      transition: all 0.3s ease;
      border-radius: 0.25rem;
    }

    .strength-text {
      font-size: 0.75rem;
      font-weight: 500;
    }

    .checks-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 0.5rem;
      font-size: 0.75rem;
    }

    .check-item {
      display: flex;
      align-items: center;
      gap: 0.25rem;
      transition: color 0.3s ease;
    }

    .submit-btn {
      width: 100%;
      padding: 1rem 1.5rem;
      background: linear-gradient(135deg, #667eea, #764ba2);
      color: white;
      border: none;
      border-radius: 0.75rem;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
      animation: slideUp 0.6s ease-out 0.8s both;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 20px 40px rgba(102, 126, 234, 0.4);
    }

    .submit-btn:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
    }

    .terms-text {
      text-align: center;
      font-size: 0.75rem;
      color: #94a3b8;
      margin-top: 1rem;
      animation: slideUp 0.6s ease-out 0.9s both;
    }

    .terms-link {
      color: #60a5fa;
      text-decoration: none;
    }

    .terms-link:hover {
      text-decoration: underline;
    }

    .message {
      margin-top: 1.5rem;
      padding: 1rem;
      border-radius: 0.75rem;
      backdrop-filter: blur(8px);
      animation: slideUp 0.6s ease-out;
    }

    .error-message {
      background: rgba(239, 68, 68, 0.2);
      border: 1px solid rgba(239, 68, 68, 0.5);
      color: #fca5a5;
    }

    .success-message {
      background: rgba(34, 197, 94, 0.2);
      border: 1px solid rgba(34, 197, 94, 0.5);
      color: #86efac;
    }

    .message-content {
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    /* Animations */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(40px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes slideDown {
      from {
        opacity: 0;
        transform: translateY(-30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes float {
      0%, 100% { transform: translateY(0px); }
      50% { transform: translateY(-10px); }
    }

    @keyframes pulse {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.05); }
    }
  </style>
</head>

<body>
<!-- Header -->
<%@ include file="./partials/header.jsp" %>

<!-- Floating Background -->
<div class="floating-bg">
  <div class="floating-shape shape1"></div>
  <div class="floating-shape shape2"></div>
</div>

<!-- Background Grid -->
<div class="grid-bg"></div>
<!-- Main Container -->
<div class="container">
  <div class="main-content">

    <!-- Header Section -->
    <div class="header-section">
      <div class="logo-icon">
        <i class="fas fa-store" style="font-size: 1.5rem; color: white;"></i>
      </div>
      <h1 class="main-title">Join SaleSphere</h1>
      <p class="subtitle">Start your journey as a seller today</p>
    </div>

    <!-- Registration Form -->
    <div class="form-container">

      <!-- Form Header -->
      <div class="form-header">
        <h2 class="form-title">
          <i class="fas fa-user-plus" style="margin-right: 0.75rem;"></i>
          Seller Registration
        </h2>
        <a href="${pageContext.request.contextPath}/admin/login" class="login-link">
          <i class="fas fa-sign-in-alt" style="margin-right: 0.25rem;"></i>
          Already a seller? Login
        </a>
      </div>

      <!-- Registration Form -->
      <form action="${pageContext.request.contextPath}/seller/register" method="post">

        <!-- Full Name -->
        <div class="form-group">
          <label for="full_name" class="form-label">
            <i class="fas fa-user" style="margin-right: 0.5rem;"></i>Full Name
          </label>
          <input type="text"
                 id="full_name"
                 name="full_name"
                 required
                 placeholder="Enter your full name"
                 class="form-input">
        </div>

        <!-- Email -->
        <div class="form-group">
          <label for="email" class="form-label">
            <i class="fas fa-envelope" style="margin-right: 0.5rem;"></i>Email Address
          </label>
          <input type="email"
                 id="email"
                 name="email"
                 required
                 placeholder="seller@example.com"
                 class="form-input">
        </div>

        <!-- Phone and Role Row -->
        <div class="form-group">
          <div class="form-row">
            <!-- Phone -->
            <div>
              <label for="phone" class="form-label">
                <i class="fas fa-phone" style="margin-right: 0.5rem;"></i>Phone Number
              </label>
              <input type="text"
                     id="phone"
                     name="phone"
                     required
                     placeholder="07XXXXXXXX"
                     class="form-input">
            </div>

            <!-- Role -->
            <div>
              <label for="role" class="form-label">
                <i class="fas fa-briefcase" style="margin-right: 0.5rem;"></i>Role
              </label>
              <select id="role"
                      name="role"
                      required
                      class="form-input">
                <option value="" disabled selected>Select your role</option>
                <option value="Landlord">Landlord</option>
              </select>
            </div>
          </div>
        </div>

        <!-- Password -->
        <div class="form-group">
          <label for="password" class="form-label">
            <i class="fas fa-lock" style="margin-right: 0.5rem;"></i>Password
          </label>
          <div class="password-container">
            <input type="password"
                   id="password"
                   name="password"
                   required
                   placeholder="Create a strong password"
                   class="form-input"
                   style="padding-right: 3rem;">
            <button type="button" class="password-toggle" onclick="togglePassword()">
              <i id="passwordToggle" class="fas fa-eye"></i>
            </button>
          </div>

          <!-- Password Strength Indicator -->
          <div class="strength-container">
            <div class="strength-bar-container">
              <div class="strength-bar">
                <div id="strengthFill" class="strength-fill"></div>
              </div>
              <span id="strengthText" class="strength-text" style="color: #94a3b8;">Weak</span>
            </div>
            <div class="checks-grid">
              <div id="lengthCheck" class="check-item" style="color: #ef4444;">
                <i class="fas fa-times"></i>At least 8 characters
              </div>
              <div id="caseCheck" class="check-item" style="color: #ef4444;">
                <i class="fas fa-times"></i>Upper & lowercase
              </div>
              <div id="numberCheck" class="check-item" style="color: #ef4444;">
                <i class="fas fa-times"></i>At least one number
              </div>
              <div id="specialCheck" class="check-item" style="color: #ef4444;">
                <i class="fas fa-times"></i>Special character
              </div>
            </div>
          </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" id="submitBtn" class="submit-btn">
          <i class="fas fa-rocket" style="margin-right: 0.5rem;"></i>
          Start Your Journey
        </button>

        <!-- Terms and Privacy -->
        <div class="terms-text">
          By registering, you agree to our
          <a href="#" class="terms-link">Terms of Service</a> and
          <a href="#" class="terms-link">Privacy Policy</a>
        </div>

      </form>
    </div>

    <!-- Status Messages -->
    <c:if test="${not empty error}">
      <div class="message error-message">
        <div class="message-content">
          <i class="fas fa-exclamation-circle"></i>
          <span>${error}</span>
        </div>
      </div>
    </c:if>

    <c:if test="${not empty success}">
      <div class="message success-message">
        <div class="message-content">
          <i class="fas fa-check-circle"></i>
          <span>${success}</span>
        </div>
      </div>
    </c:if>

  </div>
</div>

<!-- JavaScript -->
<script>
  // Toggle password visibility
  function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.getElementById('passwordToggle');

    if (passwordInput.type === 'password') {
      passwordInput.type = 'text';
      toggleIcon.className = 'fas fa-eye-slash';
    } else {
      passwordInput.type = 'password';
      toggleIcon.className = 'fas fa-eye';
    }
  }

  // Password strength checker
  function checkPasswordStrength(password) {
    const checks = {
      length: password.length >= 8,
      case: /(?=.*[a-z])(?=.*[A-Z])/.test(password),
      number: /(?=.*\d)/.test(password),
      special: /(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?])/.test(password)
    };

    // Update visual indicators
    updateCheck('lengthCheck', checks.length);
    updateCheck('caseCheck', checks.case);
    updateCheck('numberCheck', checks.number);
    updateCheck('specialCheck', checks.special);

    // Calculate strength
    let strength = Object.values(checks).filter(Boolean).length;

    // Update strength bar
    const strengthFill = document.getElementById('strengthFill');
    const strengthText = document.getElementById('strengthText');

    const strengthLevels = [
      { width: '25%', color: '#ef4444', text: 'Weak' },
      { width: '50%', color: '#f97316', text: 'Fair' },
      { width: '75%', color: '#eab308', text: 'Good' },
      { width: '100%', color: '#22c55e', text: 'Strong' }
    ];

    const level = strengthLevels[Math.max(0, strength - 1)] || strengthLevels[0];

    strengthFill.style.width = level.width;
    strengthFill.style.backgroundColor = level.color;
    strengthText.textContent = level.text;
    strengthText.style.color = level.color;

    return strength === 4;
  }

  function updateCheck(elementId, isValid) {
    const element = document.getElementById(elementId);
    const icon = element.querySelector('i');

    if (isValid) {
      element.style.color = '#22c55e';
      icon.className = 'fas fa-check';
    } else {
      element.style.color = '#ef4444';
      icon.className = 'fas fa-times';
    }
  }

  // Password input event listener
  document.getElementById('password').addEventListener('input', function() {
    checkPasswordStrength(this.value);
  });

  // Form submission with loading state
  document.querySelector('form').addEventListener('submit', function(e) {
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right: 0.5rem;"></i>Creating Account...';
    submitBtn.disabled = true;
  });

  // Input focus effects
  document.querySelectorAll('.form-input').forEach(input => {
    input.addEventListener('focus', function() {
      this.style.transform = 'translateY(-2px)';
    });

    input.addEventListener('blur', function() {
      this.style.transform = 'translateY(0)';
    });
  });
</script>

</body>
</html>