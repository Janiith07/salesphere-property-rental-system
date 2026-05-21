<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SaleSphere - Modern Header</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="client/css/header.css">
    <link rel="icon" href="${pageContext.request.contextPath}/client/assets/favicon.png" type="image/png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
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
        @keyframes floatingElements {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-10px) rotate(120deg); }
            66% { transform: translateY(-5px) rotate(240deg); }
        }
        .floating-orb {
            position: absolute;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%,
            rgba(6, 182, 212, 0.1),
            rgba(59, 130, 246, 0.05),
            transparent 70%
            );
            animation: floatingElements 6s ease-in-out infinite;
            pointer-events: none;
        }
        .floating-orb:nth-child(1) {
            top: 10%;
            left: 20%;
            animation-delay: 0s;
        }
        .floating-orb:nth-child(2) {
            top: 60%;
            right: 15%;
            animation-delay: 2s;
            background: radial-gradient(circle at 30% 30%,
            rgba(139, 92, 246, 0.1),
            rgba(236, 72, 153, 0.05),
            transparent 70%
            );
        }
        .floating-orb:nth-child(3) {
            bottom: 20%;
            left: 60%;
            animation-delay: 4s;
            background: radial-gradient(circle at 30% 30%,
            rgba(245, 158, 11, 0.1),
            rgba(248, 113, 113, 0.05),
            transparent 70%
            );
        }
        .glass-nav {
            background: linear-gradient(135deg,
            rgba(6, 182, 212, 0.1),
            rgba(59, 130, 246, 0.08),
            rgba(147, 51, 234, 0.1),
            rgba(236, 72, 153, 0.08)
            );
            backdrop-filter: blur(25px) saturate(180%);
            border-bottom: 1px solid rgba(148, 163, 184, 0.2);
            box-shadow:
                    0 8px 32px rgba(0, 0, 0, 0.3),
                    0 2px 16px rgba(6, 182, 212, 0.1),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            position: relative;
            overflow: hidden;
        }
        .glass-nav::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(255, 255, 255, 0.05),
            transparent
            );
            animation: navShimmer 4s ease-in-out infinite;
        }
        @keyframes navShimmer {
            0%, 100% { left: -100%; }
            50% { left: 100%; }
        }
        .nav-link {
            position: relative;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 10px 18px;
            border-radius: 12px;
            background: linear-gradient(135deg, transparent, transparent);
            overflow: hidden;
        }
        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg,
            transparent,
            rgba(20, 184, 166, 0.15),
            rgba(59, 130, 246, 0.15),
            transparent
            );
            border-radius: 12px;
            transition: left 0.5s ease;
            z-index: -1;
        }
        .nav-link::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: radial-gradient(circle, rgba(20, 184, 166, 0.3), transparent 70%);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.4s ease;
            z-index: -1;
        }
        .nav-link:hover::before {
            left: 100%;
        }
        .nav-link:hover::after {
            width: 100%;
            height: 100%;
        }
        .nav-link:hover {
            color: #06b6d4;
            transform: translateY(-3px) scale(1.02);
            box-shadow:
                    0 8px 25px rgba(6, 182, 212, 0.2),
                    0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .nav-link i {
            transition: all 0.3s ease;
        }
        .nav-link:hover i {
            transform: scale(1.1);
            color: #3b82f6;
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
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 16px;
            backdrop-filter: blur(15px);
            border: 2px solid transparent;
            background-clip: padding-box;
        }
        .auth-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(255, 255, 255, 0.3),
            transparent
            );
            transition: left 0.6s ease;
        }
        .auth-btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.5s ease;
        }
        .auth-btn:hover::before {
            left: 100%;
        }
        .auth-btn:hover::after {
            width: 300%;
            height: 300%;
        }
        .auth-btn:hover {
            transform: translateY(-4px) scale(1.05);
            box-shadow:
                    0 12px 35px rgba(0, 0, 0, 0.4),
                    0 6px 20px rgba(6, 182, 212, 0.2);
        }
        .seller-btn {
            background: linear-gradient(135deg,
            #f59e0b,
            #ec4899,
            #8b5cf6,
            #f59e0b
            );
            background-size: 300% 300%;
            border: 3px solid transparent;
            background-clip: padding-box;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 16px;
            backdrop-filter: blur(15px);
            animation: sellerGlow 3s ease-in-out infinite;
        }
        .seller-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(255, 255, 255, 0.4),
            transparent
            );
            transition: left 0.6s ease;
        }
        .seller-btn::after {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: 16px;
            background: linear-gradient(45deg,
            rgba(245, 158, 11, 0.8),
            rgba(236, 72, 153, 0.8),
            rgba(139, 92, 246, 0.8)
            );
            background-size: 300% 300%;
            animation: sellerBorder 4s ease-in-out infinite;
            z-index: -2;
        }
        .seller-btn:hover::before {
            left: 100%;
        }
        .seller-btn:hover {
            transform: translateY(-4px) scale(1.08) rotate(-1deg);
            box-shadow:
                    0 15px 40px rgba(245, 158, 11, 0.4),
                    0 8px 25px rgba(236, 72, 153, 0.3);
            filter: brightness(1.2) saturate(1.3);
        }
        @keyframes sellerGlow {
            0%, 100% {
                background-position: 0% 50%;
                box-shadow: 0 0 20px rgba(245, 158, 11, 0.3);
            }
            50% {
                background-position: 100% 50%;
                box-shadow: 0 0 30px rgba(236, 72, 153, 0.4);
            }
        }
        @keyframes sellerBorder {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        .notification-btn {
            position: relative;
            background: linear-gradient(135deg,
            rgba(30, 41, 59, 0.9),
            rgba(15, 23, 42, 0.95)
            );
            border: 2px solid rgba(148, 163, 184, 0.3);
            backdrop-filter: blur(15px);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: visible;
        }
        .notification-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: radial-gradient(circle, rgba(6, 182, 212, 0.2), transparent);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.4s ease;
        }
        .notification-btn:hover::before {
            width: 200%;
            height: 200%;
        }
        .notification-btn:hover {
            background: linear-gradient(135deg,
            rgba(6, 182, 212, 0.2),
            rgba(30, 41, 59, 0.9)
            );
            border-color: rgba(6, 182, 212, 0.5);
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 8px 25px rgba(6, 182, 212, 0.3);
        }
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 18px;
            height: 18px;
            background: linear-gradient(135deg, #ef4444, #dc2626);
            box-shadow: 0 0 10px rgba(239, 68, 68, 0.5);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            color: white;
            animation: pulse 2s infinite;
            z-index: 10;
        }
        .notification-dropdown {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.95), rgba(15, 23, 42, 0.98));
            backdrop-filter: blur(20px);
            border: 1px solid rgba(148, 163, 184, 0.1);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            animation: slideDown 0.3s ease-out;
        }
        .notification-item {
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        .notification-item:hover {
            background: rgba(20, 184, 166, 0.1);
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
            background: linear-gradient(135deg,
            rgba(30, 41, 59, 0.6),
            rgba(15, 23, 42, 0.7)
            );
            backdrop-filter: blur(20px) saturate(180%);
            border: 1.5px solid rgba(148, 163, 184, 0.15);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            box-shadow:
                    0 4px 20px rgba(0, 0, 0, 0.1),
                    inset 0 1px 0 rgba(255, 255, 255, 0.05);
        }
        .search-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(6, 182, 212, 0.08),
            rgba(139, 92, 246, 0.08),
            transparent
            );
            transition: left 0.8s ease;
        }
        .search-container:hover::before {
            left: 100%;
        }
        .search-container:focus-within {
            border-color: rgba(6, 182, 212, 0.4);
            background: linear-gradient(135deg,
            rgba(30, 41, 59, 0.8),
            rgba(15, 23, 42, 0.9)
            );
            box-shadow:
                    0 0 40px rgba(6, 182, 212, 0.2),
                    0 8px 30px rgba(0, 0, 0, 0.2),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            transform: translateY(-1px);
        }
        .search-container input::placeholder {
            background: linear-gradient(90deg,
            rgba(148, 163, 184, 0.6),
            rgba(148, 163, 184, 0.4)
            );
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .search-container:focus-within input::placeholder {
            background: linear-gradient(90deg,
            rgba(6, 182, 212, 0.6),
            rgba(139, 92, 246, 0.5)
            );
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .loading-bar {
            height: 3px;
            background: linear-gradient(90deg, #14b8a6, #06b6d4, #3b82f6);
            background-size: 200% 100%;
            animation: shimmer 1.5s ease-in-out infinite;
        }
        @media (max-width: 768px) {
            .nav-link {
                padding: 12px 16px;
                border-bottom: 1px solid rgba(148, 163, 184, 0.1);
            }
        }
    </style>
</head>
<body class="bg-gray-900">
<!-- Loading Bar -->
<div id="loadingBar" class="loading-bar fixed top-0 left-0 w-0 z-[60] transition-all duration-300"></div>
<header class="text-white relative overflow-hidden">
    <!-- Floating Background Elements -->
    <div class="floating-orb"></div>
    <div class="floating-orb"></div>
    <div class="floating-orb"></div>
    <nav class="glass-nav sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
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

                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-2 text-gray-300">
                    <a href="${pageContext.request.contextPath}/"
                       class="nav-link hover:text-teal-400 transition">
                        <i class="fas fa-home mr-2"></i>Home
                    </a>
                    <a href="${pageContext.request.contextPath}/properties"
                       class="nav-link hover:text-teal-400 transition">
                        <i class="fas fa-building mr-2"></i>Properties
                    </a>
                    <a href="${pageContext.request.contextPath}/about"
                       class="nav-link hover:text-teal-400 transition">
                        <i class="fas fa-info-circle mr-2"></i>About
                    </a>
                    <a href="${pageContext.request.contextPath}/contact"
                       class="nav-link hover:text-teal-400 transition">
                        <i class="fas fa-envelope mr-2"></i>Contact
                    </a>
                </div>
                <!-- Right Section -->
                <div class="flex items-center space-x-3">
                    <!-- Notifications -->
                    <div class="relative">
                        <button id="notificationBtn"
                                class="notification-btn flex items-center justify-center w-11 h-11 rounded-xl transition-all duration-300 relative">
                            <i class="fas fa-bell text-gray-300 text-lg"></i>
                            <span id="notificationBadge"
                                  class="notification-badge absolute -top-2 -right-2 w-5 h-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center font-medium">
                                    3
                                </span>
                        </button>
                        <!-- Notification Dropdown -->
                        <div id="notificationDropdown"
                             class="notification-dropdown absolute right-0 mt-2 w-80 rounded-2xl p-4 hidden">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-white font-semibold">Notifications</h3>
                                <button class="text-teal-400 text-sm hover:text-teal-300">
                                    Mark all read
                                </button>
                            </div>
                            <!-- Notification Items -->
                            <div class="space-y-2 max-h-64 overflow-y-auto">
                                <div class="notification-item p-3 rounded-lg cursor-pointer">
                                    <div class="flex items-start space-x-3">
                                        <div class="w-2 h-2 bg-blue-400 rounded-full mt-2 flex-shrink-0"></div>
                                        <div class="flex-1">
                                            <p class="text-white text-sm font-medium">New property match found!</p>
                                            <p class="text-gray-400 text-xs mt-1">2-bedroom apartment in downtown area</p>
                                            <p class="text-gray-500 text-xs mt-1">5 minutes ago</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="notification-item p-3 rounded-lg cursor-pointer">
                                    <div class="flex items-start space-x-3">
                                        <div class="w-2 h-2 bg-green-400 rounded-full mt-2 flex-shrink-0"></div>
                                        <div class="flex-1">
                                            <p class="text-white text-sm font-medium">Booking confirmed</p>
                                            <p class="text-gray-400 text-xs mt-1">Your viewing appointment is scheduled</p>
                                            <p class="text-gray-500 text-xs mt-1">1 hour ago</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="notification-item p-3 rounded-lg cursor-pointer">
                                    <div class="flex items-start space-x-3">
                                        <div class="w-2 h-2 bg-yellow-400 rounded-full mt-2 flex-shrink-0"></div>
                                        <div class="flex-1">
                                            <p class="text-white text-sm font-medium">Price drop alert</p>
                                            <p class="text-gray-400 text-xs mt-1">Property you saved dropped by $200/month</p>
                                            <p class="text-gray-500 text-xs mt-1">3 hours ago</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="border-t border-gray-700 mt-4 pt-3">
                                <button class="w-full text-teal-400 text-sm font-medium hover:text-teal-300 transition">
                                    View all notifications
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- Seller Button -->
                    <div class="hidden md:flex">
                        <a href="${pageContext.request.contextPath}/seller/register"
                           class="seller-btn flex items-center gap-2 px-6 py-3 h-11 text-sm font-semibold text-white rounded-xl transition-all duration-300">
                            <i class="fas fa-store text-base"></i>
                            <span>Sell Property</span>
                        </a>
                    </div>
                    <!-- Auth Buttons -->
                    <div class="hidden md:flex items-center space-x-3">
                        <a href="${pageContext.request.contextPath}/login"
                           class="auth-btn flex items-center gap-2 px-6 py-3 h-11 text-sm font-medium text-white bg-gradient-to-r from-teal-600 to-teal-500 rounded-xl hover:from-teal-500 hover:to-teal-400 transition-all duration-300">
                            <i class="fas fa-sign-in-alt text-sm"></i>
                            Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register"
                           class="auth-btn flex items-center gap-2 px-6 py-3 h-11 text-sm font-medium text-slate-900 bg-gradient-to-r from-white to-gray-100 rounded-xl hover:from-gray-100 hover:to-white transition-all duration-300">
                            <i class="fas fa-user-plus text-sm"></i>
                            Register
                        </a>
                    </div>
                    <!-- Mobile Menu Button -->
                    <button id="mobileMenuBtn"
                            class="md:hidden notification-btn flex items-center justify-center w-11 h-11 rounded-xl">
                        <i class="fas fa-bars text-gray-300 text-lg"></i>
                    </button>
                </div>
            </div>
            <!-- Mobile Menu -->
            <div id="mobileMenu" class="mobile-menu md:hidden hidden">
                <div class="px-4 py-6 space-y-4">
                    <!-- Search Bar (Mobile) -->
                    <div class="search-container rounded-2xl px-5 py-3.5 flex items-center mb-6 gap-3">
                        <input type="text" placeholder="Find your dream property..."
                               class="bg-transparent text-white placeholder-gray-400 w-full outline-none text-sm font-light tracking-wide">
                        <button class="text-gray-400 hover:text-teal-400 transition-colors p-1.5 hover:bg-teal-400/10 rounded-lg flex-shrink-0">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"></path>
                            </svg>
                        </button>
                    </div>
                    <!-- Navigation Links -->
                    <a href="${pageContext.request.contextPath}/"
                       class="nav-link block text-gray-300 hover:text-teal-400 transition">
                        <i class="fas fa-home mr-3"></i>Home
                    </a>
                    <a href="${pageContext.request.contextPath}/properties"
                       class="nav-link block text-gray-300 hover:text-teal-400 transition">
                        <i class="fas fa-building mr-3"></i>Properties
                    </a>
                    <a href="${pageContext.request.contextPath}/about"
                       class="nav-link block text-gray-300 hover:text-teal-400 transition">
                        <i class="fas fa-info-circle mr-3"></i>About
                    </a>
                    <a href="${pageContext.request.contextPath}/contact"
                       class="nav-link block text-gray-300 hover:text-teal-400 transition">
                        <i class="fas fa-envelope mr-3"></i>Contact
                    </a>
                    <!-- Seller Button (Mobile) -->
                    <div class="pt-2">
                        <a href="${pageContext.request.contextPath}/seller/dashboard"
                           class="seller-btn flex items-center justify-center gap-2 w-full px-6 py-3 h-12 text-sm font-semibold text-white rounded-xl">
                            <i class="fas fa-store text-base"></i>
                            <span>Sell Property</span>
                        </a>
                    </div>
                    <!-- Auth Buttons (Mobile) -->
                    <div class="pt-4 border-t border-gray-700 space-y-3">
                        <a href="${pageContext.request.contextPath}/login"
                           class="auth-btn flex items-center justify-center gap-2 w-full px-6 py-3 h-12 text-sm font-medium text-white bg-gradient-to-r from-teal-600 to-teal-500 rounded-xl">
                            <i class="fas fa-sign-in-alt text-sm"></i>
                            Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register"
                           class="auth-btn flex items-center justify-center gap-2 w-full px-6 py-3 h-12 text-sm font-medium text-slate-900 bg-gradient-to-r from-white to-gray-100 rounded-xl">
                            <i class="fas fa-user-plus text-sm"></i>
                            Register
                        </a>
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
    const notificationBtn = document.getElementById('notificationBtn');
    const notificationDropdown = document.getElementById('notificationDropdown');
    const notificationBadge = document.getElementById('notificationBadge');
    notificationBtn.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        notificationDropdown.classList.toggle('hidden');
        // Animate notification button
        notificationBtn.style.transform = 'scale(0.95)';
        setTimeout(() => {
            notificationBtn.style.transform = 'scale(1)';
        }, 150);
    });
    // Close dropdown when clicking outside
    document.addEventListener('click', (e) => {
        if (!notificationBtn.contains(e.target) && !notificationDropdown.contains(e.target)) {
            notificationDropdown.classList.add('hidden');
        }
    });
    // Mobile menu functionality
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    mobileMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        // Animate mobile menu button
        const icon = mobileMenuBtn.querySelector('i');
        if (mobileMenu.classList.contains('hidden')) {
            icon.className = 'fas fa-bars text-gray-300';
        } else {
            icon.className = 'fas fa-times text-gray-300';
        }
    });
    // Search functionality with keyboard shortcut
    document.addEventListener('keydown', (e) => {
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
            e.preventDefault();
            const searchInput = document.querySelector('input[placeholder="Find your dream property..."]');
            searchInput.focus();
        }
    });
    // Add click animations to all buttons
    document.querySelectorAll('.auth-btn, .nav-link, .seller-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            showLoadingBar();
            // Ripple effect
            const ripple = document.createElement('span');
            const rect = btn.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = (e.clientX - rect.left - size / 2) + 'px';
            ripple.style.top = (e.clientY - rect.top - size / 2) + 'px';
            ripple.classList.add('ripple');
            btn.appendChild(ripple);
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });
    // Add ripple animation styles
    const style = document.createElement('style');
    style.textContent = `
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.4);
            transform: scale(0);
            animation: ripple-animation 0.6s linear;
            pointer-events: none;
        }
        @keyframes ripple-animation {
            to {
                transform: scale(2);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);
    // Simulate real-time notifications
    function addNotification(type, title, message) {
        const badge = document.getElementById('notificationBadge');
        let count = parseInt(badge.textContent) || 0;
        badge.textContent = count + 1;
        // Bounce animation for new notification
        badge.style.animation = 'bounce 0.5s ease-in-out';
        setTimeout(() => {
            badge.style.animation = 'pulse 2s infinite';
        }, 500);
    }
    // Simulate notifications (replace with real backend calls)
    setTimeout(() => {
        addNotification('info', 'New Message', 'You have a new inquiry');
    }, 5000);
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
</script>
</body>
</html>