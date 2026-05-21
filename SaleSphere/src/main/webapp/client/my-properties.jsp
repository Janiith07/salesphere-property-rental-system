<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentSphere | My Properties</title>
    <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-gray-100 min-h-screen">

    <!-- Header -->
    <%@ include file="partials/sessionheader.jsp" %>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
        <div class="bg-slate-800 border border-slate-700 rounded-2xl shadow-xl overflow-hidden">
            <div class="flex justify-between items-center px-6 py-4 border-b border-slate-700">
                <h2 class="text-2xl font-bold text-blue-400">
                    <i class="fas fa-building mr-2"></i>My Properties
                </h2>
                <a href="${pageContext.request.contextPath}/client/create.jsp"
                   class="inline-flex items-center px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white text-sm font-semibold rounded-lg shadow transition">
                    <i class="fas fa-plus mr-2"></i> Add Property
                </a>
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
            <div class="overflow-x-auto">
                <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
                    <thead class="bg-slate-700 text-blue-200">
                        <tr>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Image</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Title</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Address</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Type</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Rent</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Status</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Approval</th>
                            <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-700">
                        <c:choose>
                            <c:when test="${not empty properties}">
                                <c:forEach var="property" items="${properties}">
                                    <tr class="hover:bg-slate-700/40 transition">
                                        <td class="px-6 py-4">
                                            <img src="${pageContext.request.contextPath}/assets/properties/${not empty property.mainImage ? property.mainImage : 'default.jpg'}"
                                                 alt="Property Image" class="w-20 h-14 object-cover rounded"
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'" />
                                        </td>
                                        <td class="px-6 py-4 font-medium text-white">${property.title}</td>
                                        <td class="px-6 py-4">${property.address}</td>
                                        <td class="px-6 py-4">
                                            <span class="px-2 py-1 bg-blue-900/50 text-blue-300 rounded-full text-xs">
                                                ${property.type}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 font-medium text-green-400">
                                            Rs. ${property.rent}
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="px-2 py-1 rounded-full text-xs font-medium
                                                <c:choose>
                                                    <c:when test="${property.status == 'Available'}">bg-green-500/20 text-green-400</c:when>
                                                    <c:when test="${property.status == 'Rented'}">bg-red-500/20 text-red-400</c:when>
                                                    <c:when test="${property.status == 'Inactive'}">bg-gray-500/20 text-gray-400</c:when>
                                                    <c:otherwise>bg-gray-500/20 text-gray-400</c:otherwise>
                                                </c:choose>">
                                                ${property.status}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="px-2 py-1 rounded-full text-xs font-medium
                                                <c:choose>
                                                    <c:when test="${property.approvalStatus == 'Approved'}">bg-green-500/20 text-green-400</c:when>
                                                    <c:when test="${property.approvalStatus == 'Pending'}">bg-yellow-500/20 text-yellow-400</c:when>
                                                    <c:when test="${property.approvalStatus == 'Rejected'}">bg-red-500/20 text-red-400</c:when>
                                                    <c:otherwise>bg-gray-500/20 text-gray-400</c:otherwise>
                                                </c:choose>">
                                                ${property.approvalStatus}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/client/create.jsp?action=edit&id=${property.propertyId}"
                                                   class="text-blue-400 hover:text-blue-500" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:if test="${property.approvalStatus != 'Pending'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/seller/publish-property" class="inline">
                                                        <input type="hidden" name="propertyId" value="${property.propertyId}">
                                                        <button type="submit" 
                                                                onclick="return confirm('Submit this property for approval?');"
                                                                class="text-green-400 hover:text-green-500" title="Publish for Approval">
                                                            <i class="fas fa-paper-plane"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${property.approvalStatus == 'Rejected'}">
                                                    <span class="text-red-400 text-xs" title="Property was rejected. Please edit and resubmit.">
                                                        <i class="fas fa-exclamation-triangle"></i>
                                                    </span>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="px-6 py-12 text-center text-gray-400">
                                        <i class="fas fa-building text-4xl mb-4 text-gray-600"></i>
                                        <h3 class="text-lg font-medium mb-2">No Properties Found</h3>
                                        <p class="text-sm">You haven't created any properties yet.</p>
                                        <a href="${pageContext.request.contextPath}/client/create.jsp"
                                           class="inline-flex items-center px-4 py-2 mt-4 bg-blue-500 hover:bg-blue-600 text-white text-sm font-semibold rounded-lg shadow transition">
                                            <i class="fas fa-plus mr-2"></i> Create Your First Property
                                        </a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <%@ include file="partials/footer.jsp" %>

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
