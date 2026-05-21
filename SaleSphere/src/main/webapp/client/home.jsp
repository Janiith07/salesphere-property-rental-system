<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Find Your Perfect Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="client/css/home.css">
    <link rel="icon" href="${pageContext.request.contextPath}/client/assets/favicon.png" type="image/png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    
    <!-- Fast Loading Animation Styles -->
    <style>
        /* Performance Optimizations */
        * {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        /* Loading Screen Styles - GPU Accelerated */
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            will-change: opacity, visibility;
            transform: translateZ(0);
            transition: opacity 0.3s cubic-bezier(0.4, 0, 0.2, 1), visibility 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .loading-screen.fade-out {
            opacity: 0;
            visibility: hidden;
        }
        
        /* Animated Logo - Optimized */
        .loading-logo {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            will-change: transform;
        }
        
        .logo-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #3b82f6, #8b5cf6, #06b6d4);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            will-change: transform;
            transform: translateZ(0);
            animation: logoFloat 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2);
        }
        
        .logo-text {
            font-size: 2.2rem;
            font-weight: 800;
            background: linear-gradient(45deg, #3b82f6, #8b5cf6, #06b6d4);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            will-change: background-position;
            animation: textShimmer 2s ease-in-out infinite;
        }
        
        /* Progress Bar - Optimized */
        .progress-container {
            width: 250px;
            height: 3px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 6px;
            overflow: hidden;
            margin-bottom: 1rem;
            will-change: transform;
        }
        
        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #3b82f6, #8b5cf6, #06b6d4);
            border-radius: 6px;
            width: 0%;
            will-change: width;
            transform: translateZ(0);
            transition: width 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 0 10px rgba(59, 130, 246, 0.3);
        }
        
        /* Loading Text - Optimized */
        .loading-text {
            color: #94a3b8;
            font-size: 0.9rem;
            font-weight: 500;
            will-change: opacity;
            animation: textPulse 1.5s ease-in-out infinite;
        }
        
        /* Floating Background Elements - Minimal for Speed */
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }
        
        .floating-element {
            position: absolute;
            background: linear-gradient(45deg, rgba(59, 130, 246, 0.06), rgba(139, 92, 246, 0.06));
            border-radius: 50%;
            will-change: transform;
            transform: translateZ(0);
            animation: float 4s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
        
        .floating-element:nth-child(1) {
            width: 40px;
            height: 40px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }
        
        .floating-element:nth-child(2) {
            width: 30px;
            height: 30px;
            top: 60%;
            right: 15%;
            animation-delay: 1.5s;
        }
        
        .floating-element:nth-child(3) {
            width: 50px;
            height: 50px;
            bottom: 20%;
            left: 20%;
            animation-delay: 3s;
        }
        
        /* Fast Animations */
        @keyframes logoFloat {
            0%, 100% { 
                transform: translateY(0px) translateZ(0); 
            }
            50% { 
                transform: translateY(-5px) translateZ(0); 
            }
        }
        
        @keyframes textShimmer {
            0% { 
                background-position: -200% center; 
            }
            100% { 
                background-position: 200% center; 
            }
        }
        
        @keyframes textPulse {
            0%, 100% { 
                opacity: 0.6; 
            }
            50% { 
                opacity: 1; 
            }
        }
        
        @keyframes float {
            0%, 100% { 
                transform: translateY(0px) translateX(0px) translateZ(0); 
            }
            50% { 
                transform: translateY(-10px) translateX(5px) translateZ(0); 
            }
        }
        
        /* Responsive Design - Optimized */
        @media (max-width: 768px) {
            .logo-icon {
                width: 50px;
                height: 50px;
                font-size: 1.6rem;
            }
            
            .logo-text {
                font-size: 1.8rem;
            }
            
            .progress-container {
                width: 200px;
            }
            
            .loading-logo {
                margin-bottom: 1.5rem;
            }
        }
        
        /* Reduce motion for users who prefer it */
        @media (prefers-reduced-motion: reduce) {
            .logo-icon,
            .logo-text,
            .floating-element,
            .loading-text {
                animation: none;
            }
            
            .progress-bar {
                transition: width 0.3s ease;
            }
        }
        
        /* SaleSphere AI Chatbot Styles */
        .chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        
        .chatbot-toggle {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6, #06b6d4);
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }
        
        .chatbot-toggle:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 35px rgba(59, 130, 246, 0.4);
        }
        
        .chatbot-toggle i {
            color: white;
            font-size: 24px;
            transition: transform 0.3s ease;
        }
        
        .chatbot-toggle.active i {
            transform: rotate(45deg);
        }
        
        .chatbot-toggle::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6, #06b6d4);
            border-radius: 50%;
            z-index: -1;
            animation: pulse 2s infinite;
        }
        
        .chatbot-toggle::after {
            content: '💬';
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ef4444;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            animation: bounce 2s infinite;
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
        }
        
        .chatbot-toggle.auto-popup::after {
            animation: bounce 1s infinite, glow 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-8px);
            }
            60% {
                transform: translateY(-4px);
            }
        }
        
        @keyframes glow {
            0%, 100% {
                box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
            }
            50% {
                box-shadow: 0 2px 16px rgba(239, 68, 68, 0.6);
            }
        }
        
        .chatbot-window {
            position: absolute;
            bottom: 80px;
            right: 0;
            width: 350px;
            height: 500px;
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(59, 130, 246, 0.2);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            display: none;
            flex-direction: column;
            overflow: hidden;
            transform: translateY(20px) scale(0.9);
            opacity: 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .chatbot-window.active {
            display: flex;
            transform: translateY(0) scale(1);
            opacity: 1;
        }
        
        .chatbot-header {
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            padding: 20px;
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .chatbot-avatar {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        
        .chatbot-info h3 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
        }
        
        .chatbot-info p {
            margin: 0;
            font-size: 12px;
            opacity: 0.8;
        }
        
        .chatbot-status {
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
            margin-left: auto;
            animation: pulse 2s infinite;
        }
        
        .chatbot-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .message {
            max-width: 80%;
            padding: 12px 16px;
            border-radius: 18px;
            font-size: 14px;
            line-height: 1.4;
            word-wrap: break-word;
        }
        
        .message.bot {
            background: rgba(59, 130, 246, 0.1);
            color: #e2e8f0;
            border: 1px solid rgba(59, 130, 246, 0.2);
            align-self: flex-start;
        }
        
        .message.user {
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            color: white;
            align-self: flex-end;
        }
        
        .quick-replies {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 8px;
        }
        
        .quick-reply {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: #3b82f6;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .quick-reply:hover {
            background: rgba(59, 130, 246, 0.2);
            transform: translateY(-1px);
        }
        
        .chatbot-input {
            padding: 20px;
            border-top: 1px solid rgba(59, 130, 246, 0.1);
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .chatbot-input input {
            flex: 1;
            background: rgba(30, 41, 59, 0.5);
            border: 1px solid rgba(59, 130, 246, 0.2);
            border-radius: 25px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s ease;
        }
        
        .chatbot-input input:focus {
            border-color: #3b82f6;
        }
        
        .chatbot-input input::placeholder {
            color: #64748b;
        }
        
        .chatbot-send {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            border: none;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s ease;
        }
        
        .chatbot-send:hover {
            transform: scale(1.1);
        }
        
        .typing-indicator {
            display: flex;
            align-items: center;
            gap: 4px;
            padding: 12px 16px;
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.2);
            border-radius: 18px;
            align-self: flex-start;
            max-width: 80px;
        }
        
        .typing-dot {
            width: 6px;
            height: 6px;
            background: #3b82f6;
            border-radius: 50%;
            animation: typing 1.4s infinite;
        }
        
        .typing-dot:nth-child(2) {
            animation-delay: 0.2s;
        }
        
        .typing-dot:nth-child(3) {
            animation-delay: 0.4s;
        }
        
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
        
        @keyframes typing {
            0%, 60%, 100% {
                transform: translateY(0);
            }
            30% {
                transform: translateY(-10px);
            }
        }
        
        /* WhatsApp Contact Button Styles */
        .whatsapp-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        
        .whatsapp-button {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #25d366, #128c7e);
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 25px rgba(37, 211, 102, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-decoration: none;
        }
        
        .whatsapp-button:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 35px rgba(37, 211, 102, 0.4);
        }
        
        .whatsapp-button i {
            color: white;
            font-size: 28px;
            transition: transform 0.3s ease;
        }
        
        .whatsapp-button:hover i {
            transform: scale(1.1);
        }
        
        .whatsapp-button::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #25d366, #128c7e);
            border-radius: 50%;
            z-index: -1;
            animation: whatsappPulse 2s infinite;
        }
        
        .whatsapp-tooltip {
            position: absolute;
            right: 70px;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(20px);
            color: white;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            border: 1px solid rgba(37, 211, 102, 0.2);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }
        
        .whatsapp-tooltip::after {
            content: '';
            position: absolute;
            left: 100%;
            top: 50%;
            transform: translateY(-50%);
            border: 8px solid transparent;
            border-left-color: rgba(15, 23, 42, 0.95);
        }
        
        /* Stack WhatsApp button below chatbot */
        .whatsapp-container {
            bottom: 90px; /* Position below chatbot button */
        }
        
        .whatsapp-button:hover .whatsapp-tooltip {
            opacity: 1;
            visibility: visible;
        }
        
        .whatsapp-ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(37, 211, 102, 0.3);
            transform: scale(0);
            animation: whatsappRipple 2s infinite;
        }
        
        @keyframes whatsappPulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            100% {
                transform: scale(1.2);
                opacity: 0;
            }
        }
        
        @keyframes whatsappRipple {
            0% {
                transform: scale(0);
                opacity: 1;
            }
            100% {
                transform: scale(1.5);
                opacity: 0;
            }
        }
        
        /* Mobile Responsive */
        @media (max-width: 768px) {
            .chatbot-container {
                bottom: 15px;
                right: 15px;
            }
            
            .chatbot-window {
                width: calc(100vw - 30px);
                height: 400px;
                right: -15px;
            }
            
            .chatbot-toggle {
                width: 55px;
                height: 55px;
            }
            
            .chatbot-toggle i {
                font-size: 22px;
            }
            
            .whatsapp-container {
                bottom: 80px; /* Position below chatbot on mobile */
                right: 15px;
            }
            
            .whatsapp-button {
                width: 55px;
                height: 55px;
            }
            
            .whatsapp-button i {
                font-size: 24px;
            }
            
            .whatsapp-tooltip {
                right: 65px;
                font-size: 13px;
                padding: 10px 14px;
            }
        }
        
        /* Adjust chatbot position when WhatsApp button is present */
        @media (min-width: 769px) {
            .chatbot-container {
                bottom: 20px;
                right: 20px;
            }
        }
        
        /* Ensure proper spacing when chatbot window is open */
        .chatbot-window.active ~ .whatsapp-container {
            bottom: 590px; /* Move WhatsApp button up when chatbot is open */
        }
        
        @media (max-width: 768px) {
            .chatbot-window.active ~ .whatsapp-container {
                bottom: 490px; /* Mobile adjustment when chatbot is open */
            }
        }
    </style>
</head>
<body class="bg-slate-900 text-gray-100 font-sans">

<!-- Modern Loading Screen -->
<div id="loadingScreen" class="loading-screen">
    <!-- Floating Background Elements -->
    <div class="floating-elements">
        <div class="floating-element"></div>
        <div class="floating-element"></div>
        <div class="floating-element"></div>
        <div class="floating-element"></div>
    </div>
    
    <!-- Loading Content -->
    <div class="loading-logo">
        <div class="logo-icon">
            <i class="fas fa-building-user"></i>
        </div>
        <div class="logo-text">SaleSphere</div>
    </div>
    
    <!-- Progress Bar -->
    <div class="progress-container">
        <div class="progress-bar"></div>
    </div>
    
    <!-- Loading Text -->
    <div class="loading-text">Loading your perfect home...</div>
</div>

<!-- Header -->
<c:choose>
  <c:when test="${isLoggedIn}">
    <jsp:include page="./partials/sessionheader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="./partials/header.jsp" />
  </c:otherwise>
</c:choose>

<main>

 <body class="bg-gray-900">
    <!-- Hero Section -->
    <section class="relative h-screen overflow-hidden">
        <!-- Slideshow Container -->
        <div class="absolute inset-0">
            <!-- Slide 1 -->
            <div class="hero-slide absolute inset-0 opacity-100 transition-opacity duration-1000" id="slide1">
                <img src="https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg" alt="Modern House 1" class="w-full h-full object-cover" />
            </div>
            <!-- Slide 2 -->
            <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000" id="slide2">
                <img src="https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg" alt="Modern House 2" class="w-full h-full object-cover" />
            </div>
            <!-- Slide 3 -->
            <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000" id="slide3">
                <img src="https://images.pexels.com/photos/2581922/pexels-photo-2581922.jpeg" alt="Modern House 3" class="w-full h-full object-cover" />
            </div>
            <!-- Slide 4 -->
            <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000" id="slide4">
                <img src="https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg" alt="Modern House 4" class="w-full h-full object-cover" />
            </div>

            <!-- Gradient Overlay -->
            <div class="absolute inset-0 gradient-overlay"></div>
        </div>

        <!-- Navigation Arrows -->
        <div class="nav-arrow prev" onclick="changeSlide(-1)">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="m15 18-6-6 6-6"/>
            </svg>
        </div>
        <div class="nav-arrow next" onclick="changeSlide(1)">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="m9 18 6-6-6-6"/>
            </svg>
        </div>

        <!-- Content Container - Centered -->
        <div class="relative container mx-auto px-6 h-full flex items-center justify-center">
            <div class="text-white max-w-4xl text-center">
                <!-- Animated Floating Elements -->
                <div class="absolute -top-10 -left-10 w-20 h-20 bg-teal-400 rounded-full opacity-20 animate-float"></div>
                <div class="absolute -bottom-10 -right-10 w-16 h-16 bg-teal-300 rounded-full opacity-30 animate-float" style="animation-delay: 1s;"></div>

                <!-- Main Content with Glass Effect -->
                <div class="glass-effect p-8 rounded-2xl">
                    <h1 class="text-6xl md:text-7xl font-bold mb-6 text-teal-400 animate-fadeInUp">
                        Find Your Perfect Rental
                    </h1>
                    <p class="text-xl md:text-2xl mb-10 text-gray-200 animate-fadeInUp-delay leading-relaxed">
                        Smart, secure, and stress-free property rentals with <span class="text-teal-300 font-semibold">SaleSphere</span>
                    </p>
                    <div class="animate-fadeInUp-delay-2">
                        <a href="properties" class="inline-block bg-gradient-to-r from-teal-500 to-teal-600 hover:from-teal-600 hover:to-teal-700 text-white px-10 py-4 rounded-xl font-semibold transition-all duration-300 transform hover:scale-105 hover:shadow-2xl animate-pulse-custom">
                            Browse Properties
                            <svg class="inline-block ml-2 w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                            </svg>
                        </a>
                    </div>
                </div>

                <!-- Feature Pills -->
                <div class="flex flex-wrap justify-center gap-4 mt-8 animate-fadeInUp-delay-2">
                    <div class="glass-effect px-6 py-3 rounded-full">
                        <span class="text-sm font-medium text-white">✨ Premium Properties</span>
                    </div>
                    <div class="glass-effect px-6 py-3 rounded-full">
                        <span class="text-sm font-medium text-white">🔒 Secure Booking</span>
                    </div>
                    <div class="glass-effect px-6 py-3 rounded-full">
                        <span class="text-sm font-medium text-white">📱 Smart Features</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Slide Indicators -->
        <div class="slide-indicators">
            <div class="slide-indicator active" onclick="goToSlide(0)"></div>
            <div class="slide-indicator" onclick="goToSlide(1)"></div>
            <div class="slide-indicator" onclick="goToSlide(2)"></div>
            <div class="slide-indicator" onclick="goToSlide(3)"></div>
        </div>

        <!-- Scroll Down Indicator -->
        <div class="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
            <div class="w-6 h-10 border-2 border-white rounded-full flex justify-center">
                <div class="w-1 h-3 bg-white rounded-full mt-2 animate-pulse"></div>
            </div>
        </div>
    </section>

    <script>
        let currentSlide = 0;
        const slides = ['slide1', 'slide2', 'slide3', 'slide4'];
        const indicators = document.querySelectorAll('.slide-indicator');

        function showSlide(index) {
            // Hide all slides
            slides.forEach((slideId, i) => {
                const slide = document.getElementById(slideId);
                slide.style.opacity = i === index ? '1' : '0';
            });

            // Update indicators
            indicators.forEach((indicator, i) => {
                indicator.classList.toggle('active', i === index);
            });

            currentSlide = index;
        }

        function changeSlide(direction) {
            currentSlide += direction;
            if (currentSlide >= slides.length) currentSlide = 0;
            if (currentSlide < 0) currentSlide = slides.length - 1;
            showSlide(currentSlide);
        }

        function goToSlide(index) {
            showSlide(index);
        }

        // Auto-play slideshow
        let autoplay = setInterval(() => {
            changeSlide(1);
        }, 5000);

        // Pause autoplay on hover
        document.querySelector('section').addEventListener('mouseenter', () => {
            clearInterval(autoplay);
        });

        // Resume autoplay when not hovering
        document.querySelector('section').addEventListener('mouseleave', () => {
            autoplay = setInterval(() => {
                changeSlide(1);
            }, 5000);
        });

        // Add parallax scrolling effect
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const parallaxElements = document.querySelectorAll('.hero-slide img');
            parallaxElements.forEach(element => {
                element.style.transform = `translateY(${scrolled * 0.5}px)`;
            });
        });

        // Add smooth reveal on page load
        window.addEventListener('load', () => {
            document.querySelector('section').style.opacity = '1';
        });
    </script>
<body class="bg-gray-900">
    <!-- Features Section -->
    <section class="py-20 gradient-bg relative">
        <div class="container mx-auto px-6 relative z-10">
            <!-- Section Header -->
            <div class="text-center mb-16 animate-on-scroll">
                <h2 class="text-5xl font-bold mb-4 section-title">
                    Why Choose SaleSphere?
                </h2>
                <p class="text-xl text-slate-400 max-w-2xl mx-auto leading-relaxed">
                    Experience the future of property rentals with our cutting-edge features designed for your peace of mind
                </p>
                <!-- Decorative line -->
                <div class="w-24 h-1 bg-gradient-to-r from-teal-400 to-blue-400 mx-auto mt-6 rounded-full"></div>
            </div>

            <!-- Stats Row -->
            <div class="flex justify-center mb-16 animate-on-scroll">
                <div class="flex flex-wrap gap-8 justify-center">
                    <div class="stats-badge px-6 py-3 rounded-full">
                        <span class="feature-number text-2xl">10K+</span>
                        <span class="text-slate-300 ml-2">Properties</span>
                    </div>
                    <div class="stats-badge px-6 py-3 rounded-full">
                        <span class="feature-number text-2xl">50K+</span>
                        <span class="text-slate-300 ml-2">Happy Clients</span>
                    </div>
                    <div class="stats-badge px-6 py-3 rounded-full">
                        <span class="feature-number text-2xl">99.9%</span>
                        <span class="text-slate-300 ml-2">Uptime</span>
                    </div>
                </div>
            </div>

            <!-- Features Grid -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Feature 1 -->
                <div class="feature-card p-8 rounded-2xl animate-on-scroll" style="animation-delay: 0.1s;">
                    <div class="icon-container w-20 h-20 rounded-2xl flex items-center justify-center mx-auto mb-6 relative">
                        <i class="fas fa-home text-4xl text-teal-400"></i>
                        <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-teal-400/20 to-transparent"></div>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-white">Verified Listings</h3>
                    <p class="text-slate-300 leading-relaxed mb-6">
                        Only trusted and landlord-approved properties with comprehensive background checks and quality assurance
                    </p>
                    <div class="flex items-center text-teal-400 font-semibold">
                        <span>Learn More</span>
                        <i class="fas fa-arrow-right ml-2 transition-transform group-hover:translate-x-1"></i>
                    </div>
                </div>

                <!-- Feature 2 -->
                <div class="feature-card p-8 rounded-2xl animate-on-scroll" style="animation-delay: 0.3s;">
                    <div class="icon-container w-20 h-20 rounded-2xl flex items-center justify-center mx-auto mb-6 relative">
                        <i class="fas fa-user-shield text-4xl text-blue-400"></i>
                        <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-blue-400/20 to-transparent"></div>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-white">Secure Bookings</h3>
                    <p class="text-slate-300 leading-relaxed mb-6">
                        Your data and reservations are protected with bank-grade encryption and advanced security protocols
                    </p>
                    <div class="flex items-center text-blue-400 font-semibold">
                        <span>Learn More</span>
                        <i class="fas fa-arrow-right ml-2 transition-transform group-hover:translate-x-1"></i>
                    </div>
                </div>

                <!-- Feature 3 -->
                <div class="feature-card p-8 rounded-2xl animate-on-scroll" style="animation-delay: 0.5s;">
                    <div class="icon-container w-20 h-20 rounded-2xl flex items-center justify-center mx-auto mb-6 relative">
                        <i class="fas fa-clock text-4xl text-yellow-400"></i>
                        <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-yellow-400/20 to-transparent"></div>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-white">Fast Processing</h3>
                    <p class="text-slate-300 leading-relaxed mb-6">
                        Instant booking confirmations and real-time updates with our lightning-fast processing system
                    </p>
                    <div class="flex items-center text-yellow-400 font-semibold">
                        <span>Learn More</span>
                        <i class="fas fa-arrow-right ml-2 transition-transform group-hover:translate-x-1"></i>
                    </div>
                </div>
            </div>

            <!-- Bottom CTA -->
            <div class="text-center mt-16 animate-on-scroll" style="animation-delay: 0.7s;">
                <div class="inline-flex items-center bg-gradient-to-r from-teal-500/10 to-blue-500/10 backdrop-blur-sm border border-teal-500/20 rounded-full px-8 py-4">
                    <div class="w-3 h-3 bg-green-400 rounded-full pulse-animation mr-3"></div>
                    <span class="text-slate-300">All systems operational • 24/7 support available</span>
                </div>
            </div>
        </div>

        <!-- Floating Background Elements -->
        <div class="absolute top-20 left-10 w-32 h-32 bg-teal-400/5 rounded-full blur-xl animate-pulse"></div>
        <div class="absolute bottom-20 right-10 w-40 h-40 bg-blue-400/5 rounded-full blur-xl animate-pulse" style="animation-delay: 1s;"></div>
        <div class="absolute top-1/2 left-1/4 w-24 h-24 bg-yellow-400/5 rounded-full blur-xl animate-pulse" style="animation-delay: 2s;"></div>
    </section>

    <script>
        // Intersection Observer for scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        // Observe all animated elements
        document.querySelectorAll('.animate-on-scroll').forEach(el => {
            observer.observe(el);
        });

        // Add hover effects for feature cards
        document.querySelectorAll('.feature-card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-12px) scale(1.02)';
            });

            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0) scale(1)';
            });
        });

        // Parallax effect for background elements
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const parallaxElements = document.querySelectorAll('.absolute');

            parallaxElements.forEach((element, index) => {
                const speed = 0.1 + (index * 0.05);
                element.style.transform = `translateY(${scrolled * speed}px)`;
            });
        });

        // Add staggered animation delays
        document.querySelectorAll('.feature-card').forEach((card, index) => {
            card.style.animationDelay = `${index * 0.2}s`;
        });
    </script>

  <body class="bg-slate-900">
    <section class="py-20 bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 relative overflow-hidden">
        <!-- Animated background particles -->
        <div class="particles">
            <!-- Particles will be generated by JavaScript -->
        </div>

        <!-- Animated background elements -->
        <div class="absolute inset-0 opacity-20">
            <div class="absolute top-20 left-20 w-32 h-32 bg-teal-400 rounded-full blur-3xl animate-float"></div>
            <div class="absolute bottom-20 right-20 w-40 h-40 bg-blue-400 rounded-full blur-3xl animate-float" style="animation-delay: -1.5s;"></div>
            <div class="absolute top-1/2 left-1/3 w-24 h-24 bg-purple-400 rounded-full blur-2xl animate-float" style="animation-delay: -3s;"></div>
        </div>

        <div class="container mx-auto px-6 relative z-10">
            <!-- Animated title -->
            <div class="text-center mb-16">
                <h2 class="text-5xl font-bold gradient-text mb-4 section-enter animate-fade-in-up">
                    Exclusive Property Offers
                </h2>
                <div class="w-24 h-1 bg-gradient-to-r from-teal-400 to-blue-400 mx-auto rounded-full animate-glow"></div>
                <p class="text-slate-300 text-lg mt-6 section-enter animate-fade-in-up stagger-1 max-w-2xl mx-auto">
                    Discover unbeatable deals on premium properties with our limited-time offers
                </p>
            </div>

            <!-- Animated cards grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Card 1: Zero Deposit -->
                <div class="card-hover bg-slate-800/80 backdrop-blur-sm rounded-2xl shadow-2xl overflow-hidden border border-slate-700/50 section-enter animate-fade-in-up stagger-2 relative">
                    <div class="relative overflow-hidden">
                        <img src="https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg"
                             class="w-full h-56 object-cover transition-transform duration-700 hover:scale-110"
                             alt="Zero Deposit Rental" />
                        <div class="overlay absolute inset-0 flex items-center justify-center">
                            <div class="text-center text-white">
                                <div class="pulse-ring"></div>
                                <div class="text-3xl font-bold">0%</div>
                                <div class="text-sm">DEPOSIT</div>
                            </div>
                        </div>
                        <div class="absolute top-4 left-4 bg-gradient-to-r from-emerald-500 to-teal-500 text-white px-3 py-1 rounded-full text-sm font-semibold animate-pulse">
                            LIMITED TIME
                        </div>
                    </div>
                    <div class="p-8">
                        <h3 class="text-2xl font-bold text-white mb-3 flex items-center">
                            <span class="w-2 h-2 bg-teal-400 rounded-full mr-3 animate-pulse"></span>
                            Zero Deposit Rentals
                        </h3>
                        <p class="text-slate-300 mb-4 leading-relaxed">Move into your dream home without the financial burden of a traditional deposit.</p>
                        <div class="flex items-center justify-between">
                            <span class="text-teal-400 font-semibold">No Deposit Required</span>
                            <button class="bg-gradient-to-r from-teal-500 to-emerald-500 hover:from-teal-600 hover:to-emerald-600 text-white px-4 py-2 rounded-lg transition-all duration-300 hover:shadow-lg">
                                Learn More
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Early Bird -->
                <div class="card-hover bg-slate-800/80 backdrop-blur-sm rounded-2xl shadow-2xl overflow-hidden border border-slate-700/50 section-enter animate-fade-in-up stagger-3 relative">
                    <div class="relative overflow-hidden">
                        <img src="https://images.pexels.com/photos/271743/pexels-photo-271743.jpeg"
                             class="w-full h-56 object-cover transition-transform duration-700 hover:scale-110"
                             alt="Early Bird Discount" />
                        <div class="overlay absolute inset-0 flex items-center justify-center">
                            <div class="text-center text-white">
                                <div class="pulse-ring"></div>
                                <div class="text-3xl font-bold">15%</div>
                                <div class="text-sm">OFF</div>
                            </div>
                        </div>
                        <div class="absolute top-4 left-4 bg-gradient-to-r from-blue-500 to-purple-500 text-white px-3 py-1 rounded-full text-sm font-semibold animate-bounce">
                            HOT DEAL
                        </div>
                    </div>
                    <div class="p-8">
                        <h3 class="text-2xl font-bold text-white mb-3 flex items-center">
                            <span class="w-2 h-2 bg-blue-400 rounded-full mr-3 animate-pulse"></span>
                            Early Bird Discounts
                        </h3>
                        <p class="text-slate-300 mb-4 leading-relaxed">Reserve early and save big on your next property rental with exclusive discounts.</p>
                        <div class="flex items-center justify-between">
                            <span class="text-blue-400 font-semibold">Up to 15% Savings</span>
                            <button class="bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 text-white px-4 py-2 rounded-lg transition-all duration-300 hover:shadow-lg">
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Long-Term Stays -->
                <div class="card-hover bg-slate-800/80 backdrop-blur-sm rounded-2xl shadow-2xl overflow-hidden border border-slate-700/50 section-enter animate-fade-in-up stagger-4 relative">
                    <div class="relative overflow-hidden">
                        <img src="https://images.pexels.com/photos/276554/pexels-photo-276554.jpeg"
                             class="w-full h-56 object-cover transition-transform duration-700 hover:scale-110"
                             alt="Long-term Stay" />
                        <div class="overlay absolute inset-0 flex items-center justify-center">
                            <div class="text-center text-white">
                                <div class="pulse-ring"></div>
                                <div class="text-3xl font-bold">VIP</div>
                                <div class="text-sm">ACCESS</div>
                            </div>
                        </div>
                        <div class="absolute top-4 left-4 bg-gradient-to-r from-purple-500 to-pink-500 text-white px-3 py-1 rounded-full text-sm font-semibold shimmer-effect">
                            EXCLUSIVE
                        </div>
                    </div>
                    <div class="p-8">
                        <h3 class="text-2xl font-bold text-white mb-3 flex items-center">
                            <span class="w-2 h-2 bg-purple-400 rounded-full mr-3 animate-pulse"></span>
                            Long-Term Stays
                        </h3>
                        <p class="text-slate-300 mb-4 leading-relaxed">Enjoy exclusive benefits and substantial savings with our long-term rental packages.</p>
                        <div class="flex items-center justify-between">
                            <span class="text-purple-400 font-semibold">Premium Benefits</span>
                            <button class="bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white px-4 py-2 rounded-lg transition-all duration-300 hover:shadow-lg">
                                Explore
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Call to action -->
            <div class="text-center mt-16">
                <button class="bg-gradient-to-r from-teal-500 via-blue-500 to-purple-500 hover:from-teal-600 hover:via-blue-600 hover:to-purple-600 text-white font-bold py-4 px-8 rounded-2xl text-lg transition-all duration-300 hover:shadow-2xl hover:scale-105 animate-glow">
                    View All Properties
                </button>
            </div>
        </div>
    </section>

    <script>
        // Intersection Observer for scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('section-enter-active');
                }
            });
        }, observerOptions);

        // Observe all elements with section-enter class
        document.querySelectorAll('.section-enter').forEach(el => {
            observer.observe(el);
        });

        // Generate floating particles
        function createParticle() {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            particle.style.left = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 15 + 's';
            particle.style.animationDuration = (Math.random() * 10 + 10) + 's';

            // Random colors for particles
            const colors = ['rgba(45, 212, 191, 0.5)', 'rgba(56, 189, 248, 0.5)', 'rgba(139, 92, 246, 0.5)'];
            particle.style.background = colors[Math.floor(Math.random() * colors.length)];

            document.querySelector('.particles').appendChild(particle);

            // Remove particle after animation
            setTimeout(() => {
                particle.remove();
            }, 15000);
        }

        // Create particles periodically
        setInterval(createParticle, 2000);

        // Initial particles
        for (let i = 0; i < 5; i++) {
            setTimeout(createParticle, i * 400);
        }

        // Add hover sound effect simulation (visual feedback)
        document.querySelectorAll('.card-hover').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.filter = 'brightness(1.1)';
            });

            card.addEventListener('mouseleave', () => {
                card.style.filter = 'brightness(1)';
            });
        });

        // Parallax effect for background elements
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const parallaxElements = document.querySelectorAll('.animate-float');

            parallaxElements.forEach((element, index) => {
                const speed = (index + 1) * 0.1;
                element.style.transform = `translateY(${scrolled * speed}px)`;
            });
        });
    </script>

  <!-- Testimonials Section -->
  <c:if test="${not empty topReviews}">
    <section class="py-16 bg-slate-800">
      <div class="container mx-auto px-6">
        <h2 class="text-3xl font-bold text-center text-teal-400 mb-12">Tenant Feedback</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <c:forEach var="review" items="${topReviews}">
            <div class="bg-slate-700 p-6 rounded-lg shadow">
              <div class="text-yellow-400 mb-4">
                <c:forEach begin="1" end="${review.rating}">
                  <i class="fas fa-star"></i>
                </c:forEach>
                <c:forEach begin="1" end="${5 - review.rating}">
                  <i class="far fa-star text-yellow-500/50"></i>
                </c:forEach>
              </div>
              <p class="text-slate-300 mb-4">“${review.comment}”</p>
              <p class="font-semibold text-gray-200">– ${review.tenantName}</p>
              <p class="text-sm text-gray-400 mt-1 italic">${review.propertyTitle}</p>
            </div>
          </c:forEach>
        </div>
      </div>
    </section>
  </c:if>

</main>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<!-- WhatsApp Contact Button -->
<div class="whatsapp-container">
    <a href="https://wa.me/94764792982?text=Hi! I'm interested in your properties. Can you help me?" 
       class="whatsapp-button" 
       target="_blank" 
       rel="noopener noreferrer"
       title="Contact us on WhatsApp">
        <i class="fab fa-whatsapp"></i>
        <div class="whatsapp-tooltip">
            💬 Chat with us on WhatsApp
        </div>
    </a>
</div>

<!-- SaleSphere AI Chatbot -->
<div class="chatbot-container">
    <button class="chatbot-toggle" id="chatbotToggle">
        <i class="fas fa-comments"></i>
    </button>
    
    <div class="chatbot-window" id="chatbotWindow">
        <div class="chatbot-header">
            <div class="chatbot-avatar">
                <i class="fas fa-robot"></i>
            </div>
            <div class="chatbot-info">
                <h3>SaleSphere AI</h3>
                <p>Property Assistant</p>
            </div>
            <div class="chatbot-status"></div>
        </div>
        
        <div class="chatbot-messages" id="chatbotMessages">
            <div class="message bot">
                👋 Hi! I'm your SaleSphere AI assistant. I can help you find properties, answer questions, and guide you through our platform. How can I assist you today?
                <div class="quick-replies">
                    <div class="quick-reply" data-message="Find properties">🏠 Find Properties</div>
                    <div class="quick-reply" data-message="How to book">📅 How to Book</div>
                    <div class="quick-reply" data-message="Contact support">💬 Contact Support</div>
                </div>
            </div>
        </div>
        
        <div class="chatbot-input">
            <input type="text" id="chatbotInput" placeholder="Ask me anything about properties..." />
            <button class="chatbot-send" id="chatbotSend">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>

<!-- Optimized Loading Animation JavaScript -->
<script>
    (function() {
        'use strict';
        
        // Performance optimizations
        const loadingScreen = document.getElementById('loadingScreen');
        const progressBar = document.querySelector('.progress-bar');
        const loadingText = document.querySelector('.loading-text');
        
        if (!loadingScreen || !progressBar || !loadingText) return;
        
        // Optimized loading messages array
        const loadingMessages = [
            'Loading your perfect home...',
            'Finding the best properties...',
            'Preparing amazing deals...',
            'Almost ready...'
        ];
        
        let messageIndex = 0;
        let progress = 0;
        let animationFrameId;
        let startTime;
        const minLoadingTime = 800; // Faster minimum loading time
        const maxLoadingTime = 1500; // Much faster maximum loading time
        
        // Use requestAnimationFrame for smoother animations
        function updateProgress(currentTime) {
            if (!startTime) startTime = currentTime;
            
            const elapsed = currentTime - startTime;
            const progressRatio = Math.min(elapsed / maxLoadingTime, 1);
            
            // Faster progress curve using ease-out
            const smoothProgress = 1 - Math.pow(1 - progressRatio, 2);
            progress = Math.min(smoothProgress * 100, 100);
            
            // Update progress bar with optimized style change
            progressBar.style.width = progress + '%';
            
            // Update messages at specific progress points
            const newMessageIndex = Math.floor(progress / 25);
            if (newMessageIndex !== messageIndex && newMessageIndex < loadingMessages.length) {
                messageIndex = newMessageIndex;
                loadingText.textContent = loadingMessages[messageIndex];
            }
            
            // Check if loading is complete
            if (progress >= 100 || elapsed >= maxLoadingTime) {
                completeLoading();
            } else {
                animationFrameId = requestAnimationFrame(updateProgress);
            }
        }
        
        function completeLoading() {
            // Cancel any pending animation frame
            if (animationFrameId) {
                cancelAnimationFrame(animationFrameId);
            }
            
            // Set final progress
            progressBar.style.width = '100%';
            loadingText.textContent = 'Welcome to SaleSphere!';
            
            // Ensure minimum loading time for smooth UX
            const elapsed = performance.now() - startTime;
            const remainingTime = Math.max(0, minLoadingTime - elapsed);
            
            setTimeout(() => {
                loadingScreen.classList.add('fade-out');
                
                // Clean up after animation
                setTimeout(() => {
                    loadingScreen.remove();
                    // Clean up references
                    loadingScreen = null;
                    progressBar = null;
                    loadingText = null;
                }, 400);
            }, remainingTime + 200);
        }
        
        // Start loading animation when DOM is ready
        function startLoading() {
            startTime = null;
            animationFrameId = requestAnimationFrame(updateProgress);
        }
        
        // Initialize loading
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', startLoading);
        } else {
            startLoading();
        }
        
        // Fallback: Hide loading screen if page takes too long
        const fallbackTimeout = setTimeout(() => {
            if (loadingScreen && !loadingScreen.classList.contains('fade-out')) {
                completeLoading();
            }
        }, maxLoadingTime + 500);
        
        // Clean up fallback timeout when loading completes
        const originalCompleteLoading = completeLoading;
        completeLoading = function() {
            clearTimeout(fallbackTimeout);
            originalCompleteLoading();
        };
        
        // Handle page visibility changes for better performance
        document.addEventListener('visibilitychange', function() {
            if (document.hidden && animationFrameId) {
                cancelAnimationFrame(animationFrameId);
            } else if (!document.hidden && !loadingScreen.classList.contains('fade-out')) {
                startLoading();
            }
        });
        
    })();
</script>

<!-- SaleSphere AI Chatbot JavaScript -->
<script>
    (function() {
        'use strict';
        
        // Chatbot elements
        const chatbotToggle = document.getElementById('chatbotToggle');
        const chatbotWindow = document.getElementById('chatbotWindow');
        const chatbotMessages = document.getElementById('chatbotMessages');
        const chatbotInput = document.getElementById('chatbotInput');
        const chatbotSend = document.getElementById('chatbotSend');
        
        let isOpen = false;
        
        // AI responses database
        const aiResponses = {
            'find properties': {
                message: '🏠 Great! I can help you find properties. Here are some options:',
                quickReplies: [
                    { text: '🏢 Apartments in Colombo', message: 'apartments colombo' },
                    { text: '🏡 Houses under 50k', message: 'houses under 50000' },
                    { text: '🏠 Rooms for rent', message: 'rooms for rent' },
                    { text: '📍 Properties in Kandy', message: 'properties kandy' }
                ]
            },
            'how to book': {
                message: '📅 Booking a property is easy! Here\'s how:',
                quickReplies: [
                    { text: '1️⃣ Browse Properties', message: 'browse properties' },
                    { text: '2️⃣ View Details', message: 'view property details' },
                    { text: '3️⃣ Make Booking', message: 'make booking' },
                    { text: '4️⃣ Payment Process', message: 'payment process' }
                ]
            },
            'contact support': {
                message: '💬 I\'m here to help! You can also contact our support team:',
                quickReplies: [
                    { text: '📞 Call Support', message: 'call support' },
                    { text: '📧 Email Support', message: 'email support' },
                    { text: '💬 Live Chat', message: 'live chat' },
                    { text: '❓ FAQ', message: 'frequently asked questions' }
                ]
            },
            'apartments colombo': {
                message: '🏢 I found some great apartments in Colombo! Click below to browse:',
                quickReplies: [
                    { text: '🔍 Search Apartments', action: 'redirect', url: '/SaleSphere/properties?search=apartment&location=colombo' },
                    { text: '💰 Budget Options', action: 'redirect', url: '/SaleSphere/properties?search=apartment&maxPrice=50000' },
                    { text: '⭐ Premium Options', action: 'redirect', url: '/SaleSphere/properties?search=apartment&minPrice=100000' }
                ]
            },
            'houses under 50000': {
                message: '🏡 Here are houses under Rs. 50,000:',
                quickReplies: [
                    { text: '🔍 View Houses', action: 'redirect', url: '/SaleSphere/properties?search=house&maxPrice=50000' },
                    { text: '📍 In Colombo', action: 'redirect', url: '/SaleSphere/properties?search=house&location=colombo&maxPrice=50000' },
                    { text: '📍 In Kandy', action: 'redirect', url: '/SaleSphere/properties?search=house&location=kandy&maxPrice=50000' }
                ]
            },
            'rooms for rent': {
                message: '🏠 Here are available rooms for rent:',
                quickReplies: [
                    { text: '🔍 Browse Rooms', action: 'redirect', url: '/SaleSphere/properties?search=room' },
                    { text: '💰 Under 20k', action: 'redirect', url: '/SaleSphere/properties?search=room&maxPrice=20000' },
                    { text: '📍 Colombo Rooms', action: 'redirect', url: '/SaleSphere/properties?search=room&location=colombo' }
                ]
            },
            'properties kandy': {
                message: '📍 Here are properties in Kandy:',
                quickReplies: [
                    { text: '🔍 All Properties', action: 'redirect', url: '/SaleSphere/properties?search=kandy' },
                    { text: '🏢 Apartments', action: 'redirect', url: '/SaleSphere/properties?search=apartment&location=kandy' },
                    { text: '🏡 Houses', action: 'redirect', url: '/SaleSphere/properties?search=house&location=kandy' }
                ]
            },
            'browse properties': {
                message: '🔍 Let\'s browse properties! You can:',
                quickReplies: [
                    { text: '🏠 All Properties', action: 'redirect', url: '/SaleSphere/properties' },
                    { text: '🏢 Apartments', action: 'redirect', url: '/SaleSphere/properties?search=apartment' },
                    { text: '🏡 Houses', action: 'redirect', url: '/SaleSphere/properties?search=house' },
                    { text: '🏠 Rooms', action: 'redirect', url: '/SaleSphere/properties?search=room' }
                ]
            },
            'view property details': {
                message: '📋 To view property details:',
                quickReplies: [
                    { text: '1️⃣ Click on any property', message: 'property details help' },
                    { text: '2️⃣ See photos & info', message: 'property details help' },
                    { text: '3️⃣ Check availability', message: 'property details help' }
                ]
            },
            'make booking': {
                message: '📅 To make a booking:',
                quickReplies: [
                    { text: '1️⃣ Select property', message: 'booking process' },
                    { text: '2️⃣ Choose dates', message: 'booking process' },
                    { text: '3️⃣ Fill details', message: 'booking process' },
                    { text: '4️⃣ Make payment', message: 'booking process' }
                ]
            },
            'payment process': {
                message: '💳 Our payment process is secure:',
                quickReplies: [
                    { text: '💳 Credit/Debit Card', message: 'payment methods' },
                    { text: '🏦 Bank Transfer', message: 'payment methods' },
                    { text: '📱 Digital Wallet', message: 'payment methods' },
                    { text: '🔒 Security Info', message: 'payment security' }
                ]
            },
            'call support': {
                message: '📞 Call our support team:',
                quickReplies: [
                    { text: '📞 +94 11 234 5678', action: 'phone', number: '+94112345678' },
                    { text: '⏰ Mon-Fri 9AM-6PM', message: 'support hours' },
                    { text: '📧 Or email us', message: 'email support' }
                ]
            },
            'email support': {
                message: '📧 Email our support team:',
                quickReplies: [
                    { text: '📧 support@salesphere.lk', action: 'email', email: 'support@salesphere.lk' },
                    { text: '📧 info@salesphere.lk', action: 'email', email: 'info@salesphere.lk' },
                    { text: '⏰ Response within 24h', message: 'email response time' }
                ]
            },
            'live chat': {
                message: '💬 You\'re already using live chat! I\'m your AI assistant. For human support:',
                quickReplies: [
                    { text: '📞 Call Support', message: 'call support' },
                    { text: '📧 Email Support', message: 'email support' },
                    { text: '❓ FAQ', message: 'frequently asked questions' }
                ]
            },
            'frequently asked questions': {
                message: '❓ Here are common questions:',
                quickReplies: [
                    { text: '💰 What are the fees?', message: 'fees information' },
                    { text: '🔒 Is it secure?', message: 'security information' },
                    { text: '📅 How to cancel?', message: 'cancellation policy' },
                    { text: '🏠 Property types?', message: 'property types' }
                ]
            },
            'fees information': {
                message: '💰 Our fees are transparent:',
                quickReplies: [
                    { text: '🏠 No booking fees', message: 'no booking fees' },
                    { text: '💳 Payment processing: 2.5%', message: 'payment fees' },
                    { text: '🔒 Security deposit required', message: 'security deposit' }
                ]
            },
            'security information': {
                message: '🔒 Your security is our priority:',
                quickReplies: [
                    { text: '🔐 SSL encryption', message: 'ssl encryption' },
                    { text: '💳 Secure payments', message: 'secure payments' },
                    { text: '🛡️ Data protection', message: 'data protection' }
                ]
            },
            'default': {
                message: '🤔 I\'m not sure about that. Let me help you with something else:',
                quickReplies: [
                    { text: '🏠 Find Properties', message: 'find properties' },
                    { text: '📅 How to Book', message: 'how to book' },
                    { text: '💬 Contact Support', message: 'contact support' },
                    { text: '❓ FAQ', message: 'frequently asked questions' }
                ]
            }
        };
        
        // Toggle chatbot
        chatbotToggle.addEventListener('click', function() {
            isOpen = !isOpen;
            chatbotWindow.classList.toggle('active', isOpen);
            chatbotToggle.classList.toggle('active', isOpen);
            
            if (isOpen) {
                chatbotInput.focus();
            }
        });
        
        // Send message function
        function sendMessage(message) {
            if (!message.trim()) return;
            
            // Add user message
            addMessage(message, 'user');
            
            // Clear input
            chatbotInput.value = '';
            
            // Show typing indicator
            showTypingIndicator();
            
            // Simulate AI response delay
            setTimeout(() => {
                hideTypingIndicator();
                const response = getAIResponse(message.toLowerCase());
                addMessage(response.message, 'bot', response.quickReplies);
            }, 1000 + Math.random() * 1000);
        }
        
        // Add message to chat
        function addMessage(text, sender, quickReplies = null) {
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}`;
            messageDiv.textContent = text;
            
            if (quickReplies && quickReplies.length > 0) {
                const quickRepliesDiv = document.createElement('div');
                quickRepliesDiv.className = 'quick-replies';
                
                quickReplies.forEach(reply => {
                    const replyDiv = document.createElement('div');
                    replyDiv.className = 'quick-reply';
                    replyDiv.textContent = reply.text;
                    replyDiv.setAttribute('data-message', reply.message);
                    
                    if (reply.action === 'redirect') {
                        replyDiv.addEventListener('click', () => {
                            window.location.href = reply.url;
                        });
                    } else if (reply.action === 'phone') {
                        replyDiv.addEventListener('click', () => {
                            window.location.href = `tel:${reply.number}`;
                        });
                    } else if (reply.action === 'email') {
                        replyDiv.addEventListener('click', () => {
                            window.location.href = `mailto:${reply.email}`;
                        });
                    } else {
                        replyDiv.addEventListener('click', () => {
                            sendMessage(reply.message);
                        });
                    }
                    
                    quickRepliesDiv.appendChild(replyDiv);
                });
                
                messageDiv.appendChild(quickRepliesDiv);
            }
            
            chatbotMessages.appendChild(messageDiv);
            chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
        }
        
        // Show typing indicator
        function showTypingIndicator() {
            const typingDiv = document.createElement('div');
            typingDiv.className = 'typing-indicator';
            typingDiv.id = 'typingIndicator';
            typingDiv.innerHTML = '<div class="typing-dot"></div><div class="typing-dot"></div><div class="typing-dot"></div>';
            chatbotMessages.appendChild(typingDiv);
            chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
        }
        
        // Hide typing indicator
        function hideTypingIndicator() {
            const typingIndicator = document.getElementById('typingIndicator');
            if (typingIndicator) {
                typingIndicator.remove();
            }
        }
        
        // Get AI response
        function getAIResponse(message) {
            // Check for exact matches first
            if (aiResponses[message]) {
                return aiResponses[message];
            }
            
            // Check for partial matches
            for (const key in aiResponses) {
                if (message.includes(key) || key.includes(message)) {
                    return aiResponses[key];
                }
            }
            
            // Check for keywords
            if (message.includes('property') || message.includes('house') || message.includes('apartment')) {
                return aiResponses['find properties'];
            }
            if (message.includes('book') || message.includes('booking')) {
                return aiResponses['how to book'];
            }
            if (message.includes('contact') || message.includes('support') || message.includes('help')) {
                return aiResponses['contact support'];
            }
            
            return aiResponses['default'];
        }
        
        // Event listeners
        chatbotSend.addEventListener('click', () => {
            sendMessage(chatbotInput.value);
        });
        
        chatbotInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                sendMessage(chatbotInput.value);
            }
        });
        
        // Quick reply click handlers
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('quick-reply')) {
                const message = e.target.getAttribute('data-message');
                if (message) {
                    sendMessage(message);
                }
            }
        });
        
        // Auto-open chatbot on every visit with different timing
        function autoOpenChatbot() {
            // Check if user has interacted with chatbot before
            const hasInteracted = localStorage.getItem('chatbotInteracted');
            
            if (!hasInteracted) {
                // First-time visitors: add visual indicator and open after 2 seconds
                chatbotToggle.classList.add('auto-popup');
                
                setTimeout(() => {
                    if (!isOpen) {
                        chatbotToggle.click();
                        // Add a welcome message after opening
                        setTimeout(() => {
                            addMessage('👋 Welcome to SaleSphere! I\'m here to help you find your perfect property. What are you looking for today?', 'bot', [
                                { text: '🏠 Find Properties', message: 'find properties' },
                                { text: '📅 How to Book', message: 'how to book' },
                                { text: '💬 Get Help', message: 'contact support' }
                            ]);
                        }, 500);
                    }
                    // Remove the visual indicator after opening
                    chatbotToggle.classList.remove('auto-popup');
                }, 2000);
            } else {
                // Returning visitors: open after 3 seconds (less intrusive)
                setTimeout(() => {
                    if (!isOpen) {
                        chatbotToggle.click();
                    }
                }, 3000);
            }
        }
        
        // Start auto-open when page loads
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', autoOpenChatbot);
        } else {
            autoOpenChatbot();
        }
        
        // Mark interaction when user sends a message
        chatbotSend.addEventListener('click', () => {
            localStorage.setItem('chatbotInteracted', 'true');
        });
        
        chatbotInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                localStorage.setItem('chatbotInteracted', 'true');
            }
        });
        
        // Mark interaction when user clicks quick replies
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('quick-reply')) {
                localStorage.setItem('chatbotInteracted', 'true');
            }
        });
        
        // Reset interaction status (for testing - remove in production)
        // Uncomment the line below to reset and test auto-popup again
        // localStorage.removeItem('chatbotInteracted');
        
    })();
</script>

<!-- WhatsApp Button JavaScript -->
<script>
    (function() {
        'use strict';
        
        // WhatsApp button functionality
        const whatsappButton = document.querySelector('.whatsapp-button');
        
        if (whatsappButton) {
            // Add click tracking
            whatsappButton.addEventListener('click', function() {
                // Track WhatsApp clicks (you can add analytics here)
                console.log('WhatsApp button clicked');
                
                // Add ripple effect
                createRippleEffect(this);
            });
            
            // Create ripple effect function
            function createRippleEffect(button) {
                const ripple = document.createElement('div');
                ripple.className = 'whatsapp-ripple';
                ripple.style.width = '100px';
                ripple.style.height = '100px';
                ripple.style.position = 'absolute';
                ripple.style.top = '50%';
                ripple.style.left = '50%';
                ripple.style.transform = 'translate(-50%, -50%)';
                ripple.style.pointerEvents = 'none';
                
                button.appendChild(ripple);
                
                // Remove ripple after animation
                setTimeout(() => {
                    if (ripple.parentNode) {
                        ripple.parentNode.removeChild(ripple);
                    }
                }, 2000);
            }
            
            // Add hover sound effect (optional)
            whatsappButton.addEventListener('mouseenter', function() {
                // You can add a subtle sound effect here if desired
                // const audio = new Audio('path/to/hover-sound.mp3');
                // audio.volume = 0.1;
                // audio.play();
            });
        }
        
        // Auto-show WhatsApp button after page load
        setTimeout(() => {
            if (whatsappButton) {
                whatsappButton.style.opacity = '0';
                whatsappButton.style.transform = 'scale(0.8)';
                whatsappButton.style.transition = 'all 0.5s ease';
                
                setTimeout(() => {
                    whatsappButton.style.opacity = '1';
                    whatsappButton.style.transform = 'scale(1)';
                }, 100);
            }
        }, 1000);
        
    })();
</script>

</body>
</html>