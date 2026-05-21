<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Book Property | RentSphere</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-white font-sans">

<!-- Header -->
<%@ include file="./partials/sessionheader.jsp" %>

<main class="border-b border-slate-700 py-16">
  <div class="max-w-lg mx-auto bg-slate-800 p-10 rounded-xl shadow-2xl border border-slate-700">
    <h2 class="text-2xl font-bold mb-6 text-center text-blue-400">Confirm Your Booking</h2>

    <!-- Success Message -->
    <c:if test="${not empty success}">
      <div class="mb-6 p-4 bg-green-600/20 text-green-300 border border-green-500/40 rounded-lg">
        <i class="fas fa-check-circle mr-2"></i> ${success}
      </div>
      <script>
        // Redirect to payment page if booking success
        setTimeout(() => {
          window.location.href = '${pageContext.request.contextPath}/pay.jsp?bookingId=${bookingId}';
        }, 1200);
      </script>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty error}">
      <div class="mb-6 p-4 bg-red-600/20 text-red-300 border border-red-500/40 rounded-lg">
        <i class="fas fa-exclamation-circle mr-2"></i> ${error}
      </div>
    </c:if>

    <!-- Booking Form -->
    <form action="${pageContext.request.contextPath}/book-property" method="post" class="space-y-6">
      <input type="hidden" name="propertyId" value="${propertyId}" />

      <div class="text-center">
        <p class="text-sm text-slate-400 mb-2">You're about to book property:</p>
        <p class="text-2xl font-semibold text-teal-300">#${propertyId} - Rs. ${property.rent}</p>
      </div>

      <button type="submit"
              class="w-full flex items-center justify-center gap-2 px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white text-sm font-semibold rounded-lg transition">
        <i class="fas fa-calendar-check"></i> Submit Booking & Proceed to Payment
      </button>
    </form>
  </div>
</main>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>
</body>
</html>
