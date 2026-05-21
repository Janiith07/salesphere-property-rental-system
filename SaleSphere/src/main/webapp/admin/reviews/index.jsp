<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentSphere | View Reviews</title>
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

        <!-- Table Container -->
        <main class="flex-1 p-6 overflow-hidden">
            <div class="bg-slate-800 border border-slate-700 rounded-2xl shadow-xl h-full overflow-hidden flex flex-col">
                <div class="flex justify-between items-center px-6 py-4 border-b border-slate-700">
                    <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-comments mr-2"></i>All Reviews</h3>
                </div>
                <div class="overflow-auto flex-1">
                    <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
                        <thead class="bg-slate-700 sticky top-0 z-10 text-blue-200">
                            <tr>
                                <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Review ID</th>
                                <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Tenant</th>
                                <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Property</th>
                                <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Rating</th>
                                <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Comment</th>
                                <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Date</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-700">
                            <c:forEach var="review" items="${reviews}">
                                <tr class="hover:bg-slate-700/40 transition">
                                    <td class="px-6 py-4">${review.reviewId}</td>
                                    <td class="px-6 py-4">${review.tenantName}</td>
                                    <td class="px-6 py-4">${review.propertyTitle}</td>
                                    <td class="px-6 py-4">
                                        <span class="text-yellow-400 font-semibold">${review.rating} ★</span>
                                    </td>
                                    <td class="px-6 py-4">${review.comment}</td>
                                    <td class="px-6 py-4">${review.reviewedAt}</td>
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