<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Profile | RentSphere</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <link rel="stylesheet" href="client/css/profile.css">
</head>
<body class="gradient-bg text-white">

<!-- Header -->
<c:choose>
  <c:when test="${isLoggedIn}">
    <jsp:include page="./partials/sessionheader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="./partials/header.jsp" />
  </c:otherwise>
</c:choose>

<!-- Layout -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 flex flex-col lg:flex-row gap-8">

  <!-- Sidebar -->
  <div class="fade-in delay-100">
    <%@ include file="./partials/sidebar.jsp" %>
  </div>

  <!-- Main Profile Content -->
  <main class="flex-1 profile-card rounded-2xl shadow-2xl p-6 lg:p-8 fade-in delay-200">

    <!-- Profile Header -->
    <div class="flex flex-col md:flex-row items-center md:items-start gap-6 mb-8 pb-8 border-b border-slate-700">
      <div class="profile-avatar fade-in delay-300">
        <c:choose>
          <c:when test="${not empty user.fullName}">
            ${user.fullName.substring(0,1).toUpperCase()}
          </c:when>
          <c:otherwise>U</c:otherwise>
        </c:choose>
      </div>

      <div class="text-center md:text-left flex-1 fade-in delay-400">
        <h1 class="text-3xl lg:text-4xl font-bold mb-3">
          Welcome, <span class="welcome-gradient"><c:out value="${user.fullName}" default="User" /></span>
        </h1>
        <p class="text-slate-300 text-lg">
          Manage your profile information and account settings
        </p>
      </div>
    </div>

    <!-- Profile Information Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">

      <div class="info-card rounded-xl p-5 shadow-lg fade-in delay-300">
        <div class="flex items-center mb-3">
          <i class="fas fa-user text-xl icon-glow mr-3"></i>
          <h3 class="text-sm font-semibold text-slate-300 uppercase tracking-wider">
            Full Name
          </h3>
        </div>
        <p class="text-lg text-white font-semibold"><c:out value="${user.fullName}" default="Not provided" /></p>
      </div>

      <div class="info-card rounded-xl p-5 shadow-lg fade-in delay-400">
        <div class="flex items-center mb-3">
          <i class="fas fa-envelope text-xl icon-glow mr-3"></i>
          <h3 class="text-sm font-semibold text-slate-300 uppercase tracking-wider">
            Email Address
          </h3>
        </div>
        <p class="text-lg text-white font-semibold break-all"><c:out value="${user.email}" default="Not provided" /></p>
      </div>

      <div class="info-card rounded-xl p-5 shadow-lg fade-in delay-500">
        <div class="flex items-center mb-3">
          <i class="fas fa-id-card text-xl icon-glow mr-3"></i>
          <h3 class="text-sm font-semibold text-slate-300 uppercase tracking-wider">
            NIC Number
          </h3>
        </div>
        <p class="text-lg text-white font-semibold font-mono"><c:out value="${user.nicNumber}" default="Not provided" /></p>
      </div>

      <div class="info-card rounded-xl p-5 shadow-lg fade-in delay-600">
        <div class="flex items-center mb-3">
          <i class="fas fa-phone text-xl icon-glow mr-3"></i>
          <h3 class="text-sm font-semibold text-slate-300 uppercase tracking-wider">
            Phone Number
          </h3>
        </div>
        <p class="text-lg text-white font-semibold font-mono"><c:out value="${user.phone}" default="Not provided" /></p>
      </div>

      <div class="info-card rounded-xl p-5 shadow-lg md:col-span-2 fade-in delay-600">
        <div class="flex items-center mb-3">
          <i class="fas fa-map-marker-alt text-xl icon-glow mr-3"></i>
          <h3 class="text-sm font-semibold text-slate-300 uppercase tracking-wider">
            Address
          </h3>
        </div>
        <p class="text-lg text-white font-semibold leading-relaxed"><c:out value="${user.address}" default="Not provided" /></p>
      </div>
    </div>
  </main>
</div>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

</body>
</html>