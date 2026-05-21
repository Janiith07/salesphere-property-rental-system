<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Sidebar -->
<div class="w-64 bg-slate-800 border border-slate-700 rounded-xl p-6 shadow-lg flex flex-col items-center">
    <!-- Profile Picture Placeholder -->
    <div class="w-24 h-24 rounded-full bg-slate-700 mb-6"></div>

    <!-- Navigation Links -->
    <nav class="space-y-3 w-full">
        <a href="${pageContext.request.contextPath}/my-bookings"
           class="flex items-center px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg transition text-teal-400">
            <i class="fas fa-calendar-alt mr-3"></i> My Bookings
        </a>

        <a href="${pageContext.request.contextPath}/my-reviews"
           class="flex items-center px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg transition text-teal-400">
            <i class="fas fa-star mr-3"></i> My Reviews
        </a>

        <a href="${pageContext.request.contextPath}/profile"
           class="flex items-center px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg transition text-teal-400">
            <i class="fas fa-user mr-3"></i> My Profile
        </a>

        <a href="${pageContext.request.contextPath}/settings"
           class="flex items-center px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg transition text-teal-400">
            <i class="fas fa-cog mr-3"></i> Settings
        </a>

        <!-- Delete Account -->
        <form action="${pageContext.request.contextPath}/settings" method="post"
              onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
            <input type="hidden" name="action" value="delete">
            <button type="submit"
                    class="flex items-center w-full px-4 py-2 bg-slate-700 hover:bg-slate-600 text-red-400 hover:text-red-500 rounded-lg transition shadow">
                <i class="fas fa-trash-alt mr-3"></i> Delete Account
            </button>
        </form>
    </nav>
</div>