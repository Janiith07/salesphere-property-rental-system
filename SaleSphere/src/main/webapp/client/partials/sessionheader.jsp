<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RentSphere - Modern Header</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/client/assets/favicon.png" type="image/png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        
        * {
            font-family: 'Inter', sans-serif;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.8;
            }
        }
        
        @keyframes bounce {
            0%, 20%, 53%, 80%, 100% {
                transform: translate3d(0,0,0);
            }
            40%, 43% {
                transform: translate3d(0, -6px, 0);
            }
            70% {
                transform: translate3d(0, -3px, 0);
            }
            90% {
                transform: translate3d(0, -1px, 0);
            }
        }
        
        @keyframes glow {
            0%, 100% {
                box-shadow: 0 0 15px rgba(20, 184, 166, 0.3);
            }
            50% {
                box-shadow: 0 0 25px rgba(20, 184, 166, 0.6);
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

        @keyframes gradientShift {
            0%, 100% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
        }
        
        .glass-nav {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(30, 41, 59, 0.9));
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(148, 163, 184, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .nav-link {
            position: relative;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 10px 16px;
            border-radius: 12px;
            overflow: hidden;
        }
        
        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(20, 184, 166, 0.1), rgba(56, 189, 248, 0.1));
            border-radius: 12px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .nav-link:hover::before {
            opacity: 1;
        }
        
        .nav-link:hover {
            color: #14b8a6;
            transform: translateY(-2px);
        }

        .brand-logo {
            background: linear-gradient(45deg,
            #06b6d4,
            #3b82f6,
            #8b5cf6,
            #ec4899,
            #06b6d4
            );
            background-size: 300% 300%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            animation: brandPulse 4s ease-in-out infinite;
            position: relative;
        }
        .brand-logo::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg,
            rgba(6, 182, 212, 0.2),
            rgba(59, 130, 246, 0.2),
            rgba(139, 92, 246, 0.2),
            rgba(236, 72, 153, 0.2)
            );
            border-radius: 12px;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }
        .brand-logo:hover::after {
            opacity: 1;
        }
        .brand-logo:hover {
            transform: scale(1.05) translateY(-1px);
            filter: brightness(1.2);
        }
        @keyframes brandPulse {
            0%, 100% {
                background-position: 0% 50%;
                filter: hue-rotate(0deg);
            }
            50% {
                background-position: 100% 50%;
                filter: hue-rotate(90deg);
            }
        }
        
        .auth-btn {
            position: relative;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 12px;
            backdrop-filter: blur(10px);
        }
        
        .auth-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .auth-btn:hover::before {
            left: 100%;
        }
        
        .auth-btn:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }
        
        .user-menu-btn {
            position: relative;
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
            border: 1px solid rgba(148, 163, 184, 0.2);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            border-radius: 12px;
            padding: 8px 12px;
        }
        
        .user-menu-btn:hover {
            background: linear-gradient(135deg, rgba(20, 184, 166, 0.2), rgba(30, 41, 59, 0.9));
            border-color: rgba(20, 184, 166, 0.4);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(20, 184, 166, 0.2);
        }
        
        .user-dropdown {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(248, 250, 252, 0.98));
            backdrop-filter: blur(20px);
            border: 1px solid rgba(148, 163, 184, 0.2);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
            animation: slideDown 0.3s ease-out;
            border-radius: 16px;
        }
        
        .dropdown-item {
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            border-radius: 8px;
            margin: 4px;
        }
        
        .dropdown-item:hover {
            background: linear-gradient(135deg, rgba(20, 184, 166, 0.1), rgba(56, 189, 248, 0.05));
            border-left-color: #14b8a6;
            transform: translateX(4px);
        }
        
        .mobile-menu {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.98), rgba(30, 41, 59, 0.95));
            backdrop-filter: blur(20px);
            border-top: 1px solid rgba(148, 163, 184, 0.1);
            animation: slideDown 0.3s ease-out;
        }
        
        .search-container {
            background: rgba(30, 41, 59, 0.6);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(148, 163, 184, 0.2);
            transition: all 0.3s ease;
            border-radius: 12px;
        }
        
        .search-container:focus-within {
            border-color: #14b8a6;
            box-shadow: 0 0 20px rgba(20, 184, 166, 0.2);
            background: rgba(30, 41, 59, 0.8);
        }
        
        .loading-bar {
            height: 3px;
            background: linear-gradient(90deg, #14b8a6, #06b6d4, #3b82f6);
            background-size: 200% 100%;
            animation: shimmer 1.5s ease-in-out infinite;
        }

        .avatar-glow {
            border: 2px solid transparent;
            background: linear-gradient(135deg, #14b8a6, #06b6d4) border-box;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .avatar-glow:hover {
            box-shadow: 0 0 20px rgba(20, 184, 166, 0.4);
            transform: scale(1.1);
        }

        .notification-badge {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            box-shadow: 0 0 10px rgba(239, 68, 68, 0.5);
            animation: pulse 2s infinite;
        }
        
        @media (max-width: 768px) {
            .nav-link {
                padding: 12px 16px;
                border-bottom: 1px solid rgba(148, 163, 184, 0.1);
                border-radius: 0;
            }
        }

        /* Floating elements for background */
        .floating-element {
            position: absolute;
            border-radius: 50%;
            opacity: 0.1;
            pointer-events: none;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(180deg);
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 min-h-screen">
    <!-- Loading Bar -->
    <div id="loadingBar" class="loading-bar fixed top-0 left-0 w-0 z-[60] transition-all duration-300"></div>
    
    <!-- Floating Background Elements -->
    <div class="floating-element w-32 h-32 bg-teal-400 top-20 left-10" style="animation-delay: 0s;"></div>
    <div class="floating-element w-24 h-24 bg-blue-400 top-40 right-20" style="animation-delay: -2s;"></div>
    <div class="floating-element w-20 h-20 bg-purple-400 top-60 left-1/3" style="animation-delay: -4s;"></div>

    <header class="text-white relative">
        <nav class="glass-nav sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-20">
                    
                    <!-- Brand -->
                    <a href="${pageContext.request.contextPath}/"
                       class="flex items-center space-x-3 text-2xl font-bold brand-logo hover:scale-105 transition-transform duration-300 z-10">
                        <div class="relative">
                            <i class="fas fa-building-user text-3xl drop-shadow-lg"></i>
                            <div class="absolute -top-1 -right-1 w-4 h-4 bg-gradient-to-r from-green-400 to-emerald-500 rounded-full animate-pulse shadow-lg"></div>
                            <div class="absolute -bottom-1 -left-1 w-2 h-2 bg-gradient-to-r from-blue-400 to-cyan-500 rounded-full animate-ping"></div>
                        </div>
                        <span class="bg-gradient-to-r from-cyan-400 via-blue-500 via-purple-500 to-pink-500 bg-clip-text text-transparent font-extrabold tracking-wide">
                            SaleSphere
                        </span>
                    </a>
                    
                    <!-- Search Bar (Desktop) -->
                    <div class="hidden lg:flex flex-1 max-w-md mx-8">
                        <div class="search-container w-full px-4 py-3 flex items-center">
                            <i class="fas fa-search text-gray-400 mr-3"></i>
                            <input type="text" placeholder="Search properties..." 
                                   class="bg-transparent text-white placeholder-gray-400 w-full outline-none">
                        </div>
                    </div>
                    
                    <!-- Navigation Links -->
                    <div class="hidden md:flex space-x-2 text-gray-300">
                        <a href="${pageContext.request.contextPath}/" 
                           class="nav-link hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-home mr-2"></i>Home
                        </a>
                        <a href="${pageContext.request.contextPath}/properties" 
                           class="nav-link hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-building mr-2"></i>Properties
                        </a>
                        <a href="${pageContext.request.contextPath}/about" 
                           class="nav-link hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-info-circle mr-2"></i>About
                        </a>
                        <a href="${pageContext.request.contextPath}/contact" 
                           class="nav-link hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-envelope mr-2"></i>Contact
                        </a>
                    </div>
                    
                    <!-- Right Section -->
                    <div class="flex items-center space-x-4">
                        
                        <!-- User Menu (Only show if logged in) -->
                        <c:if test="${not empty sessionScope.user}">
                            <div class="relative">
                                <button onclick="toggleUserMenu()" 
                                        class="user-menu-btn flex items-center space-x-3 hover:text-teal-300 focus:outline-none">
                                    <div class="relative">
                                        <img src="https://ui-avatars.com/api/?name=${sessionScope.name}&background=334155&color=fff&size=40"
                                             alt="${sessionScope.name}" 
                                             class="w-10 h-10 rounded-full avatar-glow">
                                        <div class="absolute -bottom-1 -right-1">
                                            <div class="w-4 h-4 bg-green-400 rounded-full border-2 border-slate-900"></div>
                                        </div>
                                    </div>
                                    <div class="hidden sm:block">
                                        <span class="text-sm font-medium">${sessionScope.name}</span>
                                        <div class="text-xs text-gray-400">Online</div>
                                    </div>
                                    <i class="fas fa-chevron-down text-sm transition-transform duration-300" id="chevronIcon"></i>
                                </button>

                                <!-- Enhanced Dropdown -->
                                <div id="userDropdown" 
                                     class="user-dropdown hidden absolute right-0 mt-3 w-64 text-gray-800 z-50 overflow-hidden">
                                    
                                    <!-- User Info Header -->
                                    <div class="px-4 py-4 border-b border-gray-200 bg-gradient-to-r from-teal-50 to-blue-50">
                                        <div class="flex items-center space-x-3">
                                            <img src="https://ui-avatars.com/api/?name=${sessionScope.name}&background=14b8a6&color=fff&size=48"
                                                 alt="${sessionScope.name}" class="w-12 h-12 rounded-full">
                                            <div>
                                                <p class="font-semibold text-gray-900">${sessionScope.name}</p>
                                                <p class="text-sm text-gray-600">${sessionScope.email}</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Menu Items -->
                                    <div class="py-2">
                                        <a href="${pageContext.request.contextPath}/profile" 
                                           class="dropdown-item flex items-center px-4 py-3 hover:bg-gray-50 group">
                                            <div class="w-8 h-8 bg-teal-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-teal-200 transition-colors">
                                                <i class="fas fa-user text-teal-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-medium">Profile</div>
                                                <div class="text-xs text-gray-500">Manage your account</div>
                                            </div>
                                        </a>
                                        
                                        <a href="${pageContext.request.contextPath}/my-bookings" 
                                           class="dropdown-item flex items-center px-4 py-3 hover:bg-gray-50 group">
                                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-blue-200 transition-colors">
                                                <i class="fas fa-calendar-check text-blue-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-medium">My Bookings</div>
                                                <div class="text-xs text-gray-500">View reservations</div>
                                            </div>
                                        </a>
                                        
                                        <a href="${pageContext.request.contextPath}/settings" 
                                           class="dropdown-item flex items-center px-4 py-3 hover:bg-gray-50 group">
                                            <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-purple-200 transition-colors">
                                                <i class="fas fa-cog text-purple-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-medium">Settings</div>
                                                <div class="text-xs text-gray-500">Preferences & privacy</div>
                                            </div>
                                        </a>
                                    </div>
                                    
                                    <!-- Logout Section -->
                                    <div class="border-t border-gray-200 py-2">
                                        <a href="${pageContext.request.contextPath}/logout" 
                                           class="dropdown-item flex items-center px-4 py-3 text-red-600 hover:bg-red-50 group">
                                            <div class="w-8 h-8 bg-red-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-red-200 transition-colors">
                                                <i class="fas fa-sign-out-alt text-red-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-medium">Sign Out</div>
                                                <div class="text-xs text-red-400">Logout from account</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Auth Buttons (Only show if NOT logged in) -->
                        <c:if test="${empty sessionScope.user}">
                            <div class="hidden md:flex items-center space-x-3">
                                <a href="${pageContext.request.contextPath}/login" 
                                   class="auth-btn flex items-center gap-2 px-6 py-3 text-sm font-medium text-white bg-gradient-to-r from-teal-600 to-teal-500 rounded-xl hover:from-teal-500 hover:to-teal-400 transition-all duration-300">
                                    <i class="fas fa-sign-in-alt"></i> 
                                    Login
                                </a>
                                <a href="${pageContext.request.contextPath}/register" 
                                   class="auth-btn flex items-center gap-2 px-6 py-3 text-sm font-medium text-slate-900 bg-gradient-to-r from-white to-gray-100 rounded-xl hover:from-gray-100 hover:to-white transition-all duration-300">
                                    <i class="fas fa-user-plus"></i> 
                                    Register
                                </a>
                            </div>
                        </c:if>
                        
                        <!-- Mobile Menu Button -->
                        <button id="mobileMenuBtn" 
                                class="md:hidden user-menu-btn p-3 rounded-xl">
                            <i class="fas fa-bars text-gray-300"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Mobile Menu -->
                <div id="mobileMenu" class="mobile-menu md:hidden hidden">
                    <div class="px-4 py-6 space-y-4">
                        <!-- Search Bar (Mobile) -->
                        <div class="search-container px-4 py-3 flex items-center mb-6">
                            <i class="fas fa-search text-gray-400 mr-3"></i>
                            <input type="text" placeholder="Search properties..." 
                                   class="bg-transparent text-white placeholder-gray-400 w-full outline-none">
                        </div>
                        
                        <!-- Navigation Links -->
                        <a href="${pageContext.request.contextPath}/" 
                           class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-home mr-3"></i>Home
                        </a>
                        <a href="${pageContext.request.contextPath}/properties" 
                           class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-building mr-3"></i>Properties
                        </a>
                        <a href="${pageContext.request.contextPath}/about" 
                           class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-info-circle mr-3"></i>About
                        </a>
                        <a href="${pageContext.request.contextPath}/contact" 
                           class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                            <i class="fas fa-envelope mr-3"></i>Contact
                        </a>
                        
                        <!-- Mobile Auth/User Section -->
                        <div class="pt-4 border-t border-gray-700 space-y-3">
                            <c:if test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/login" 
                                   class="auth-btn flex items-center justify-center gap-2 w-full px-5 py-3 text-sm font-medium text-white bg-gradient-to-r from-teal-600 to-teal-500 rounded-xl">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a>
                                <a href="${pageContext.request.contextPath}/register" 
                                   class="auth-btn flex items-center justify-center gap-2 w-full px-5 py-3 text-sm font-medium text-slate-900 bg-gradient-to-r from-white to-gray-100 rounded-xl">
                                    <i class="fas fa-user-plus"></i> Register
                                </a>
                            </c:if>
                            
                            <c:if test="${not empty sessionScope.user}">
                                <div class="text-center py-4">
                                    <img src="https://ui-avatars.com/api/?name=${sessionScope.name}&background=14b8a6&color=fff&size=60"
                                         alt="${sessionScope.name}" class="w-15 h-15 rounded-full mx-auto mb-2">
                                    <div class="text-white font-medium">${sessionScope.name}</div>
                                    <div class="text-gray-400 text-sm">${sessionScope.email}</div>
                                </div>
                                <div class="space-y-2">
                                    <a href="${pageContext.request.contextPath}/profile" 
                                       class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                                        <i class="fas fa-user mr-3"></i>Profile
                                    </a>
                                    <a href="${pageContext.request.contextPath}/my-bookings" 
                                       class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                                        <i class="fas fa-calendar-check mr-3"></i>My Bookings
                                    </a>
                                    <a href="${pageContext.request.contextPath}/settings" 
                                       class="nav-link block text-gray-300 hover:text-teal-400 transition flex items-center">
                                        <i class="fas fa-cog mr-3"></i>Settings
                                    </a>
                                    <a href="${pageContext.request.contextPath}/logout" 
                                       class="nav-link block text-red-400 hover:text-red-300 transition flex items-center">
                                        <i class="fas fa-sign-out-alt mr-3"></i>Logout
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </header>
    <script>
        // Loading bar animation
        function showLoadingBar() {
            const loadingBar = document.getElementById('loadingBar');
            loadingBar.style.width = '30%';
            setTimeout(() => {
                loadingBar.style.width = '70%';
                setTimeout(() => {
                    loadingBar.style.width = '100%';
                    setTimeout(() => {
                        loadingBar.style.width = '0%';
                    }, 200);
                }, 500);
            }, 300);
        }

        // User menu toggle
        function toggleUserMenu() {
            const dropdown = document.getElementById('userDropdown');
            const chevron = document.getElementById('chevronIcon');
            
            dropdown.classList.toggle('hidden');
            
            // Animate chevron
            if (dropdown.classList.contains('hidden')) {
                chevron.style.transform = 'rotate(0deg)';
            } else {
                chevron.style.transform = 'rotate(180deg)';
            }
        }

        // Mobile menu functionality
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const mobileMenu = document.getElementById('mobileMenu');

        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
            
            const icon = mobileMenuBtn.querySelector('i');
            if (mobileMenu.classList.contains('hidden')) {
                icon.className = 'fas fa-bars text-gray-300';
            } else {
                icon.className = 'fas fa-times text-gray-300';
            }
        });

        // Close dropdowns when clicking outside
        document.addEventListener('click', (event) => {
            const userDropdown = document.getElementById('userDropdown');
            const userMenuBtn = event.target.closest('.user-menu-btn');
            
            if (!userMenuBtn && !event.target.closest('#userDropdown')) {
                userDropdown?.classList.add('hidden');
                const chevron = document.getElementById('chevronIcon');
                if (chevron) chevron.style.transform = 'rotate(0deg)';
            }
        });

        // Search functionality with keyboard shortcut
        document.addEventListener('keydown', (e) => {
            if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
                e.preventDefault();
                const searchInput = document.querySelector('input[placeholder="Search properties..."]');
                searchInput?.focus();
            }
        });

        // Add click animations to all buttons
        document.querySelectorAll('.auth-btn, .nav-link').forEach(btn => {
            btn.addEventListener('click', (e) => {
                showLoadingBar();
                
                // Ripple effect
                const ripple = document.createElement('span');
                const rect = btn.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                ripple.style.cssText = `
                    position: absolute;
                    border-radius: 50%;
                    background: rgba(255, 255, 255, 0.4);
                    transform: scale(0);
                    animation: ripple-animation 0.6s linear;
                    pointer-events: none;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${e.clientX - rect.left - size / 2}px;
                    top: ${e.clientY - rect.top - size / 2}px;
                `;
                
                btn.style.position = 'relative';
                btn.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Add ripple animation styles
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple-animation {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Add scroll effect to navbar
        let lastScrollTop = 0;
        const navbar = document.querySelector('nav');
        
        window.addEventListener('scroll', () => {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            
            if (scrollTop > lastScrollTop && scrollTop > 100) {
                // Scrolling down
                navbar.style.transform = 'translateY(-100%)';
            } else {
                // Scrolling up
                navbar.style.transform = 'translateY(0)';
            }
            
            lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
        });

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>