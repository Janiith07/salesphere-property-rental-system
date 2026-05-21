<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful | RentSphere</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        @keyframes checkmarkAnimation {
            0% {
                stroke-dasharray: 0 100;
                opacity: 0;
            }
            50% {
                opacity: 1;
            }
            100% {
                stroke-dasharray: 100 0;
                opacity: 1;
            }
        }

        @keyframes circleScale {
            0% {
                transform: scale(0);
                opacity: 0;
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        @keyframes glow {
            0%, 100% {
                box-shadow: 0 0 20px rgba(20, 184, 166, 0.3);
            }
            50% {
                box-shadow: 0 0 30px rgba(20, 184, 166, 0.6);
            }
        }

        @keyframes confetti {
            0% {
                transform: translateY(-10px) rotateZ(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotateZ(720deg);
                opacity: 0;
            }
        }

        @keyframes ripple {
            0% {
                transform: scale(0);
                opacity: 1;
            }
            100% {
                transform: scale(4);
                opacity: 0;
            }
        }

        .success-checkmark {
            animation: circleScale 0.6s ease-out;
        }

        .checkmark-path {
            stroke-dasharray: 100;
            stroke-dashoffset: 100;
            animation: checkmarkAnimation 0.8s ease-out 0.3s forwards;
        }

        .fade-in-up {
            animation: fadeInUp 0.8s ease-out forwards;
        }

        .slide-in-left {
            animation: slideInLeft 0.6s ease-out forwards;
        }

        .slide-in-right {
            animation: slideInRight 0.6s ease-out forwards;
        }

        .animate-float {
            animation: float 3s ease-in-out infinite;
        }

        .animate-glow {
            animation: glow 2s ease-in-out infinite;
        }

        .glass-effect {
            backdrop-filter: blur(20px);
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(148, 163, 184, 0.2);
        }

        .gradient-text {
            background: linear-gradient(135deg, #2dd4bf, #38bdf8, #8b5cf6);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradient 3s ease infinite;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .confetti-piece {
            position: absolute;
            width: 10px;
            height: 10px;
            animation: confetti 3s ease-out forwards;
        }

        .ripple-effect {
            position: absolute;
            border-radius: 50%;
            background: rgba(20, 184, 166, 0.3);
            animation: ripple 0.6s ease-out;
        }

        .delay-100 { animation-delay: 0.1s; }
        .delay-200 { animation-delay: 0.2s; }
        .delay-300 { animation-delay: 0.3s; }
        .delay-400 { animation-delay: 0.4s; }
        .delay-500 { animation-delay: 0.5s; }
        .delay-600 { animation-delay: 0.6s; }
        .delay-700 { animation-delay: 0.7s; }
        .delay-800 { animation-delay: 0.8s; }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(20, 184, 166, 0.6);
            border-radius: 50%;
            animation: float 4s infinite ease-in-out;
        }
    </style>
</head>
<body class="bg-slate-900 text-gray-100 min-h-screen">
<!-- Background Effects -->
<div class="fixed inset-0 overflow-hidden pointer-events-none">
    <!-- Animated Background Gradients -->
    <div class="absolute top-20 left-20 w-72 h-72 bg-teal-400 rounded-full opacity-10 blur-3xl animate-float"></div>
    <div class="absolute bottom-20 right-20 w-96 h-96 bg-blue-400 rounded-full opacity-10 blur-3xl animate-float" style="animation-delay: -2s;"></div>
    <div class="absolute top-1/2 left-1/3 w-64 h-64 bg-purple-400 rounded-full opacity-10 blur-3xl animate-float" style="animation-delay: -1s;"></div>

    <!-- Floating Particles -->
    <div class="particle" style="top: 20%; left: 10%; animation-delay: 0s;"></div>
    <div class="particle" style="top: 40%; left: 80%; animation-delay: 1s;"></div>
    <div class="particle" style="top: 60%; left: 20%; animation-delay: 2s;"></div>
    <div class="particle" style="top: 80%; left: 70%; animation-delay: 0.5s;"></div>
    <div class="particle" style="top: 30%; left: 60%; animation-delay: 1.5s;"></div>
</div>

<!-- Confetti Container -->
<div id="confetti-container" class="fixed inset-0 pointer-events-none z-50"></div>

<!-- Main Content -->
<div class="relative z-10 min-h-screen flex items-center justify-center px-6">
    <div class="max-w-4xl w-full">
        <!-- Success Icon -->
        <div class="text-center mb-8">
            <div class="relative inline-block">
                <svg class="success-checkmark w-32 h-32 mx-auto mb-6" viewBox="0 0 100 100">
                    <circle cx="50" cy="50" r="45" fill="none" stroke="rgba(20, 184, 166, 0.2)" stroke-width="2"/>
                    <circle cx="50" cy="50" r="45" fill="none" stroke="url(#gradient)" stroke-width="4" class="animate-glow"/>
                    <path class="checkmark-path" fill="none" stroke="#14b8a6" stroke-width="6" stroke-linecap="round"
                          d="M25 50 L40 65 L75 30"/>
                    <defs>
                        <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:#14b8a6"/>
                            <stop offset="100%" style="stop-color:#06b6d4"/>
                        </linearGradient>
                    </defs>
                </svg>
                <!-- Ripple Effects -->
                <div class="absolute inset-0 flex items-center justify-center">
                    <div class="ripple-effect delay-500"></div>
                </div>
            </div>
        </div>

        <!-- Main Content Card -->
        <div class="glass-effect rounded-3xl p-8 md:p-12 shadow-2xl">
            <!-- Title -->
            <div class="text-center mb-8">
                <h1 class="text-4xl md:text-5xl font-bold gradient-text mb-4 fade-in-up delay-200">
                    Payment Successful!
                </h1>
                <p class="text-xl text-slate-300 fade-in-up delay-300">
                    Your property booking has been confirmed
                </p>
            </div>

            <!-- Payment Details -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                <!-- Left Column -->
                <div class="space-y-6 slide-in-left delay-400">
                    <div class="glass-effect rounded-2xl p-6 h-48">
                        <div class="flex items-center mb-4">
                            <div class="w-12 h-12 bg-gradient-to-r from-teal-500 to-blue-500 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-home text-white text-xl"></i>
                            </div>
                            <div class="min-w-0 flex-1">
                                <h3 class="text-lg font-semibold text-white">Property Booked</h3>
                                <p class="text-slate-400 text-sm truncate">Modern Downtown Apartment</p>
                            </div>
                        </div>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between items-start">
                                <span class="text-slate-400 flex-shrink-0">Location:</span>
                                <span class="text-white text-right ml-2">Main Street, City Center</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-slate-400">Check-in:</span>
                                <span class="text-white">Sep 30, 2025</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-slate-400">Duration:</span>
                                <span class="text-white">12 months</span>
                            </div>
                        </div>
                    </div>

                    <div class="glass-effect rounded-2xl p-6 h-48">
                        <div class="flex items-center mb-4">
                            <div class="w-12 h-12 bg-gradient-to-r from-emerald-500 to-teal-500 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-user text-white text-xl"></i>
                            </div>
                            <div class="min-w-0 flex-1">
                                <h3 class="text-lg font-semibold text-white">Tenant Information</h3>
                                <p class="text-slate-400 text-sm">Booking confirmed for</p>
                            </div>
                        </div>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-slate-400">Name:</span>
                                <span class="text-white">Lakshitha Dilshan</span>
                            </div>
                            <div class="flex justify-between items-start">
                                <span class="text-slate-400 flex-shrink-0">Email:</span>
                                <span class="text-white text-right ml-2 break-all">lakshithadilshan.info@gmail.com</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-slate-400">Phone:</span>
                                <span class="text-white">0764792982</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="space-y-6 slide-in-right delay-500">
                    <div class="glass-effect rounded-2xl p-6 h-48">
                        <div class="flex items-center mb-4">
                            <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-purple-500 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-credit-card text-white text-xl"></i>
                            </div>
                            <div class="min-w-0 flex-1">
                                <h3 class="text-lg font-semibold text-white">Payment Details</h3>
                                <p class="text-slate-400 text-sm">Transaction completed</p>
                            </div>
                        </div>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between items-center">
                                <span class="text-slate-400">Amount Paid:</span>
                                <span class="text-teal-400 font-semibold text-lg">$2,500.00</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-slate-400">Payment Method:</span>
                                <span class="text-white font-mono">**** **** **** 1234</span>
                            </div>
                            <div class="flex justify-between items-start">
                                <span class="text-slate-400 flex-shrink-0">Transaction ID:</span>
                                <span class="text-white text-right ml-2 font-mono text-xs">TXN-789456123</span>
                            </div>

                        </div>
                    </div>

                    <div class="glass-effect rounded-2xl p-6 border-2 border-teal-500/30 h-48">
                        <div class="text-center flex flex-col justify-center h-full">
                            <div class="w-16 h-16 bg-gradient-to-r from-teal-500 to-emerald-500 rounded-full flex items-center justify-center mx-auto mb-4 animate-glow">
                                <i class="fas fa-shield-check text-white text-2xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-white mb-2">Secure & Protected</h3>
                            <p class="text-slate-400 text-sm leading-relaxed">Your payment is secure and protected by bank-grade encryption</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Status Timeline -->
            <div class="glass-effect rounded-2xl p-6 mb-8 fade-in-up delay-600">
                <h3 class="text-xl font-semibold text-white mb-6 text-center">Booking Status</h3>
                <div class="flex items-center justify-between relative">
                    <!-- Progress Line -->
                    <div class="absolute top-6 left-0 right-0 h-0.5 bg-slate-600"></div>
                    <div class="absolute top-6 left-0 h-0.5 bg-gradient-to-r from-teal-500 to-emerald-500 transition-all duration-2000" style="width: 100%; animation-delay: 1s;"></div>

                    <!-- Step 1 -->
                    <div class="relative flex flex-col items-center">
                        <div class="w-12 h-12 bg-gradient-to-r from-teal-500 to-emerald-500 rounded-full flex items-center justify-center mb-2 animate-glow">
                            <i class="fas fa-credit-card text-white"></i>
                        </div>
                        <span class="text-sm text-teal-400 font-medium">Payment</span>
                        <span class="text-xs text-slate-400">Completed</span>
                    </div>

                    <!-- Step 2 -->
                    <div class="relative flex flex-col items-center">
                        <div class="w-12 h-12 bg-gradient-to-r from-teal-500 to-emerald-500 rounded-full flex items-center justify-center mb-2 animate-glow" style="animation-delay: 0.5s;">
                            <i class="fas fa-file-contract text-white"></i>
                        </div>
                        <span class="text-sm text-teal-400 font-medium">Contract</span>
                        <span class="text-xs text-slate-400">Generated</span>
                    </div>

                    <!-- Step 3 -->
                    <div class="relative flex flex-col items-center">
                        <div class="w-12 h-12 bg-gradient-to-r from-teal-500 to-emerald-500 rounded-full flex items-center justify-center mb-2 animate-glow" style="animation-delay: 1s;">
                            <i class="fas fa-key text-white"></i>
                        </div>
                        <span class="text-sm text-teal-400 font-medium">Keys</span>
                        <span class="text-xs text-slate-400">Ready</span>
                    </div>

                    <!-- Step 4 -->
                    <div class="relative flex flex-col items-center">
                        <div class="w-12 h-12 bg-gradient-to-r from-teal-500 to-emerald-500 rounded-full flex items-center justify-center mb-2 animate-glow" style="animation-delay: 1.5s;">
                            <i class="fas fa-home text-white"></i>
                        </div>
                        <span class="text-sm text-teal-400 font-medium">Move-in</span>
                        <span class="text-xs text-slate-400">Dec 15</span>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row gap-4 justify-center fade-in-up delay-700">
                <button class="bg-gradient-to-r from-teal-500 to-emerald-500 hover:from-teal-600 hover:to-emerald-600 text-white font-semibold py-3 px-8 rounded-xl transition-all duration-300 hover:scale-105 hover:shadow-xl flex items-center justify-center">
                    <i class="fas fa-download mr-2"></i>
                    Download Receipt
                </button>
                <button class="bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 text-white font-semibold py-3 px-8 rounded-xl transition-all duration-300 hover:scale-105 hover:shadow-xl flex items-center justify-center">
                    <i class="fas fa-file-contract mr-2"></i>
                    View Contract
                </button>
                <button onclick="window.location.href='${pageContext.request.contextPath}/'"
                        class="glass-effect border border-slate-600 hover:border-teal-500 text-white font-semibold py-3 px-8 rounded-xl transition-all duration-300 hover:scale-105 flex items-center justify-center">
                    <i class="fas fa-arrow-left mr-2"></i>
                    Back to Dashboard
                </button>

            </div>

            <!-- Contact Support -->
            <div class="text-center mt-8 fade-in-up delay-800">
                <div class="inline-flex items-center glass-effect border border-slate-600/50 rounded-full px-6 py-3">
                    <div class="w-3 h-3 bg-green-400 rounded-full mr-3 animate-pulse"></div>
                    <span class="text-slate-300 text-sm">Need help? Our support team is available 24/7</span>
                    <button class="ml-4 text-teal-400 hover:text-teal-300 transition-colors">
                        <i class="fas fa-comments"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Confetti animation
    function createConfetti() {
        const colors = ['#14b8a6', '#06b6d4', '#8b5cf6', '#10b981', '#3b82f6'];
        const confettiContainer = document.getElementById('confetti-container');

        for (let i = 0; i < 50; i++) {
            const confetti = document.createElement('div');
            confetti.className = 'confetti-piece';
            confetti.style.left = Math.random() * 100 + '%';
            confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
            confetti.style.animationDelay = Math.random() * 2 + 's';
            confetti.style.animationDuration = (Math.random() * 2 + 2) + 's';
            confettiContainer.appendChild(confetti);

            // Remove confetti after animation
            setTimeout(() => {
                confetti.remove();
            }, 4000);
        }
    }

    // Trigger confetti after page loads
    window.addEventListener('load', () => {
        setTimeout(createConfetti, 800);
    });

    // Add click ripple effect to buttons
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('click', function(e) {
            const rect = this.getBoundingClientRect();
            const ripple = document.createElement('div');
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.className = 'ripple-effect';
            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            ripple.style.position = 'absolute';

            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });

    // Add hover glow effect
    document.querySelectorAll('.glass-effect').forEach(element => {
        element.addEventListener('mouseenter', () => {
            element.style.boxShadow = '0 0 30px rgba(20, 184, 166, 0.2)';
        });

        element.addEventListener('mouseleave', () => {
            element.style.boxShadow = '';
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
</body>
</html>