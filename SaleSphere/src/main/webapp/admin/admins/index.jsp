<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentSphere | Manage Admins</title>
    <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        /* Smooth animations */
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }

        .slide-up {
            animation: slideUp 0.5s ease-out forwards;
        }

        .scale-in {
            animation: scaleIn 0.3s ease-out forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes scaleIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        /* Glass effect */
        .glass {
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(148, 163, 184, 0.1);
        }

        /* Table animations */
        .table-row {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .table-row:hover {
            background: rgba(51, 65, 85, 0.5);
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* Action button animations */
        .action-btn {
            transition: all 0.2s ease;
            padding: 8px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .edit-btn:hover {
            background: rgba(59, 130, 246, 0.2);
        }

        .delete-btn:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        /* Search and filter animations */
        .search-input {
            transition: all 0.3s ease;
        }

        .search-input:focus {
            transform: translateY(-1px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
        }

        /* Loading animation */
        .loading-spinner {
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Badge animations */
        .role-badge {
            transition: all 0.2s ease;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        /* Modal animations */
        .modal {
            transition: all 0.3s ease;
        }

        .modal.show {
            opacity: 1;
            visibility: visible;
        }

        .modal.show .modal-content {
            transform: scale(1);
            opacity: 1;
        }

        .modal-content {
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            transform: scale(0.7);
            opacity: 0;
        }

        /* Statistics cards */
        .stat-card {
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.1) 0%, rgba(99, 102, 241, 0.1) 100%);
            border: 1px solid rgba(59, 130, 246, 0.2);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(59, 130, 246, 0.15);
            border-color: rgba(59, 130, 246, 0.4);
        }

        /* Custom scrollbar */
        .custom-scrollbar::-webkit-scrollbar {
            width: 8px;
        }

        .custom-scrollbar::-webkit-scrollbar-track {
            background: rgba(51, 65, 85, 0.3);
            border-radius: 4px;
        }

        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: rgba(59, 130, 246, 0.5);
            border-radius: 4px;
        }

        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: rgba(59, 130, 246, 0.7);
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            transform: translateX(100%);
            transition: transform 0.3s ease;
        }

        .notification.show {
            transform: translateX(0);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 to-slate-800 text-gray-100 min-h-screen">

<!-- Notification -->
<div id="notification" class="notification">
    <div class="bg-green-600 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-3">
        <i class="fas fa-check-circle"></i>
        <span id="notificationText">Success!</span>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal fixed inset-0 bg-black bg-opacity-50 backdrop-blur-sm flex items-center justify-center z-50 opacity-0 invisible">
    <div class="modal-content glass rounded-2xl p-8 max-w-md mx-4">
        <div class="text-center">
            <div class="w-16 h-16 bg-red-500 bg-opacity-20 rounded-full flex items-center justify-center mx-auto mb-6">
                <i class="fas fa-exclamation-triangle text-red-400 text-2xl"></i>
            </div>
            <h3 class="text-xl font-bold text-white mb-2">Confirm Delete</h3>
            <p class="text-gray-300 mb-6">Are you sure you want to delete this admin? This action cannot be undone.</p>
            <div class="flex space-x-4">
                <button onclick="closeDeleteModal()" class="flex-1 px-4 py-2 bg-slate-600 hover:bg-slate-500 text-white rounded-lg transition-colors">
                    Cancel
                </button>
                <button id="confirmDeleteBtn" class="flex-1 px-4 py-2 bg-red-600 hover:bg-red-500 text-white rounded-lg transition-colors">
                    Delete
                </button>
            </div>
        </div>
    </div>
</div>

<div class="flex min-h-screen">
    <!-- Sidebar -->
    <%@ include file="../partials/sidebar.jsp" %>

    <!-- Main Content -->
    <div class="flex-1 md:ml-60 flex flex-col">
        <!-- Header -->
        <%@ include file="../partials/header.jsp" %>

        <!-- Content -->
        <main class="flex-1 p-6">
            <div class="fade-in space-y-6">

                <!-- Page Header with Statistics -->
                <div class="glass rounded-xl p-6 shadow-xl">
                    <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-6">
                        <div class="flex items-center space-x-4">
                            <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center">
                                <i class="fas fa-users-cog text-white text-xl"></i>
                            </div>
                            <div>
                                <h1 class="text-2xl font-bold text-white">Admin Management</h1>
                                <p class="text-gray-400 text-sm">Manage system administrators</p>
                            </div>
                        </div>

                        <!-- Statistics Cards -->
                        <div class="flex gap-4">
                            <div class="stat-card px-4 py-3 rounded-lg">
                                <div class="flex items-center space-x-3">
                                    <div class="w-8 h-8 bg-green-500 bg-opacity-20 rounded-lg flex items-center justify-center">
                                        <i class="fas fa-users text-green-400 text-sm"></i>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-400">Total Admins</p>
                                        <p class="text-lg font-bold text-white">${admins.size()}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Search and Actions Bar -->
                <div class="glass rounded-xl p-6 shadow-xl slide-up">
                    <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                        <div class="flex-1 max-w-md">
                            <div class="relative">
                                <input type="text"
                                       id="searchInput"
                                       placeholder="Search admins..."
                                       class="search-input w-full px-4 py-3 pl-10 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            </div>
                        </div>

                        <div class="flex items-center space-x-4">
                            <div class="flex items-center space-x-2 text-sm text-gray-400">
                                <i class="fas fa-filter"></i>
                                <select id="roleFilter" class="bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="">All Roles</option>
                                    <option value="Admin">Admin</option>
                                    <option value="Landlord">Landlord</option>
                                </select>
                            </div>

                            <a href="${pageContext.request.contextPath}/admin/admin?action=create"
                               class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-blue-500 to-indigo-600 hover:from-blue-600 hover:to-indigo-700 text-white font-semibold rounded-lg shadow-lg transition-all duration-300 hover:scale-105 hover:shadow-xl">
                                <i class="fas fa-plus mr-2"></i>
                                Add Admin
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Table Container -->
                <div class="glass rounded-xl shadow-xl overflow-hidden scale-in">
                    <div class="bg-gradient-to-r from-slate-700 to-slate-600 px-6 py-4">
                        <h3 class="text-lg font-semibold text-white flex items-center">
                            <i class="fas fa-table mr-3"></i>
                            Admin List
                        </h3>
                    </div>

                    <div class="overflow-x-auto custom-scrollbar" style="max-height: calc(100vh - 400px);">
                        <table class="min-w-full">
                            <thead class="bg-slate-700 sticky top-0 z-10">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-blue-200 uppercase tracking-wider">
                                    <div class="flex items-center space-x-2">
                                        <span>ID</span>
                                        <i class="fas fa-sort text-gray-400 cursor-pointer hover:text-white" onclick="sortTable(0)"></i>
                                    </div>
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-blue-200 uppercase tracking-wider">
                                    <div class="flex items-center space-x-2">
                                        <span>Full Name</span>
                                        <i class="fas fa-sort text-gray-400 cursor-pointer hover:text-white" onclick="sortTable(1)"></i>
                                    </div>
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-blue-200 uppercase tracking-wider">
                                    <div class="flex items-center space-x-2">
                                        <span>Email</span>
                                        <i class="fas fa-sort text-gray-400 cursor-pointer hover:text-white" onclick="sortTable(2)"></i>
                                    </div>
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-blue-200 uppercase tracking-wider">
                                    <div class="flex items-center space-x-2">
                                        <span>Phone</span>
                                        <i class="fas fa-sort text-gray-400 cursor-pointer hover:text-white" onclick="sortTable(3)"></i>
                                    </div>
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-blue-200 uppercase tracking-wider">
                                    <div class="flex items-center space-x-2">
                                        <span>Role</span>
                                        <i class="fas fa-sort text-gray-400 cursor-pointer hover:text-white" onclick="sortTable(4)"></i>
                                    </div>
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-blue-200 uppercase tracking-wider">Actions</th>
                            </tr>
                            </thead>
                            <tbody id="adminTableBody" class="divide-y divide-slate-700">
                            <c:forEach var="admin" items="${admins}" varStatus="status">
                                <tr class="table-row hover:bg-slate-700/40" style="animation-delay: ${status.index * 0.1}s">
                                    <td class="px-6 py-4 text-sm">
                                        <div class="flex items-center">
                                            <div class="w-8 h-8 bg-gradient-to-r from-purple-500 to-pink-500 rounded-lg flex items-center justify-center text-white text-xs font-bold">
                                                    ${admin.adminId}
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-10 h-10 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full flex items-center justify-center text-white font-semibold">
                                                    ${admin.fullName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div>
                                                <p class="text-sm font-medium text-white">${admin.fullName}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-2">
                                            <i class="fas fa-envelope text-gray-400 text-xs"></i>
                                            <span class="text-sm text-gray-300">${admin.email}</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-2">
                                            <i class="fas fa-phone text-gray-400 text-xs"></i>
                                            <span class="text-sm text-gray-300">${admin.phone}</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                                <span class="role-badge inline-flex items-center px-3 py-1 rounded-full text-xs font-medium
                                                    ${admin.role == 'Admin' ? 'bg-blue-500 bg-opacity-20 text-blue-400 border border-blue-500 border-opacity-30' : 'bg-green-500 bg-opacity-20 text-green-400 border border-green-500 border-opacity-30'}">
                                                    <i class="fas ${admin.role == 'Admin' ? 'fa-user-shield' : 'fa-building'} mr-1"></i>
                                                    ${admin.role}
                                                </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <a href="${pageContext.request.contextPath}/admin/admin?action=edit&id=${admin.adminId}"
                                               class="action-btn edit-btn text-blue-400 hover:text-blue-300"
                                               title="Edit Admin">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button onclick="showDeleteModal('${pageContext.request.contextPath}/admin/admin?action=delete&id=${admin.adminId}')"
                                                    class="action-btn delete-btn text-red-400 hover:text-red-300"
                                                    title="Delete Admin">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <!-- Empty State -->
                        <div id="emptyState" class="hidden text-center py-12">
                            <div class="w-24 h-24 bg-slate-700 rounded-full flex items-center justify-center mx-auto mb-4">
                                <i class="fas fa-users-slash text-gray-400 text-3xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-400 mb-2">No admins found</h3>
                            <p class="text-gray-500 text-sm">Try adjusting your search criteria or add a new admin.</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    // Elements
    const searchInput = document.getElementById('searchInput');
    const roleFilter = document.getElementById('roleFilter');
    const tableBody = document.getElementById('adminTableBody');
    const emptyState = document.getElementById('emptyState');
    const deleteModal = document.getElementById('deleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

    let currentDeleteUrl = '';

    // Search and filter functionality
    function filterTable() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedRole = roleFilter.value.toLowerCase();
        const rows = tableBody.querySelectorAll('tr');
        let visibleRows = 0;

        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            if (cells.length === 0) return;

            const fullName = cells[1].textContent.toLowerCase();
            const email = cells[2].textContent.toLowerCase();
            const phone = cells[3].textContent.toLowerCase();
            const role = cells[4].textContent.toLowerCase();

            const matchesSearch = fullName.includes(searchTerm) ||
                email.includes(searchTerm) ||
                phone.includes(searchTerm);
            const matchesRole = selectedRole === '' || role.includes(selectedRole);

            if (matchesSearch && matchesRole) {
                row.style.display = '';
                visibleRows++;
                // Add stagger animation
                row.style.animationDelay = (visibleRows * 0.05) + 's';
                row.classList.add('fade-in');
            } else {
                row.style.display = 'none';
            }
        });

        // Show/hide empty state
        if (visibleRows === 0) {
            emptyState.classList.remove('hidden');
        } else {
            emptyState.classList.add('hidden');
        }
    }

    // Sort functionality
    function sortTable(columnIndex) {
        const rows = Array.from(tableBody.querySelectorAll('tr'));
        const sortIcon = document.querySelector(`th:nth-child(${columnIndex + 1}) i`);

        // Toggle sort direction
        const isAsc = sortIcon.classList.contains('fa-sort-up');
        document.querySelectorAll('th i').forEach(icon => {
            icon.className = 'fas fa-sort text-gray-400 cursor-pointer hover:text-white';
        });

        sortIcon.className = `fas fa-sort-${isAsc ? 'down' : 'up'} text-blue-400 cursor-pointer hover:text-white`;

        rows.sort((a, b) => {
            const aVal = a.querySelectorAll('td')[columnIndex].textContent.trim();
            const bVal = b.querySelectorAll('td')[columnIndex].textContent.trim();

            if (columnIndex === 0) {
                // Numeric sort for ID
                return isAsc ? parseInt(bVal) - parseInt(aVal) : parseInt(aVal) - parseInt(bVal);
            } else {
                // Text sort
                return isAsc ? bVal.localeCompare(aVal) : aVal.localeCompare(bVal);
            }
        });

        // Re-append sorted rows
        rows.forEach((row, index) => {
            row.style.animationDelay = (index * 0.05) + 's';
            tableBody.appendChild(row);
        });
    }

    // Delete modal functions
    function showDeleteModal(deleteUrl) {
        currentDeleteUrl = deleteUrl;
        deleteModal.classList.remove('opacity-0', 'invisible');
        deleteModal.classList.add('show');
    }

    function closeDeleteModal() {
        deleteModal.classList.add('opacity-0', 'invisible');
        deleteModal.classList.remove('show');
        currentDeleteUrl = '';
    }

    function confirmDelete() {
        if (currentDeleteUrl) {
            // Show loading state
            confirmDeleteBtn.innerHTML = '<i class="fas fa-spinner loading-spinner mr-2"></i>Deleting...';
            confirmDeleteBtn.disabled = true;

            // Redirect to delete URL
            window.location.href = currentDeleteUrl;
        }
    }

    // Notification function
    function showNotification(message, type = 'success') {
        const notification = document.getElementById('notification');
        const notificationText = document.getElementById('notificationText');

        notificationText.textContent = message;

        if (type === 'success') {
            notification.querySelector('div').className = 'bg-green-600 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-3';
            notification.querySelector('i').className = 'fas fa-check-circle';
        } else {
            notification.querySelector('div').className = 'bg-red-600 text-white px-6 py-3 rounded-lg shadow-lg flex items-center space-x-3';
            notification.querySelector('i').className = 'fas fa-exclamation-circle';
        }

        notification.classList.add('show');

        setTimeout(() => {
            notification.classList.remove('show');
        }, 4000);
    }

    // Event listeners
    searchInput.addEventListener('input', filterTable);
    roleFilter.addEventListener('change', filterTable);
    confirmDeleteBtn.addEventListener('click', confirmDelete);

    // Close modal when clicking outside
    deleteModal.addEventListener('click', function(e) {
        if (e.target === deleteModal) {
            closeDeleteModal();
        }
    });

    // ESC key to close modal
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && deleteModal.classList.contains('show')) {
            closeDeleteModal();
        }
    });

    // Initialize table animations
    document.addEventListener('DOMContentLoaded', function() {
        const rows = tableBody.querySelectorAll('tr');
        rows.forEach((row, index) => {
            row.style.animationDelay = (index * 0.1) + 's';
            row.classList.add('fade-in');
        });
    });

    // Check for success/error messages from server
    <c:if test="${not empty sessionScope.successMessage}">
    showNotification('${sessionScope.successMessage}', 'success');
    <c:remove var="successMessage" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
    showNotification('${sessionScope.errorMessage}', 'error');
    <c:remove var="errorMessage" scope="session"/>
    </c:if>
</script>

</body>
</html>