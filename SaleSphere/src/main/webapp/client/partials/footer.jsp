<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RentSphere - Animated Footer</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="client/css/footer.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        /* Modern top border instead of problematic wave */
        .modern-border {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg,
                #2dd4bf 0%,
                #38bdf8 25%,
                #8b5cf6 50%,
                #ec4899 75%,
                #2dd4bf 100%);
            background-size: 200% 100%;
            animation: gradientFlow 8s ease-in-out infinite;
        }

        .modern-border::after {
            content: '';
            position: absolute;
            top: 4px;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg,
                transparent 0%,
                rgba(45, 212, 191, 0.3) 50%,
                transparent 100%);
            animation: shimmerFlow 3s ease-in-out infinite;
        }

        @keyframes gradientFlow {
            0%, 100% {
                background-position: 0% 0%;
            }
            50% {
                background-position: 200% 0%;
            }
        }

        @keyframes shimmerFlow {
            0%, 100% {
                opacity: 0;
                transform: translateX(-100%);
            }
            50% {
                opacity: 1;
                transform: translateX(100%);
            }
        }

        /* Gradient animations */
        @keyframes gradientShift {
            0%, 100% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
        }

        .gradient-bg {
            background: linear-gradient(-45deg, #0f172a, #1e293b, #334155, #475569);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }

        /* Floating elements */
        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes floatReverse {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(20px);
            }
        }

        .float-element {
            animation: float 6s ease-in-out infinite;
        }

        .float-element-reverse {
            animation: floatReverse 8s ease-in-out infinite;
        }

        /* Glow effects */
        @keyframes glow {
            0%, 100% {
                box-shadow: 0 0 20px rgba(45, 212, 191, 0.3);
            }
            50% {
                box-shadow: 0 0 40px rgba(45, 212, 191, 0.6);
            }
        }

        .glow-effect {
            animation: glow 3s ease-in-out infinite;
        }

        /* Text animations */
        @keyframes textGlow {
            0%, 100% {
                text-shadow: 0 0 20px rgba(45, 212, 191, 0.5);
            }
            50% {
                text-shadow: 0 0 30px rgba(45, 212, 191, 0.8);
            }
        }

        .text-glow {
            animation: textGlow 4s ease-in-out infinite;
        }

        /* Link hover effects */
        .link-hover {
            position: relative;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .link-hover::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #2dd4bf, transparent);
            transition: left 0.5s;
        }

        .link-hover:hover::before {
            left: 100%;
        }

        .link-hover:hover {
            color: #2dd4bf;
            transform: translateX(5px);
        }

        /* Social media animations */
        .social-icon {
            position: relative;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(45, 212, 191, 0.1), rgba(56, 189, 248, 0.1));
            border: 1px solid rgba(45, 212, 191, 0.3);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
        }

        .social-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.6s;
        }

        .social-icon:hover::before {
            left: 100%;
        }

        .social-icon:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 10px 25px rgba(45, 212, 191, 0.4);
            border-color: #2dd4bf;
        }

        /* Particle effects */
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: rgba(45, 212, 191, 0.6);
            border-radius: 50%;
            animation: particleFloat 20s infinite linear;
        }

        @keyframes particleFloat {
            0% {
                transform: translateY(100vh) translateX(0) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100px) translateX(100px) rotate(360deg);
                opacity: 0;
            }
        }

        /* Fade in animations */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease-out forwards;
        }

        .fade-in-delay-1 { animation-delay: 0.2s; }
        .fade-in-delay-2 { animation-delay: 0.4s; }
        .fade-in-delay-3 { animation-delay: 0.6s; }
        .fade-in-delay-4 { animation-delay: 0.8s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Logo pulse */
        .logo-pulse {
            animation: logoPulse 4s ease-in-out infinite;
        }

        @keyframes logoPulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        /* Contact info icons */
        .contact-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2dd4bf, #38bdf8);
            margin-right: 10px;
            transition: transform 0.3s ease;
        }

        .contact-icon:hover {
            transform: rotate(360deg) scale(1.2);
        }
    </style>
</head>
<body class="bg-gray-100">
   
    <!-- Animated Footer -->
    <footer class="relative gradient-bg text-gray-100 py-16 overflow-hidden">
        <!-- Modern animated border at top -->
        <div class="modern-border"></div>
        
        <!-- Floating background particles -->
        <div class="particles"></div>
        
        <!-- Floating background elements -->
        <div class="absolute inset-0 opacity-10">
            <div class="absolute top-20 left-10 w-32 h-32 bg-teal-400 rounded-full blur-3xl float-element"></div>
            <div class="absolute bottom-20 right-20 w-40 h-40 bg-blue-400 rounded-full blur-3xl float-element-reverse"></div>
            <div class="absolute top-1/2 left-1/4 w-24 h-24 bg-purple-400 rounded-full blur-2xl float-element" style="animation-delay: -2s;"></div>
            <div class="absolute top-1/3 right-1/3 w-28 h-28 bg-pink-400 rounded-full blur-3xl float-element-reverse" style="animation-delay: -4s;"></div>
        </div>

        <div class="container mx-auto px-6 relative z-10">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-12">
                <!-- Brand Section -->
                <div class="fade-in fade-in-delay-1">
                    <div class="logo-pulse">
                        <h4 class="text-3xl font-bold text-glow mb-6 flex items-center">
                            <div class="w-12 h-12 bg-gradient-to-br from-teal-400 to-blue-500 rounded-xl mr-3 flex items-center justify-center glow-effect">
                                <i class="fas fa-home text-xl text-white"></i>
                            </div>
                            SaleSphere
                        </h4>
                    </div>
                    <p class="text-slate-300 text-lg mb-6 leading-relaxed">Smart. Secure. Simplified Rentals.</p>
                    <div class="flex space-x-2">
                        <div class="w-3 h-3 bg-teal-400 rounded-full animate-pulse"></div>
                        <div class="w-3 h-3 bg-blue-400 rounded-full animate-pulse" style="animation-delay: 0.2s;"></div>
                        <div class="w-3 h-3 bg-purple-400 rounded-full animate-pulse" style="animation-delay: 0.4s;"></div>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="fade-in fade-in-delay-2">
                    <h4 class="text-xl font-bold text-teal-400 mb-6 flex items-center">
                        <div class="w-2 h-2 bg-teal-400 rounded-full mr-3 animate-pulse"></div>
                        Quick Links
                    </h4>
                    <ul class="space-y-4">
                        <li>
                            <a href="#" class="link-hover text-slate-300 hover:text-teal-400 flex items-center group">
                                <i class="fas fa-building mr-3 text-teal-400 group-hover:scale-110 transition-transform"></i>
                                Properties
                            </a>
                        </li>
                        <li>
                            <a href="#" class="link-hover text-slate-300 hover:text-teal-400 flex items-center group">
                                <i class="fas fa-users mr-3 text-teal-400 group-hover:scale-110 transition-transform"></i>
                                About Us
                            </a>
                        </li>
                        <li>
                            <a href="#" class="link-hover text-slate-300 hover:text-teal-400 flex items-center group">
                                <i class="fas fa-phone mr-3 text-teal-400 group-hover:scale-110 transition-transform"></i>
                                Contact
                            </a>
                        </li>
                        <li>
                            <a href="#" class="link-hover text-slate-300 hover:text-teal-400 flex items-center group">
                                <i class="fas fa-blog mr-3 text-teal-400 group-hover:scale-110 transition-transform"></i>
                                Blog
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div class="fade-in fade-in-delay-3">
                    <h4 class="text-xl font-bold text-teal-400 mb-6 flex items-center">
                        <div class="w-2 h-2 bg-teal-400 rounded-full mr-3 animate-pulse"></div>
                        Contact Info
                    </h4>
                    <ul class="space-y-4 text-slate-300">
                        <li class="flex items-center hover:text-white transition-colors">
                            <div class="contact-icon">
                                <i class="fas fa-map-marker-alt text-white text-sm"></i>
                            </div>
                            456 RentHub Avenue<br>Colombo, LK 00100
                        </li>
                        <li class="flex items-center hover:text-white transition-colors">
                            <div class="contact-icon">
                                <i class="fas fa-phone text-white text-sm"></i>
                            </div>
                            (+94) 76 479 2982
                        </li>
                        <li class="flex items-center hover:text-white transition-colors">
                            <div class="contact-icon">
                                <i class="fas fa-envelope text-white text-sm"></i>
                            </div>
                            lakshithadilshan@gmail.com
                        </li>
                        <li class="flex items-center hover:text-white transition-colors">
                            <div class="contact-icon">
                                <i class="fas fa-clock text-white text-sm"></i>
                            </div>
                            Mon-Fri: 9AM-6PM
                        </li>
                    </ul>
                </div>

                <!-- Social Media -->
                <div class="fade-in fade-in-delay-4">
                    <h4 class="text-xl font-bold text-teal-400 mb-6 flex items-center">
                        <div class="w-2 h-2 bg-teal-400 rounded-full mr-3 animate-pulse"></div>
                        Connect With Us
                    </h4>
                    <div class="flex space-x-4 mb-6">
                        <a href="#" class="social-icon group" title="Facebook">
                            <i class="fab fa-facebook-f text-teal-400 group-hover:text-white transition-colors"></i>
                        </a>
                        <a href="#" class="social-icon group" title="Twitter">
                            <i class="fab fa-twitter text-teal-400 group-hover:text-white transition-colors"></i>
                        </a>
                        <a href="#" class="social-icon group" title="Instagram">
                            <i class="fab fa-instagram text-teal-400 group-hover:text-white transition-colors"></i>
                        </a>
                        <a href="#" class="social-icon group" title="LinkedIn">
                            <i class="fab fa-linkedin-in text-teal-400 group-hover:text-white transition-colors"></i>
                        </a>
                    </div>
                    
                    <!-- Newsletter Signup -->
                    <div class="bg-slate-800/50 backdrop-blur-sm p-4 rounded-xl border border-teal-400/20">
                        <p class="text-sm text-slate-300 mb-3">Subscribe to our newsletter</p>
                        <div class="flex">
                            <input type="email" placeholder="Your email" class="flex-1 bg-slate-700 text-white px-3 py-2 rounded-l-lg text-sm focus:outline-none focus:ring-2 focus:ring-teal-400">
                            <button class="bg-gradient-to-r from-teal-500 to-blue-500 px-4 py-2 rounded-r-lg hover:from-teal-600 hover:to-blue-600 transition-all">
                                <i class="fas fa-paper-plane text-white"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Copyright Section -->
            <div class="border-t border-slate-700/50 mt-12 pt-8 text-center">
                <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
                    <p class="text-slate-400 text-sm">
                        &copy; 2025 <span class="text-teal-400 font-semibold">SaleSphere</span>. All rights reserved.
                    </p>
                    <div class="flex space-x-6 text-sm">
                        <a href="#" class="text-slate-400 hover:text-teal-400 transition-colors">Privacy Policy</a>
                        <a href="#" class="text-slate-400 hover:text-teal-400 transition-colors">Terms of Service</a>
                        <a href="#" class="text-slate-400 hover:text-teal-400 transition-colors">Cookie Policy</a>
                    </div>
                </div>
                
                <!-- Back to top button -->
                <button onclick="scrollToTop()" class="mt-6 bg-gradient-to-r from-teal-500 to-blue-500 hover:from-teal-600 hover:to-blue-600 text-white p-3 rounded-full glow-effect transition-all hover:scale-110">
                    <i class="fas fa-chevron-up"></i>
                </button>
            </div>
        </div>
    </footer>

    <script>
        // Generate floating particles
        function createParticle() {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            particle.style.left = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 20 + 's';
            particle.style.animationDuration = (Math.random() * 15 + 15) + 's';
            
            // Random particle colors
            const colors = [
                'rgba(45, 212, 191, 0.6)',
                'rgba(56, 189, 248, 0.6)', 
                'rgba(139, 92, 246, 0.6)',
                'rgba(236, 72, 153, 0.6)'
            ];
            particle.style.background = colors[Math.floor(Math.random() * colors.length)];
            
            document.querySelector('.particles').appendChild(particle);
            
            // Remove particle after animation
            setTimeout(() => {
                if (particle.parentNode) {
                    particle.remove();
                }
            }, 20000);
        }

        // Create particles periodically
        setInterval(createParticle, 3000);

        // Initial particles
        for (let i = 0; i < 8; i++) {
            setTimeout(createParticle, i * 500);
        }

        // Smooth scroll to top
        function scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }

        // Intersection Observer for fade-in animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationPlayState = 'running';
                }
            });
        }, observerOptions);

        // Observe all fade-in elements
        document.querySelectorAll('.fade-in').forEach(el => {
            el.style.animationPlayState = 'paused';
            observer.observe(el);
        });

        // Parallax effect for floating elements
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const footer = document.querySelector('footer');
            const footerTop = footer.offsetTop;
            
            if (scrolled + window.innerHeight > footerTop) {
                const parallaxElements = footer.querySelectorAll('.float-element, .float-element-reverse');
                parallaxElements.forEach((element, index) => {
                    const speed = (index % 2 === 0 ? 0.1 : -0.1);
                    const yPos = -(scrolled - footerTop) * speed;
                    element.style.transform = `translateY(${yPos}px)`;
                });
            }
        });

        // Add click ripple effect to social icons
        document.querySelectorAll('.social-icon').forEach(icon => {
            icon.addEventListener('click', function(e) {
                e.preventDefault();
                
                const ripple = document.createElement('div');
                ripple.style.cssText = `
                    position: absolute;
                    border-radius: 50%;
                    background: rgba(45, 212, 191, 0.6);
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    pointer-events: none;
                    width: 100%;
                    height: 100%;
                    top: 0;
                    left: 0;
                `;
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>