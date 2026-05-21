<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>About Us - RentSphere</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="client/css/about.css">
</head>
<body class="bg-slate-900 text-gray-100 font-sans overflow-x-hidden">

<!-- Header -->
<c:choose>
    <c:when test="${isLoggedIn}">
        <jsp:include page="./partials/sessionheader.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="./partials/header.jsp" />
    </c:otherwise>
</c:choose>

<!-- Main Content -->
<main>
    <!-- Animated Background Particles -->
    <div id="particles-container" class="fixed inset-0 pointer-events-none z-0"></div>

    <!-- Hero Section -->
    <section class="relative py-32 gradient-bg overflow-hidden">
        <div class="absolute inset-0">
            <div class="absolute top-20 left-20 w-32 h-32 bg-teal-500/20 rounded-full blur-xl floating-animation"></div>
            <div class="absolute bottom-20 right-20 w-48 h-48 bg-blue-500/20 rounded-full blur-xl floating-delayed"></div>
            <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-64 h-64 bg-gradient-to-r from-teal-500/10 to-blue-500/10 rounded-full blur-3xl"></div>
        </div>
        <div class="container mx-auto px-6 text-center relative z-10">
            <div class="fade-in-up">
                <h1 class="text-6xl md:text-7xl font-bold text-gradient mb-8 leading-tight">Our Mission</h1>
                <div class="w-24 h-1 bg-gradient-to-r from-teal-400 to-blue-400 mx-auto mb-8 pulse-glow"></div>
                <p class="text-2xl md:text-3xl text-slate-300 max-w-4xl mx-auto leading-relaxed font-light">
                    Empowering tenants and landlords with a
                    <span class="text-teal-400 font-semibold">seamless</span> and
                    <span class="text-blue-400 font-semibold">secure</span>
                    property rental experience
                </p>
            </div>
            <div class="mt-12 fade-in-up" style="animation-delay:0.3s">
                <button class="glass-effect px-8 py-4 rounded-full text-white font-semibold hover:bg-teal-500/20 transition-all duration-300 scale-on-hover glow-effect">
                    <i class="fas fa-rocket mr-2"></i> Discover Our Journey
                </button>
            </div>
        </div>
    </section>

    <!-- History Section -->
    <section class="py-24 bg-slate-900 relative">
        <div class="container mx-auto px-6">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
                <div class="fade-in-up">
                    <div class="relative group">
                        <div class="absolute -inset-4 bg-gradient-to-r from-teal-500 to-blue-500 rounded-2xl blur opacity-25 group-hover:opacity-40 transition-opacity duration-500"></div>
                        <img src="https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg" alt="RentSphere History" class="relative rounded-2xl shadow-2xl w-full h-96 object-cover transform transition-transform duration-700 group-hover:scale-105" />
                        <div class="absolute -bottom-6 -right-6 glass-effect p-6 rounded-xl">
                            <div class="text-center">
                                <div class="text-2xl font-bold text-teal-400">5+</div>
                                <div class="text-sm text-slate-300">Years Strong</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fade-in-up space-y-8">
                    <h2 class="text-5xl font-bold text-white mb-6 leading-tight">
                        Built on <span class="text-gradient">Trust</span> & <span class="text-gradient">Innovation</span>
                    </h2>
                    <div class="w-16 h-1 bg-gradient-to-r from-teal-400 to-blue-400 mb-8"></div>
                    <p class="text-lg text-slate-300 leading-relaxed">Since our founding, <span class="text-teal-400 font-semibold">RentSphere</span> has focused on solving rental industry pain points with cutting-edge technology and transparency.</p>
                    <p class="text-lg text-slate-300 leading-relaxed">From simple booking systems to comprehensive landlord dashboards, our platform evolves to serve real needs in a fast-moving world.</p>
                    <div class="grid grid-cols-3 gap-6 pt-8">
                        <div class="text-center">
                            <div class="text-3xl font-bold text-teal-400">10K+</div>
                            <div class="text-sm text-slate-400">Happy Tenants</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-blue-400">2K+</div>
                            <div class="text-sm text-slate-400">Landlords</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-green-400">99.9%</div>
                            <div class="text-sm text-slate-400">Uptime</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-24 gradient-bg relative overflow-hidden">
        <div class="absolute top-0 left-1/4 w-72 h-72 bg-teal-500/10 rounded-full blur-3xl floating-animation"></div>
        <div class="absolute bottom-0 right-1/4 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl floating-delayed"></div>
        <div class="container mx-auto px-6 relative z-10">
            <div class="text-center mb-20 fade-in-up">
                <h2 class="text-5xl font-bold text-gradient mb-6">Our Core Values</h2>
                <div class="w-24 h-1 bg-gradient-to-r from-teal-400 to-blue-400 mx-auto mb-8"></div>
                <p class="text-xl text-slate-300 max-w-2xl mx-auto">The principles that guide everything we do</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Transparency -->
                <div class="fade-in-up modern-card p-8 rounded-2xl text-center scale-on-hover group">
                    <div class="relative mb-8">
                        <div class="absolute inset-0 bg-yellow-400/20 rounded-full blur-xl scale-75 group-hover:scale-100 transition-transform duration-500"></div>
                        <div class="relative text-6xl text-yellow-400 mb-6 group-hover:scale-110 group-hover:rotate-12"><i class="fas fa-eye"></i></div>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-white group-hover:text-yellow-400">Transparency</h3>
                    <p class="text-slate-300">Clear, honest, and upfront in every interaction. No hidden fees, no surprises.</p>
                </div>
                <!-- Empowerment -->
                <div class="fade-in-up modern-card p-8 rounded-2xl text-center scale-on-hover group">
                    <div class="relative mb-8">
                        <div class="absolute inset-0 bg-green-400/20 rounded-full blur-xl scale-75 group-hover:scale-100 transition-transform duration-500"></div>
                        <div class="relative text-6xl text-green-400 mb-6 group-hover:scale-110 group-hover:rotate-12"><i class="fas fa-users-cog"></i></div>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-white group-hover:text-green-400">Empowerment</h3>
                    <p class="text-slate-300">Enabling both landlords and tenants to make informed decisions with confidence.</p>
                </div>
                <!-- Innovation -->
                <div class="fade-in-up modern-card p-8 rounded-2xl text-center scale-on-hover group">
                    <div class="relative mb-8">
                        <div class="absolute inset-0 bg-blue-400/20 rounded-full blur-xl scale-75 group-hover:scale-100 transition-transform duration-500"></div>
                        <div class="relative text-6xl text-blue-400 mb-6 group-hover:scale-110 group-hover:rotate-12"><i class="fas fa-lightbulb"></i></div>
                    </div>
                    <h3 class="text-2xl font-bold mb-4 text-white group-hover:text-blue-400">Innovation</h3>
                    <p class="text-slate-300">Constantly improving with cutting-edge, user-first technology solutions.</p>
                </div>
            </div>
            <div class="text-center mt-20 fade-in-up">
                <button class="glass-effect px-12 py-5 rounded-full text-white font-semibold hover:bg-teal-500/20 transition-all duration-300 scale-on-hover text-lg">
                    <i class="fas fa-handshake mr-3"></i> Join Our Community
                </button>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<!-- Scripts -->
<script>
    // Intersection Observer
    const observer = new IntersectionObserver((entries)=>{
        entries.forEach(entry=>{
            if(entry.isIntersecting){ entry.target.classList.add('visible'); }
        });
    }, { threshold:0.1, rootMargin:'0px 0px -50px 0px' });
    document.querySelectorAll('.fade-in-up').forEach(el=>observer.observe(el));

    // Floating particles
    function createParticles(){
        const container=document.getElementById('particles-container');
        for(let i=0;i<15;i++){
            setTimeout(()=>{
                const particle=document.createElement('div');
                particle.className='particle';
                particle.style.left=Math.random()*100+'vw';
                particle.style.animationDuration=(Math.random()*8+5)+'s';
                particle.style.animationDelay=Math.random()*2+'s';
                container.appendChild(particle);
                setTimeout(()=>{ if(particle.parentNode){ particle.parentNode.removeChild(particle);} },15000);
            },i*200);
        }
    }
    createParticles();
    setInterval(createParticles,10000);
</script>
</body>
</html>
