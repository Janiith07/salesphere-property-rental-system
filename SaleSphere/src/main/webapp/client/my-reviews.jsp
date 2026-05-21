<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Reviews | RentSphere</title>
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
    <h1 class="text-3xl font-bold text-teal-400 mb-6">My Reviews</h1>

    <!-- Success Messages -->
    <c:if test="${param.success eq 'updated'}">
      <div class="mb-6 p-4 bg-green-900/30 text-green-300 border border-green-600 rounded">
        <i class="fas fa-check-circle mr-2"></i> Review updated successfully!
      </div>
    </c:if>

    <c:if test="${param.success eq 'deleted'}">
      <div class="mb-6 p-4 bg-green-900/30 text-green-300 border border-green-600 rounded">
        <i class="fas fa-check-circle mr-2"></i> Review deleted successfully!
      </div>
    </c:if>

    <c:if test="${empty reviews}">
      <div class="text-center py-12">
        <i class="fas fa-star text-6xl text-slate-600 mb-4"></i>
        <p class="text-slate-300 text-lg">You haven't submitted any reviews yet.</p>
        <a href="${pageContext.request.contextPath}/my-bookings"
           class="inline-block mt-4 px-6 py-2 bg-teal-500 text-white rounded-lg hover:bg-teal-600 transition">
          View My Bookings
        </a>
      </div>
    </c:if>

    <c:if test="${not empty reviews}">
      <div class="grid gap-6">
        <c:forEach var="review" items="${reviews}">
          <div class="bg-slate-700/50 border border-slate-600 rounded-lg p-6 hover:border-teal-500/50 transition">
            <!-- Property Title -->
            <div class="flex items-start justify-between mb-4">
              <div>
                <h3 class="text-xl font-semibold text-white mb-1">${review.propertyTitle}</h3>
                <p class="text-sm text-slate-400">
                  <i class="far fa-calendar mr-1"></i> ${review.reviewedAt}
                </p>
              </div>
              <div class="flex gap-2">
                <a href="${pageContext.request.contextPath}/my-reviews?action=edit&id=${review.reviewId}"
                   class="px-3 py-1.5 bg-blue-500 hover:bg-blue-600 text-white text-sm rounded-lg transition">
                  <i class="fas fa-edit mr-1"></i> Edit
                </a>
                <a href="${pageContext.request.contextPath}/my-reviews?action=delete&id=${review.reviewId}"
                   onclick="return confirm('Are you sure you want to delete this review?');"
                   class="px-3 py-1.5 bg-red-500 hover:bg-red-600 text-white text-sm rounded-lg transition">
                  <i class="fas fa-trash mr-1"></i> Delete
                </a>
              </div>
            </div>

            <!-- Rating -->
            <div class="mb-3">
              <div class="text-yellow-400 text-lg">
                <c:forEach begin="1" end="${review.rating}">
                  <i class="fas fa-star"></i>
                </c:forEach>
                <c:forEach begin="1" end="${5 - review.rating}">
                  <i class="far fa-star"></i>
                </c:forEach>
              </div>
            </div>

            <!-- Comment -->
            <p class="text-slate-300 leading-relaxed">${review.comment}</p>
          </div>
        </c:forEach>
      </div>
    </c:if>
  </main>
</div>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>
</body>
</html>