<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Bookings | RentSphere</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-slate-900 text-white font-sans">

<!-- Header -->
<c:choose>
  <c:when test="${isLoggedIn}">
    <jsp:include page="./partials/sessionheader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="./partials/header.jsp" />
  </c:otherwise>
</c:choose>

<!-- Dashboard -->
<div class="max-w-7xl mx-auto px-6 py-10 flex flex-col lg:flex-row gap-8">

  <!-- Sidebar -->
  <%@ include file="./partials/sidebar.jsp" %>

  <!-- Content -->
  <main class="flex-1 bg-slate-800 border border-slate-700 rounded-2xl shadow-lg p-8">
    <h1 class="text-3xl font-bold text-teal-400 mb-6">My Bookings</h1>

    <c:if test="${empty bookings}">
      <p class="text-slate-300">You have no bookings at the moment.</p>
    </c:if>

    <c:if test="${not empty bookings}">
      <div class="overflow-x-auto border border-slate-700 rounded-lg">
        <table class="min-w-full text-sm text-left text-slate-300">
          <thead class="bg-slate-700 text-slate-400 uppercase text-xs">
            <tr>
              <th class="px-4 py-3">Booking ID</th>
              <th class="px-4 py-3">Property</th>
              <th class="px-4 py-3">Tenant</th>
              <th class="px-4 py-3">Date</th>
              <th class="px-4 py-3">Status</th>
              <th class="px-4 py-3">Actions</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-700">
            <c:forEach var="booking" items="${bookings}">
              <tr class="hover:bg-slate-700/40 transition">
                <td class="px-4 py-3">${booking.bookingId}</td>
                <td class="px-4 py-3">${booking.propertyTitle}</td>
                <td class="px-4 py-3">${booking.tenantName}</td>
                <td class="px-4 py-3">${booking.bookingDate}</td>
                <td class="px-4 py-3">
                  <span class="inline-block px-2 py-1 text-xs font-medium rounded-full
                    <c:choose>
                      <c:when test="${booking.status == 'Confirmed'}">bg-green-200 text-green-900</c:when>
                      <c:when test="${booking.status == 'Cancelled'}">bg-red-200 text-red-900</c:when>
                      <c:otherwise>bg-yellow-200 text-yellow-900</c:otherwise>
                    </c:choose>">
                    ${booking.status}
                  </span>
                </td>
                <td class="px-4 py-3">
				  <c:choose>
				    <c:when test="${booking.status eq 'Approved'}">
				      <a href="${pageContext.request.contextPath}/review?propertyId=${booking.propertyId}" 
				         class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded bg-teal-500 hover:bg-teal-600 text-white transition">
				        <i class="fas fa-star mr-1"></i> Leave Review
				      </a>
				    </c:when>
				    <c:otherwise>
				      <span class="text-slate-400 italic">No Actions</span>
				    </c:otherwise>
				  </c:choose>
				</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>
  </main>
</div>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>
</body>
</html>