<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Edit Booking</title>
  <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-gray-100 min-h-screen flex">

  <!-- Sidebar -->
  <%@ include file="../partials/sidebar.jsp" %>

  <!-- Main Content -->
  <div class="flex-1 md:ml-60 flex flex-col min-h-screen">

    <!-- Topbar -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Edit Form Content -->
    <main class="flex-1 p-6 overflow-y-auto">
      <div class="mx-auto bg-slate-800 border border-slate-700 rounded-2xl shadow-xl p-8 space-y-6 max-w-xl">

        <div class="flex justify-between items-center">
          <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-edit mr-2"></i> Edit Booking Status</h3>
          <a href="${pageContext.request.contextPath}/admin/booking" class="text-sm text-blue-400 hover:underline">
            ← Back to Bookings
          </a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/booking?action=update-status" method="POST" class="space-y-4">
          <input type="hidden" name="id" value="${booking.bookingId}" />

          <!-- Tenant Name -->
          <div>
            <label class="block text-sm mb-1">Tenant</label>
            <p class="text-sm font-medium text-blue-200">${booking.tenantName}</p>
          </div>

          <!-- Property Title -->
          <div>
            <label class="block text-sm mb-1">Property</label>
            <p class="text-sm font-medium text-blue-200">${booking.propertyTitle}</p>
          </div>

          <!-- Booking Date -->
          <div>
            <label class="block text-sm mb-1">Date</label>
            <p class="text-sm font-medium text-blue-200">${booking.bookingDate}</p>
          </div>

          <!-- Status -->
          <div>
            <label class="block text-sm mb-1" for="status">Status</label>
            <select id="status" name="status" required
                    class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
              <option value="Pending" ${booking.status == 'Pending' ? 'selected' : ''}>Pending</option>
              <option value="Approved" ${booking.status == 'Approved' ? 'selected' : ''}>Approved</option>
              <option value="Rejected" ${booking.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
            </select>
          </div>

          <!-- Submit -->
          <div>
            <button type="submit"
                    class="w-full py-2 px-4 bg-blue-500 hover:bg-blue-600 text-white font-semibold rounded-lg transition">
              <i class="fas fa-save mr-2"></i> Update Status
            </button>
          </div>
        </form>
      </div>
    </main>
  </div>
</body>
</html>