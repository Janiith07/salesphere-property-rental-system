<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentSphere | Manage Users</title>
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
                <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-users mr-2"></i>All Tenants</h3>

                <!-- Search Bar -->
                <div class="relative">
                    <input
                            type="text"
                            id="searchInput"
                            placeholder="Search tenants..."
                            class="bg-slate-700 text-gray-100 px-4 py-2 pl-10 rounded-lg border border-slate-600 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 w-64"
                    />
                    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                </div>
            </div>
            <div class="overflow-auto flex-1">
                <table class="min-w-full table-auto divide-y divide-slate-700 text-sm">
                    <thead class="bg-slate-700 sticky top-0 z-10 text-blue-200">
                    <tr>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Full Name</th>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Email</th>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Phone</th>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">NIC</th>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Address</th>
                        <th class="px-6 py-3 text-left font-semibold uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-700" id="userTableBody">
                    <c:forEach var="user" items="${users}">
                        <tr class="hover:bg-slate-700/40 transition user-row">
                            <td class="px-6 py-4">${user.userId}</td>
                            <td class="px-6 py-4">${user.fullName}</td>
                            <td class="px-6 py-4">${user.email}</td>
                            <td class="px-6 py-4">${user.phone}</td>
                            <td class="px-6 py-4">${user.nicNumber}</td>
                            <td class="px-6 py-4">${user.address}</td>
                            <td class="px-6 py-4 space-x-3">
                                <a href="${pageContext.request.contextPath}/admin/user?action=delete&id=${user.userId}"
                                   onclick="return confirm('Are you sure you want to delete this user?');"
                                   class="text-red-400 hover:text-red-500" title="Delete">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- No Results Message -->
                <div id="noResults" class="hidden text-center py-12 text-gray-400">
                    <i class="fas fa-search text-4xl mb-3"></i>
                    <p class="text-lg">No tenants found matching your search.</p>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchTerm = this.value.toLowerCase().trim();
        const rows = document.querySelectorAll('.user-row');
        const noResults = document.getElementById('noResults');
        let visibleCount = 0;

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        // Show/hide no results message
        if (visibleCount === 0 && searchTerm !== '') {
            noResults.classList.remove('hidden');
        } else {
            noResults.classList.add('hidden');
        }
    });
</script>
</body>
</html>