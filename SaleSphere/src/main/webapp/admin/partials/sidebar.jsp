<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Enhanced CSS for modern animations and styling -->
<style>
    @keyframes slideInLeft {
        from {
            transform: translateX(-100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }

    @keyframes fadeInUp {
        from {
            transform: translateY(20px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    @keyframes logoGlow {
        0%, 100% {
            text-shadow: 0 0 20px rgba(59, 130, 246, 0.5);
        }
        50% {
            text-shadow: 0 0 30px rgba(59, 130, 246, 0.8), 0 0 40px rgba(59, 130, 246, 0.3);
        }
    }

    @keyframes shimmer {
        0% {
            background-position: -200% 0;
        }
        100% {
            background-position: 200% 0;
        }
    }

    @keyframes pulse {
        0%, 100% {
            transform: scale(1);
            opacity: 1;
        }
        50% {
            transform: scale(1.05);
            opacity: 0.8;
        }
    }

    .sidebar-container {
        backdrop-filter: blur(20px) saturate(180%);
        background: linear-gradient(180deg, rgba(15, 23, 42, 0.95), rgba(30, 41, 59, 0.9));
        border-right: 1px solid rgba(148, 163, 184, 0.1);
        box-shadow: 4px 0 24px rgba(0, 0, 0, 0.15);
        animation: slideInLeft 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .sidebar-container:hover {
        box-shadow: 6px 0 32px rgba(0, 0, 0, 0.2);
    }

    .brand-section {
        background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(51, 65, 85, 0.6));
        border-bottom: 1px solid rgba(59, 130, 246, 0.2);
        position: relative;
        overflow: hidden;
    }

    .brand-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.1), transparent);
        transition: left 0.8s ease;
    }

    .brand-section:hover::before {
        left: 100%;
    }

    .brand-title {
        background: linear-gradient(135deg, #60a5fa, #3b82f6, #2563eb);
        background-size: 200% 200%;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        animation: shimmer 3s ease-in-out infinite, logoGlow 2s ease-in-out infinite;
        transition: all 0.3s ease;
        position: relative;
    }

    .brand-title:hover {
        transform: scale(1.05);
        filter: brightness(1.2);
    }

    .brand-subtitle {
        color: rgba(148, 163, 184, 0.8);
        transition: color 0.3s ease;
        animation: fadeInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1) 0.2s both;
    }

    .brand-section:hover .brand-subtitle {
        color: rgba(148, 163, 184, 1);
    }

    .nav-container {
        position: relative;
        padding: 1.5rem 1rem;
    }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 0.875rem 1rem;
        border-radius: 0.75rem;
        margin-bottom: 0.5rem;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        color: rgba(203, 213, 225, 0.9);
        text-decoration: none;
        font-weight: 500;
        opacity: 0;
        animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1) forwards;
        border: 1px solid transparent;
    }

    .nav-link:nth-child(1) { animation-delay: 0.1s; }
    .nav-link:nth-child(2) { animation-delay: 0.2s; }
    .nav-link:nth-child(3) { animation-delay: 0.3s; }
    .nav-link:nth-child(4) { animation-delay: 0.4s; }
    .nav-link:nth-child(5) { animation-delay: 0.5s; }

    .nav-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.1), transparent);
        transition: left 0.5s ease;
        z-index: 0;
    }

    .nav-link:hover::before {
        left: 100%;
    }

    .nav-link:hover {
        background: linear-gradient(135deg, rgba(59, 130, 246, 0.15), rgba(79, 70, 229, 0.1));
        transform: translateX(8px) scale(1.02);
        color: #60a5fa;
        border-color: rgba(59, 130, 246, 0.3);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
    }

    .nav-link.active {
        background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(99, 102, 241, 0.15));
        color: #93c5fd;
        font-weight: 600;
        border-color: rgba(59, 130, 246, 0.4);
        box-shadow: 0 0 20px rgba(59, 130, 246, 0.2);
        position: relative;
    }

    .nav-link.active::after {
        content: '';
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 4px;
        height: 24px;
        background: linear-gradient(180deg, #60a5fa, #3b82f6);
        border-radius: 2px;
        box-shadow: 0 0 10px rgba(59, 130, 246, 0.5);
    }

    .nav-icon {
        margin-right: 0.75rem;
        font-size: 1.125rem;
        transition: all 0.3s ease;
        position: relative;
        z-index: 1;
    }

    .nav-link:hover .nav-icon {
        transform: scale(1.1) rotate(5deg);
        filter: drop-shadow(0 0 8px rgba(59, 130, 246, 0.5));
    }

    .nav-text {
        position: relative;
        z-index: 1;
        transition: all 0.3s ease;
    }

    .logout-section {
        border-top: 1px solid rgba(148, 163, 184, 0.1);
        padding: 1rem;
        background: linear-gradient(135deg, rgba(15, 23, 42, 0.8), rgba(30, 41, 59, 0.6));
    }

    .logout-button {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0.875rem 1rem;
        border-radius: 0.75rem;
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(220, 38, 38, 0.05));
        border: 1px solid rgba(239, 68, 68, 0.2);
        color: #fca5a5;
        font-weight: 600;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .logout-button::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(239, 68, 68, 0.1), transparent);
        transition: left 0.5s ease;
    }

    .logout-button:hover::before {
        left: 100%;
    }

    .logout-button:hover {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.2), rgba(220, 38, 38, 0.15));
        transform: translateY(-2px);
        color: #f87171;
        border-color: rgba(239, 68, 68, 0.4);
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.15);
    }

    .logout-button:active {
        transform: translateY(0);
        box-shadow: 0 2px 8px rgba(239, 68, 68, 0.2);
    }

    .logout-icon {
        margin-right: 0.5rem;
        transition: transform 0.3s ease;
    }

    .logout-button:hover .logout-icon {
        transform: rotate(-10deg) scale(1.1);
    }

    /* Mobile responsiveness */
    .mobile-overlay {
        position: fixed;
        inset: 0;
        background: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(4px);
        z-index: 49;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
    }

    .mobile-overlay.active {
        opacity: 1;
        visibility: visible;
    }

    @media (max-width: 768px) {
        .sidebar-container {
            transform: translateX(-100%);
            z-index: 50;
        }

        .sidebar-container.mobile-open {
            transform: translateX(0);
        }
    }

    /* Scrollbar styling */
    .nav-container::-webkit-scrollbar {
        width: 6px;
    }

    .nav-container::-webkit-scrollbar-track {
        background: rgba(51, 65, 85, 0.3);
        border-radius: 3px;
    }

    .nav-container::-webkit-scrollbar-thumb {
        background: linear-gradient(180deg, rgba(59, 130, 246, 0.5), rgba(99, 102, 241, 0.5));
        border-radius: 3px;
    }

    .nav-container::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(180deg, rgba(59, 130, 246, 0.7), rgba(99, 102, 241, 0.7));
    }

    /* Badge for notifications */
    .nav-badge {
        position: absolute;
        top: 0.5rem;
        right: 0.5rem;
        background: linear-gradient(135deg, #ef4444, #dc2626);
        color: white;
        font-size: 0.75rem;
        padding: 0.125rem 0.375rem;
        border-radius: 9999px;
        font-weight: 600;
        animation: pulse 2s infinite;
        box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
    }
</style>

<!-- Mobile Toggle Button (place this outside sidebar) -->
<button id="mobileToggle" class="md:hidden fixed top-4 left-4 z-50 p-2 bg-slate-800 text-blue-400 rounded-lg shadow-lg">
    <i class="fas fa-bars"></i>
</button>

<!-- Mobile Overlay -->
<div id="mobileOverlay" class="mobile-overlay md:hidden"></div>

<!-- Enhanced Sidebar -->
<aside id="adminSidebar" class="sidebar-container w-60 hidden md:flex flex-col fixed h-full">
    <!-- Brand Section -->
    <div class="brand-section p-6 text-center">
        <h1 class="brand-title text-2xl font-bold mb-2">SaleSphere</h1>
        <p class="brand-subtitle text-sm">Admin Panel</p>
        <div class="mt-4 w-12 h-1 bg-gradient-to-r from-blue-500 to-purple-500 rounded mx-auto opacity-60"></div>
    </div>

    <!-- Navigation -->
    <nav class="nav-container flex-1 overflow-y-auto">
        <div class="space-y-1">
            <!-- Properties -->
            <a href="${pageContext.request.contextPath}/admin/property" class="nav-link" data-section="properties">
                <i class="nav-icon fas fa-building"></i>
                <span class="nav-text">Properties</span>
                <span class="nav-badge" style="display: none;">12</span>
            </a>

            <!-- Property Approval -->
            <a href="${pageContext.request.contextPath}/admin/property-approval" class="nav-link" data-section="approval">
                <i class="nav-icon fas fa-check-circle"></i>
                <span class="nav-text">Property Approval</span>
                <span class="nav-badge" style="display: none;">3</span>
            </a>

            <!-- Bookings -->
            <a href="${pageContext.request.contextPath}/admin/booking" class="nav-link" data-section="bookings">
                <i class="nav-icon fas fa-calendar-check"></i>
                <span class="nav-text">Bookings</span>
                <span class="nav-badge" style="display: none;">8</span>
            </a>

            <!-- Users -->
            <a href="${pageContext.request.contextPath}/admin/user" class="nav-link" data-section="users">
                <i class="nav-icon fas fa-users"></i>
                <span class="nav-text">Users</span>
            </a>

            <!-- Admins -->
            <a href="${pageContext.request.contextPath}/admin/admin" class="nav-link" data-section="admins">
                <i class="nav-icon fas fa-users-cog"></i>
                <span class="nav-text">Admins</span>
            </a>

            <!-- Reviews -->
            <a href="${pageContext.request.contextPath}/admin/review" class="nav-link" data-section="reviews">
                <i class="nav-icon fas fa-comment-dots"></i>
                <span class="nav-text">Reviews</span>
                <span class="nav-badge" style="display: none;">4</span>
            </a>
        </div>
    </nav>

    <!-- Logout Section -->
    <div class="logout-section">
        <button id="logoutButton" class="logout-button">
            <i class="logout-icon fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </button>
    </div>
</aside>

<!-- Enhanced JavaScript with modern features -->
<script>
    (function() {
        'use strict';

        // Configuration
        const CONFIG = {
            MOBILE_BREAKPOINT: 768,
            ANIMATION_DURATION: 300,
            LOGOUT_CONFIRMATION: true,
            AUTO_CLOSE_MOBILE: true
        };

        // DOM Elements
        const sidebar = document.getElementById('adminSidebar');
        const mobileToggle = document.getElementById('mobileToggle');
        const mobileOverlay = document.getElementById('mobileOverlay');
        const logoutButton = document.getElementById('logoutButton');
        const navLinks = document.querySelectorAll('.nav-link');

        // State Management
        let isMobileOpen = false;
        let currentSection = '';

        // Utility Functions
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        function isMobile() {
            return window.innerWidth < CONFIG.MOBILE_BREAKPOINT;
        }

        function showNotification(message, type = 'info') {
            // Enhanced notification system (implement based on your needs)
            console.log(`${type.toUpperCase()}: ${message}`);
        }

        // Navigation Highlighting
        function highlightActiveSection() {
            try {
                const fullTitle = document.title || '';
                const pageTitle = fullTitle.includes('|') ? fullTitle.split('|')[1].trim() : fullTitle;

                // Extract section keywords
                const keywords = pageTitle.toLowerCase().split(' ');

                // Remove active class from all links
                navLinks.forEach(link => {
                    link.classList.remove('active');
                });

                // Find and highlight matching section
                navLinks.forEach(link => {
                    const linkText = link.textContent.trim().toLowerCase();
                    const section = link.dataset.section || '';

                    // Check for matches
                    const isMatch = keywords.some(keyword =>
                        linkText.includes(keyword) ||
                        section.includes(keyword) ||
                        keyword.includes(section)
                    );

                    if (isMatch) {
                        link.classList.add('active');
                        currentSection = section;

                        // Smooth scroll to active item if needed
                        if (!isElementInViewport(link)) {
                            link.scrollIntoView({
                                behavior: 'smooth',
                                block: 'center'
                            });
                        }
                    }
                });

            } catch (error) {
                console.warn('Error highlighting active section:', error);
            }
        }

        function isElementInViewport(el) {
            const rect = el.getBoundingClientRect();
            const container = el.closest('.nav-container');
            const containerRect = container.getBoundingClientRect();

            return (
                rect.top >= containerRect.top &&
                rect.bottom <= containerRect.bottom
            );
        }

        // Mobile Navigation
        function toggleMobileNav() {
            isMobileOpen = !isMobileOpen;

            sidebar.classList.toggle('mobile-open', isMobileOpen);
            mobileOverlay.classList.toggle('active', isMobileOpen);
            mobileToggle.innerHTML = isMobileOpen
                ? '<i class="fas fa-times"></i>'
                : '<i class="fas fa-bars"></i>';

            // Prevent body scroll when mobile nav is open
            document.body.style.overflow = isMobileOpen ? 'hidden' : '';

            // Announce to screen readers
            mobileToggle.setAttribute('aria-expanded', isMobileOpen);
        }

        function closeMobileNav() {
            if (isMobileOpen) {
                toggleMobileNav();
            }
        }

        // Logout Functionality
        async function handleLogout() {
            if (CONFIG.LOGOUT_CONFIRMATION) {
                const confirmed = confirm('Are you sure you want to logout?');
                if (!confirmed) return;
            }

            try {
                // Show loading state
                logoutButton.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Logging out...';
                logoutButton.disabled = true;

                // Simulate logout delay (remove in production if not needed)
                await new Promise(resolve => setTimeout(resolve, 800));

                // Redirect to logout endpoint
                window.location.href = '${pageContext.request.contextPath}/admin/logout';

            } catch (error) {
                console.error('Logout error:', error);
                showNotification('Logout failed. Please try again.', 'error');

                // Reset button state
                logoutButton.innerHTML = '<i class="fas fa-sign-out-alt mr-2"></i>Logout';
                logoutButton.disabled = false;
            }
        }

        // Notification System
        async function loadNotificationCounts() {
            try {
                // Simulate API call (replace with actual endpoint)
                const response = await fetch('${pageContext.request.contextPath}/api/notifications/counts');

                if (response.ok) {
                    const data = await response.json();

                    // Update badges
                    updateNotificationBadge('properties', data.properties || 0);
                    updateNotificationBadge('bookings', data.bookings || 0);
                    updateNotificationBadge('reviews', data.reviews || 0);

                }
            } catch (error) {
                console.warn('Failed to load notification counts:', error);
            }
        }

        function updateNotificationBadge(section, count) {
            const link = document.querySelector(`[data-section="${section}"]`);
            const badge = link?.querySelector('.nav-badge');

            if (badge && count > 0) {
                badge.textContent = count > 99 ? '99+' : count.toString();
                badge.style.display = 'block';
            } else if (badge) {
                badge.style.display = 'none';
            }
        }

        // Accessibility
        function setupAccessibility() {
            // ARIA labels
            sidebar.setAttribute('role', 'navigation');
            sidebar.setAttribute('aria-label', 'Main navigation');

            // Keyboard navigation
            navLinks.forEach((link, index) => {
                link.setAttribute('tabindex', '0');

                link.addEventListener('keydown', (e) => {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        link.click();
                    }

                    // Arrow key navigation
                    if (e.key === 'ArrowDown') {
                        e.preventDefault();
                        const nextLink = navLinks[index + 1];
                        nextLink?.focus();
                    }

                    if (e.key === 'ArrowUp') {
                        e.preventDefault();
                        const prevLink = navLinks[index - 1];
                        prevLink?.focus();
                    }
                });
            });

            // Mobile toggle accessibility
            mobileToggle.setAttribute('aria-label', 'Toggle navigation menu');
            mobileToggle.setAttribute('aria-expanded', 'false');
        }

        // Event Listeners
        function setupEventListeners() {
            // Mobile toggle
            mobileToggle?.addEventListener('click', toggleMobileNav);

            // Mobile overlay click
            mobileOverlay?.addEventListener('click', closeMobileNav);

            // Logout button
            logoutButton?.addEventListener('click', handleLogout);

            // Navigation links
            navLinks.forEach(link => {
                link.addEventListener('click', (e) => {
                    // Close mobile nav if open
                    if (CONFIG.AUTO_CLOSE_MOBILE && isMobile()) {
                        closeMobileNav();
                    }

                    // Add loading state for navigation
                    const icon = link.querySelector('.nav-icon');
                    const originalIcon = icon.className;
                    icon.className = 'nav-icon fas fa-spinner fa-spin';

                    // Reset icon after a delay
                    setTimeout(() => {
                        icon.className = originalIcon;
                    }, 500);
                });
            });

            // Window resize handler
            const handleResize = debounce(() => {
                if (!isMobile() && isMobileOpen) {
                    closeMobileNav();
                }
            }, 250);

            window.addEventListener('resize', handleResize);

            // Escape key to close mobile nav
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && isMobileOpen) {
                    closeMobileNav();
                }
            });
        }

        // Performance Optimizations
        function setupPerformanceOptimizations() {
            // Intersection observer for animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate-in');
                    }
                });
            }, { threshold: 0.1 });

            // Observe navigation items
            navLinks.forEach(link => observer.observe(link));

            // Preload critical pages
            const criticalPages = [
                '${pageContext.request.contextPath}/admin/property',
                '${pageContext.request.contextPath}/admin/booking',
                '${pageContext.request.contextPath}/admin/user'
            ];

            criticalPages.forEach(page => {
                const link = document.createElement('link');
                link.rel = 'prefetch';
                link.href = page;
                document.head.appendChild(link);
            });
        }

        // Theme Management
        function initializeTheme() {
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            document.documentElement.classList.toggle('dark', prefersDark);

            // Listen for system theme changes
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                document.documentElement.classList.toggle('dark', e.matches);
            });
        }

        // Main Initialization
        function initialize() {
            console.log('Initializing modern admin sidebar...');

            // Set up accessibility
            setupAccessibility();

            // Initialize theme
            initializeTheme();

            // Set up event listeners
            setupEventListeners();

            // Highlight active section
            setTimeout(highlightActiveSection, 100);

            // Performance optimizations
            setupPerformanceOptimizations();

            // Load notification counts
            setTimeout(loadNotificationCounts, 1000);

            console.log('Modern admin sidebar initialized successfully');
        }

        // Initialize when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initialize);
        } else {
            initialize();
        }

        // Global error handling
        window.addEventListener('error', (e) => {
            console.error('Sidebar error:', e.error);
        });

        // Expose public API for external use
        window.AdminSidebar = {
            highlightSection: highlightActiveSection,
            closeMobileNav: closeMobileNav,
            updateBadge: updateNotificationBadge
        };

    })();
</script>

<%-- Backend Integration Notes:

1. Session Management:
   - Add user role checking: ${sessionScope.role}
   - Conditional navigation based on permissions

2. Security:
   - CSRF protection for logout
   - XSS prevention with proper encoding
   - Session validation

3. API Endpoints to implement:
   - /api/notifications/counts - GET notification counts
   - /admin/logout - POST logout endpoint
   - /api/user/permissions - GET user permissions

4. Database Integration:
   - User preferences (collapsed state, theme)
   - Navigation permissions by role
   - Notification counts

5. Example Servlet Code:

   @WebServlet("/api/notifications/counts")
   public class NotificationCountsServlet extends HttpServlet {
       protected void doGet(HttpServletRequest request, HttpServletResponse response) {
           HttpSession session = request.getSession();
           String adminId = (String) session.getAttribute("adminId");

           // Get counts from database
           Map<String, Integer> counts = notificationService.getCounts(adminId);

           response.setContentType("application/json");
           Gson gson = new Gson();
           response.getWriter().write(gson.toJson(counts));
       }
   }

6. Security Configuration:
   - Role-based navigation filtering
   - Menu item permissions
   - Audit logging for navigation events
--%>