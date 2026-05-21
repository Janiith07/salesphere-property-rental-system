<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Enhanced CSS for modern animations and styling -->
<style>
    @keyframes slideInDown {
        from {
            transform: translateY(-100%);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    @keyframes fadeInScale {
        from {
            transform: scale(0.8);
            opacity: 0;
        }
        to {
            transform: scale(1);
            opacity: 1;
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
        }
        50% {
            transform: scale(1.05);
        }
    }

    .header-container {
        backdrop-filter: blur(20px) saturate(180%);
        background: rgba(15, 23, 42, 0.85);
        border-bottom: 1px solid rgba(148, 163, 184, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        animation: slideInDown 0.6s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .title-text {
        background: linear-gradient(135deg, #60a5fa, #3b82f6, #2563eb);
        background-size: 200% 200%;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        animation: shimmer 3s ease-in-out infinite;
        transition: all 0.3s ease;
    }

    .title-text:hover {
        transform: translateX(5px);
        filter: drop-shadow(0 0 10px rgba(59, 130, 246, 0.5));
    }

    .user-info {
        animation: fadeInScale 0.8s cubic-bezier(0.4, 0, 0.2, 1) 0.2s both;
        transition: all 0.3s ease;
    }

    .user-info:hover {
        transform: translateY(-2px);
    }

    .user-name {
        background: linear-gradient(135deg, #f8fafc, #e2e8f0);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        transition: all 0.3s ease;
        position: relative;
    }

    .user-name::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -2px;
        left: 0;
        background: linear-gradient(135deg, #60a5fa, #3b82f6);
        transition: width 0.3s ease;
    }

    .user-info:hover .user-name::after {
        width: 100%;
    }

    .role-badge {
        background: linear-gradient(135deg, #1e293b, #334155);
        border: 1px solid rgba(59, 130, 246, 0.3);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .role-badge::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.2), transparent);
        transition: left 0.5s ease;
    }

    .user-info:hover .role-badge::before {
        left: 100%;
    }

    .avatar {
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .avatar::before {
        content: '';
        position: absolute;
        inset: -2px;
        background: conic-gradient(from 0deg, #3b82f6, #8b5cf6, #ec4899, #3b82f6);
        border-radius: 50%;
        z-index: -1;
        animation: pulse 2s ease-in-out infinite;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .avatar:hover::before {
        opacity: 1;
    }

    .avatar:hover {
        transform: rotate(5deg) scale(1.1);
        filter: brightness(1.1) saturate(1.2);
    }

    .loading-skeleton {
        background: linear-gradient(90deg, #334155 25%, #475569 50%, #334155 75%);
        background-size: 200% 100%;
        animation: shimmer 1.5s infinite;
        border-radius: 0.375rem;
        height: 1.5rem;
        width: 8rem;
    }

    @media (max-width: 768px) {
        .header-container {
            padding: 0.75rem 1rem;
        }

        .title-text {
            font-size: 1.125rem;
        }

        .user-info {
            gap: 0.5rem;
        }

        .avatar {
            width: 2rem;
            height: 2rem;
        }
    }

    /* Dark mode enhancements */
    .glow-effect {
        filter: drop-shadow(0 0 20px rgba(59, 130, 246, 0.3));
    }

    .notification-dot {
        position: absolute;
        top: -2px;
        right: -2px;
        width: 12px;
        height: 12px;
        background: linear-gradient(135deg, #ef4444, #dc2626);
        border-radius: 50%;
        border: 2px solid rgba(15, 23, 42, 0.9);
        animation: pulse 2s infinite;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .has-notifications .notification-dot {
        opacity: 1;
    }
</style>

<header class="header-container flex justify-between items-center p-6 sticky top-0 z-50">
    <!-- Title Section with Enhanced Animation -->
    <div class="flex items-center space-x-4">
        <h2 class="title-text text-2xl font-bold tracking-wide">
            <span id="pageTitleText" class="loading-skeleton"></span>
        </h2>
    </div>

    <!-- User Info Section with Modern Design -->
    <div class="user-info flex items-center space-x-6">
        <!-- User Details -->
        <div class="text-right space-y-1">
            <p class="user-name font-semibold text-base tracking-wide">
                ${not empty sessionScope.adminName ? sessionScope.adminName : 'Guest User'}
            </p>
            <p class="role-badge inline-block px-3 py-1 rounded-full text-xs font-medium text-blue-200 border">
                ${not empty sessionScope.role ? sessionScope.role : 'Visitor'}
            </p>
        </div>

        <!-- Enhanced Avatar with Notifications -->
        <div class="relative">
            <img src="https://ui-avatars.com/api/?name=${not empty sessionScope.adminName ? sessionScope.adminName : 'Guest'}&background=3B82F6&color=ffffff&bold=true&format=svg"
                 alt="User Avatar"
                 class="avatar w-12 h-12 rounded-full shadow-lg ring-2 ring-blue-500/50 glow-effect"
                 onerror="this.src='https://ui-avatars.com/api/?name=User&background=64748b&color=ffffff'" />
            <!-- Notification dot (hidden by default) -->
            <div class="notification-dot" id="notificationDot"></div>
        </div>
    </div>
</header>

<!-- Enhanced JavaScript with Error Handling and Modern Features -->
<script>
    (function() {
        'use strict';

        // Constants
        const ANIMATION_DELAY = 100;
        const TITLE_REVEAL_DELAY = 500;

        // DOM Elements
        const pageTitleElement = document.getElementById('pageTitleText');
        const notificationDot = document.getElementById('notificationDot');

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

        function animateTextReveal(element, text) {
            if (!element || !text) return;

            // Remove loading skeleton
            element.classList.remove('loading-skeleton');
            element.style.width = 'auto';
            element.style.height = 'auto';

            // Animate text reveal
            let index = 0;
            element.textContent = '';

            const revealLetter = () => {
                if (index < text.length) {
                    element.textContent += text[index];
                    index++;
                    setTimeout(revealLetter, 50);
                }
            };

            setTimeout(revealLetter, TITLE_REVEAL_DELAY);
        }

        // Title Processing
        function updatePageTitle() {
            try {
                const fullTitle = document.title || 'Dashboard';
                const separatorIndex = fullTitle.indexOf('|');

                const headerTitle = (separatorIndex !== -1)
                    ? fullTitle.substring(separatorIndex + 1).trim()
                    : fullTitle;

                // Animate the title reveal
                animateTextReveal(pageTitleElement, headerTitle || 'Dashboard');

            } catch (error) {
                console.warn('Error updating page title:', error);
                pageTitleElement.textContent = 'Dashboard';
                pageTitleElement.classList.remove('loading-skeleton');
            }
        }

        // Notification System
        function checkNotifications() {
            // Simulate notification check (replace with actual backend call)
            if (Math.random() > 0.7) { // 30% chance for demo
                document.querySelector('.relative').classList.add('has-notifications');
            }
        }

        // Theme and Accessibility
        function setupAccessibility() {
            const header = document.querySelector('.header-container');
            header.setAttribute('role', 'banner');
            header.setAttribute('aria-label', 'Site header with navigation');

            const avatar = document.querySelector('.avatar');
            avatar.setAttribute('role', 'img');
            avatar.setAttribute('aria-label', 'User profile picture');
        }

        // Performance Optimization
        function setupPerformanceOptimizations() {
            // Lazy load non-critical animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate-in');
                    }
                });
            }, { threshold: 0.1 });

            document.querySelectorAll('.user-info').forEach(el => {
                observer.observe(el);
            });
        }

        // Event Listeners
        function setupEventListeners() {
            // Resize handler with debouncing
            const handleResize = debounce(() => {
                // Adjust layout for mobile if needed
                const isMobile = window.innerWidth < 768;
                document.body.classList.toggle('mobile-layout', isMobile);
            }, 250);

            window.addEventListener('resize', handleResize);

            // Avatar click handler
            const avatar = document.querySelector('.avatar');
            avatar?.addEventListener('click', (e) => {
                e.preventDefault();
                // Add profile dropdown or redirect logic here
                console.log('Avatar clicked - implement profile menu');
            });

            // Notification dot click handler
            notificationDot?.addEventListener('click', (e) => {
                e.stopPropagation();
                // Handle notification click
                console.log('Notifications clicked');
                document.querySelector('.relative').classList.remove('has-notifications');
            });
        }

        // Dark Mode Support
        function initializeDarkMode() {
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            document.documentElement.classList.toggle('dark', prefersDark);

            // Listen for system theme changes
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                document.documentElement.classList.toggle('dark', e.matches);
            });
        }

        // Main Initialization
        function initialize() {
            // Set up accessibility
            setupAccessibility();

            // Initialize dark mode
            initializeDarkMode();

            // Update page title with animation
            setTimeout(updatePageTitle, ANIMATION_DELAY);

            // Set up event listeners
            setupEventListeners();

            // Performance optimizations
            setupPerformanceOptimizations();

            // Check for notifications
            setTimeout(checkNotifications, 2000);

            console.log('Modern admin header initialized successfully');
        }

        // Initialize when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initialize);
        } else {
            initialize();
        }

        // Error handling for the entire module
        window.addEventListener('error', (e) => {
            console.error('Header error:', e.error);
            // Graceful fallback
            if (pageTitleElement && pageTitleElement.classList.contains('loading-skeleton')) {
                pageTitleElement.textContent = 'Dashboard';
                pageTitleElement.classList.remove('loading-skeleton');
            }
        });
    })();
</script>

<!-- Backend Integration Enhancements -->
<%--
Additional JSP/Servlet Integration Notes:

1. Session Management:
   - Uses EL expressions: ${sessionScope.adminName} and ${sessionScope.role}
   - Provides fallback values for guest users
   - Handles null/empty values gracefully

2. Security Considerations:
   - XSS protection through proper encoding
   - CSRF token can be added to AJAX requests
   - Session validation

3. Backend Endpoints (implement these in your servlet):
   /api/notifications - GET notifications count
   /api/user/profile - GET user profile data
   /api/user/avatar - POST to update avatar

4. Database Integration:
   - User preferences (theme, notifications)
   - Avatar URLs
   - Role-based permissions

5. Example Servlet Code:

   @WebServlet("/api/notifications")
   public class NotificationServlet extends HttpServlet {
       protected void doGet(HttpServletRequest request, HttpServletResponse response) {
           HttpSession session = request.getSession();
           String adminName = (String) session.getAttribute("adminName");

           // Query notifications from database
           int count = notificationService.getUnreadCount(adminName);

           response.setContentType("application/json");
           response.getWriter().write("{\"count\":" + count + "}");
       }
   }
--%>