<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Manage Bookings</title>
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

    <main class="flex-1 p-6 overflow-hidden">
      <div class="bg-slate-800 border border-slate-700 rounded-2xl shadow-xl h-full overflow-hidden flex flex-col">
        <div class="flex justify-between items-center px-6 py-4 border-b border-slate-700">
          <h3 class="text-lg font-semibold text-blue-400">
            <i class="fas fa-calendar-check mr-2"></i>All Bookings
          </h3>
        </div>
        <div class="overflow-auto flex-1">
          <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
            <thead class="bg-slate-700 sticky top-0 z-10 text-blue-200">
              <tr>
                <th class="px-6 py-3 text-left">Booking ID</th>
                <th class="px-6 py-3 text-left">Tenant</th>
                <th class="px-6 py-3 text-left">Property</th>
                <th class="px-6 py-3 text-left">Date</th>
                <th class="px-6 py-3 text-left">Status</th>
                <th class="px-6 py-3 text-left">Actions</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-700">
              <c:forEach var="booking" items="${bookings}">
                <tr class="hover:bg-slate-700/40 transition">
                  <td class="px-6 py-4">${booking.bookingId}</td>
                  <td class="px-6 py-4">${booking.tenantName}</td>
                  <td class="px-6 py-4">${booking.propertyTitle}</td>
                  <td class="px-6 py-4">${booking.bookingDate}</td>
                  <td class="px-6 py-4">
                    <form method="post" action="${pageContext.request.contextPath}/admin/booking">
                      <input type="hidden" name="action" value="updateStatus" />
                      <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                      <select name="status" class="bg-slate-700 text-sm text-white rounded-lg px-2 py-1 focus:outline-none">
                        <option value="Pending" ${booking.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Approved" ${booking.status == 'Approved' ? 'selected' : ''}>Approved</option>
                        <option value="Rejected" ${booking.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                        <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                      </select>
                      <button type="submit" class="ml-2 text-xs px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 transition">
                        Update
                      </button>
                    </form>
                  </td>
                  <td class="px-6 py-4">
                    <a href="${pageContext.request.contextPath}/admin/booking?action=delete&id=${booking.bookingId}"
                       onclick="return confirm('Are you sure you want to delete this booking?');"
                       class="text-red-400 hover:text-red-500" title="Delete">
                      <i class="fas fa-trash-alt"></i> Delete
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>
</body>
</html>