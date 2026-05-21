<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentSphere | Property Approval</title>
    <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-gray-100 min-h-screen flex">

    <!-- Sidebar -->
    <%@ include file="./partials/sidebar.jsp" %>

    <!-- Main Content -->
    <div class="flex-1 md:ml-60 flex flex-col min-h-screen">

        <!-- Topbar -->
        <%@ include file="./partials/header.jsp" %>

        <!-- Content Container -->
        <main class="flex-1 p-6 overflow-hidden">
            <div class="bg-slate-800 border border-slate-700 rounded-2xl shadow-xl h-full overflow-hidden flex flex-col">
                <div class="flex justify-between items-center px-6 py-4 border-b border-slate-700">
                    <h3 class="text-lg font-semibold text-blue-400">
                        <i class="fas fa-check-circle mr-2"></i>Property Approval
                    </h3>
                    <div class="flex items-center space-x-4">
                        <span class="text-sm text-gray-400">
                            <c:choose>
                                <c:when test="${not empty pendingProperties}">
                                    ${pendingProperties.size()} properties pending approval
                                </c:when>
                                <c:otherwise>
                                    No properties pending approval
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="mx-6 mt-4 p-4 bg-green-900/50 border border-green-500 rounded-lg">
                        <div class="flex items-center">
                            <i class="fas fa-check-circle text-green-400 mr-2"></i>
                            <span class="text-green-300">${success}</span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="mx-6 mt-4 p-4 bg-red-900/50 border border-red-500 rounded-lg">
                        <div class="flex items-center">
                            <i class="fas fa-exclamation-circle text-red-400 mr-2"></i>
                            <span class="text-red-300">${error}</span>
                        </div>
                    </div>
                </c:if>

                <!-- Properties Table -->
                <div class="overflow-auto flex-1">
                    <c:choose>
                        <c:when test="${not empty pendingProperties}">
                            <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
                                <thead class="bg-slate-700 sticky top-0 z-10 text-blue-200">
                                    <tr>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">ID</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Title</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Type</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Rent</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Address</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Seller</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Created</th>
                                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-700">
                                    <c:forEach var="property" items="${pendingProperties}">
                                        <tr class="hover:bg-slate-700/40 transition">
                                            <td class="px-6 py-4">${property.propertyId}</td>
                                            <td class="px-6 py-4">
                                                <div class="font-medium">${property.title}</div>
                                                <div class="text-xs text-gray-400 mt-1">${property.description}</div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <span class="px-2 py-1 bg-blue-900/50 text-blue-300 rounded-full text-xs">
                                                    ${property.type}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 font-medium text-green-400">
                                                Rs. ${property.rent}
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-300">
                                                ${property.address}
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="text-sm">${property.landlordName}</div>
                                                <div class="text-xs text-gray-400">${property.landlordEmail}</div>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-400">
                                                ${property.createdAt}
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="flex space-x-2">
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/property-approval" class="inline">
                                                        <input type="hidden" name="action" value="approve">
                                                        <input type="hidden" name="propertyId" value="${property.propertyId}">
                                                        <button type="submit" 
                                                                onclick="return confirm('Are you sure you want to approve this property?');"
                                                                class="px-3 py-1 bg-green-600 hover:bg-green-700 text-white rounded text-xs font-medium transition">
                                                            <i class="fas fa-check mr-1"></i>Approve
                                                        </button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/property-approval" class="inline">
                                                        <input type="hidden" name="action" value="reject">
                                                        <input type="hidden" name="propertyId" value="${property.propertyId}">
                                                        <button type="submit" 
                                                                onclick="return confirm('Are you sure you want to reject this property?');"
                                                                class="px-3 py-1 bg-red-600 hover:bg-red-700 text-white rounded text-xs font-medium transition">
                                                            <i class="fas fa-times mr-1"></i>Reject
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="flex flex-col items-center justify-center h-64 text-gray-400">
                                <i class="fas fa-check-circle text-6xl mb-4 text-gray-600"></i>
                                <h3 class="text-xl font-medium mb-2">No Properties Pending Approval</h3>
                                <p class="text-sm">All properties have been reviewed and approved.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Auto-hide success/error messages after 5 seconds
        setTimeout(function() {
            const messages = document.querySelectorAll('.bg-green-900\\/50, .bg-red-900\\/50');
            messages.forEach(function(message) {
                message.style.opacity = '0';
                setTimeout(function() {
                    message.remove();
                }, 300);
            });
        }, 5000);
    </script>
</body>
</html>
