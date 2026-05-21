<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Manage Payments</title>
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
            <i class="fas fa-credit-card mr-2"></i>All Payments
          </h3>
        </div>
        <div class="overflow-auto flex-1">
          <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
            <thead class="bg-slate-700 sticky top-0 z-10 text-blue-200">
              <tr>
                <th class="px-6 py-3 text-left">Payment ID</th>
                <th class="px-6 py-3 text-left">Booking ID</th>
                <th class="px-6 py-3 text-left">Tenant</th>
                <th class="px-6 py-3 text-left">Property</th>
                <th class="px-6 py-3 text-left">Amount</th>
                <th class="px-6 py-3 text-left">Status</th>
                <th class="px-6 py-3 text-left">Card Last4</th>
                <th class="px-6 py-3 text-left">Paid At</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-700">
              <c:forEach var="payment" items="${payments}">
                <tr class="hover:bg-slate-700/40 transition">
                  <td class="px-6 py-4">${payment.paymentId}</td>
                  <td class="px-6 py-4">${payment.bookingId}</td>
                  <td class="px-6 py-4">${payment.tenantName}</td>
                  <td class="px-6 py-4">${payment.propertyTitle}</td>
                  <td class="px-6 py-4">Rs. ${payment.amount}</td>
                  <td class="px-6 py-4">
                    <form method="post" action="${pageContext.request.contextPath}/admin/payment">
                      <input type="hidden" name="action" value="updateStatus" />
                      <input type="hidden" name="paymentId" value="${payment.paymentId}" />
                      <select name="status" class="bg-slate-700 text-sm text-white rounded-lg px-2 py-1 focus:outline-none">
                        <option value="Pending" ${payment.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Completed" ${payment.status == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Failed" ${payment.status == 'Failed' ? 'selected' : ''}>Failed</option>
                      </select>
                      <button type="submit" class="ml-2 text-xs px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 transition">
                        Update
                      </button>
                    </form>
                  </td>
                  <td class="px-6 py-4">****${payment.cardLast4}</td>
                  <td class="px-6 py-4">${payment.paidAt}</td>
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