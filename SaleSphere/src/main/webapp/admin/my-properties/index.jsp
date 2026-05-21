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
<body class="bg-slate-900 text-gray-100 min-h-screen flex">

    <!-- Sidebar -->
    <%@ include file="../partials/lordsidebar.jsp" %>

    <!-- Main Content -->
    <div class="flex-1 md:ml-60 flex flex-col min-h-screen">

        <!-- Topbar -->
        <%@ include file="../partials/header.jsp" %>

        <!-- Table Container -->
        <main class="flex-1 p-6 overflow-hidden">
            <div class="bg-slate-800 border border-slate-700 rounded-2xl shadow-xl h-full overflow-hidden flex flex-col">
                <div class="flex justify-between items-center px-6 py-4 border-b border-slate-700">
                    <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-building mr-2"></i>My Properties</h3>
                    <a href="${pageContext.request.contextPath}/admin/my-property?action=create"
                       class="inline-flex items-center px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white text-sm font-semibold rounded-lg shadow transition">
                        <i class="fas fa-plus mr-2"></i> Add Property
                    </a>
                </div>
                <div class="overflow-auto flex-1">
                    <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
                        <thead class="bg-slate-700 sticky top-0 z-10 text-blue-200">
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
                            <c:forEach var="property" items="${properties}">
                                <tr class="hover:bg-slate-700/40 transition">
                                    <td class="px-6 py-4">
                                        <img src="${pageContext.request.contextPath}/assets/properties/${not empty property.mainImage ? property.mainImage : 'default.jpg'}"
                                             alt="Property Image" class="w-20 h-14 object-cover rounded"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'" />
                                    </td>
                                    <td class="px-6 py-4 font-medium text-white">${property.title}</td>
                                    <td class="px-6 py-4">${property.address}</td>
                                    <td class="px-6 py-4">${property.type}</td>
                                    <td class="px-6 py-4">Rs. ${property.rent}</td>
                                    <td class="px-6 py-4">
                                        <span class="px-2 py-1 rounded-full text-xs font-medium
                                            <c:choose>
                                                <c:when test="${property.status == 'Available'}">bg-green-500/20 text-green-400</c:when>
                                                <c:when test="${property.status == 'Unavailable'}">bg-red-500/20 text-red-400</c:when>
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
                                    <td class="px-6 py-4 space-x-3">
                                        <a href="${pageContext.request.contextPath}/admin/my-property?action=edit&id=${property.propertyId}"
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
                                        <a href="${pageContext.request.contextPath}/admin/my-property?action=delete&id=${property.propertyId}"
                                           onclick="return confirm('Are you sure you want to delete this property?');"
                                           class="text-red-400 hover:text-red-500" title="Delete">
                                            <i class="fas fa-trash-alt"></i>
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