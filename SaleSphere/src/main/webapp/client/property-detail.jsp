<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${property.title} - RentSphere</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');

        body { font-family: 'Inter', sans-serif; }

        .gradient-bg {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
        }

        .glass-effect {
            backdrop-filter: blur(20px);
            background: rgba(30, 41, 59, 0.8);
            border: 1px solid rgba(148, 163, 184, 0.1);
        }

        .image-gallery {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
            height: 500px;
        }

        .main-image {
            grid-column: span 3;
            grid-row: span 2;
        }

        .gallery-image {
            overflow: hidden;
            border-radius: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .gallery-image:hover {
            transform: scale(1.05);
            box-shadow: 0 20px 40px rgba(20, 184, 166, 0.3);
        }

        .gallery-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .status-badge {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: .8; }
        }

        .price-tag {
            background: linear-gradient(135deg, #14b8a6, #06b6d4);
            box-shadow: 0 10px 30px rgba(20, 184, 166, 0.4);
        }

        .review-card {
            background: linear-gradient(145deg, rgba(30, 41, 59, 0.6), rgba(15, 23, 42, 0.4));
            backdrop-filter: blur(10px);
            border: 1px solid rgba(148, 163, 184, 0.1);
            transition: all 0.3s ease;
        }

        .review-card:hover {
            transform: translateY(-5px);
            border-color: rgba(20, 184, 166, 0.3);
            box-shadow: 0 15px 30px rgba(20, 184, 166, 0.2);
        }

        .rating-bar {
            background: rgba(148, 163, 184, 0.2);
            border-radius: 9999px;
            overflow: hidden;
            height: 8px;
        }

        .rating-fill {
            background: linear-gradient(90deg, #fbbf24, #f59e0b);
            height: 100%;
            transition: width 1s ease;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            margin: auto;
            display: block;
            max-width: 90%;
            max-height: 90%;
            animation: zoomIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes zoomIn {
            from { transform: scale(0.7); }
            to { transform: scale(1); }
        }

        .feature-icon {
            background: linear-gradient(135deg, #14b8a6, #0d9488);
            box-shadow: 0 4px 15px rgba(20, 184, 166, 0.3);
        }

        .property-card-mini {
            background: linear-gradient(145deg, rgba(30, 41, 59, 0.9), rgba(15, 23, 42, 0.8));
            backdrop-filter: blur(10px);
            border: 1px solid rgba(148, 163, 184, 0.1);
            transition: all 0.4s ease;
        }

        .property-card-mini:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(20, 184, 166, 0.3);
            border-color: rgba(20, 184, 166, 0.3);
        }

        .contact-card {
            background: linear-gradient(135deg, rgba(20, 184, 166, 0.1), rgba(6, 182, 212, 0.1));
            border: 2px solid rgba(20, 184, 166, 0.3);
        }

        .glow-text {
            text-shadow: 0 0 20px rgba(20, 184, 166, 0.5);
        }
    </style>
</head>
<body class="gradient-bg text-white">

<!-- Header -->
<c:choose>
    <c:when test="${isLoggedIn}">
        <jsp:include page="./partials/sessionheader.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="./partials/header.jsp" />
    </c:otherwise>
</c:choose>

<!-- Back Button -->
<div class="container mx-auto px-6 py-6">
    <a href="${pageContext.request.contextPath}/properties"
       class="inline-flex items-center gap-2 glass-effect px-6 py-3 rounded-xl hover:bg-teal-500/20 transition-all">
        <i class="fas fa-arrow-left"></i>
        <span>Back to Properties</span>
    </a>
</div>

<!-- Main Content -->
<div class="container mx-auto px-6 pb-20">

    <!-- Image Gallery -->
    <div class="mb-12">
        <div class="image-gallery">
            <!-- Main Image -->
            <div class="gallery-image main-image">
                <img src="${pageContext.request.contextPath}/assets/properties/${not empty property.mainImage ? property.mainImage : 'default.jpg'}"
                     alt="${property.title}"
                     onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'">
                <div class="absolute top-4 left-4">
                    <span class="status-badge px-6 py-3 rounded-full text-sm font-bold text-white
                        ${property.status eq 'Available' ? 'bg-green-500' : property.status eq 'Booked' ? 'bg-orange-500' : 'bg-red-500'}">
                        <i class="fas fa-circle mr-2"></i>${property.status}
                    </span>
                </div>
            </div>

            <!-- Additional Images -->
            <c:if test="${not empty property.image1}">
                <div class="gallery-image" onclick="openModal('${pageContext.request.contextPath}/assets/properties/${property.image1}')">
                    <img src="${pageContext.request.contextPath}/assets/properties/${property.image1}"
                         alt="${property.title}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'">
                </div>
            </c:if>
            
            <c:if test="${not empty property.image2}">
                <div class="gallery-image" onclick="openModal('${pageContext.request.contextPath}/assets/properties/${property.image2}')">
                    <img src="${pageContext.request.contextPath}/assets/properties/${property.image2}"
                         alt="${property.title}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'">
                </div>
            </c:if>
            
            <c:if test="${not empty property.image3}">
                <div class="gallery-image" onclick="openModal('${pageContext.request.contextPath}/assets/properties/${property.image3}')">
                    <img src="${pageContext.request.contextPath}/assets/properties/${property.image3}"
                         alt="${property.title}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'">
                </div>
            </c:if>
            
            <c:if test="${not empty property.image4}">
                <div class="gallery-image" onclick="openModal('${pageContext.request.contextPath}/assets/properties/${property.image4}')">
                    <img src="${pageContext.request.contextPath}/assets/properties/${property.image4}"
                         alt="${property.title}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'">
                </div>
            </c:if>
            
            <c:if test="${not empty property.image5}">
                <div class="gallery-image" onclick="openModal('${pageContext.request.contextPath}/assets/properties/${property.image5}')">
                    <img src="${pageContext.request.contextPath}/assets/properties/${property.image5}"
                         alt="${property.title}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'">
                </div>
            </c:if>
            
            <!-- Fill remaining spaces if less than 5 images -->
            <c:if test="${empty property.image1 && empty property.image2 && empty property.image3 && empty property.image4 && empty property.image5}">
                <c:forEach begin="1" end="4">
                    <div class="gallery-image" onclick="openModal('${pageContext.request.contextPath}/assets/properties/default.jpg')">
                        <img src="${pageContext.request.contextPath}/assets/properties/default.jpg" alt="No additional images available">
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

        <!-- Left Column - Property Details -->
        <div class="lg:col-span-2 space-y-8">

            <!-- Property Header -->
            <div class="glass-effect rounded-3xl p-8">
                <div class="flex justify-between items-start mb-6">
                    <div>
                        <h1 class="text-4xl font-black text-white mb-2 glow-text">${property.title}</h1>
                        <div class="flex items-center text-slate-300 text-lg">
                            <i class="fas fa-map-marker-alt text-teal-400 mr-3"></i>
                            <span>${property.address}</span>
                        </div>
                    </div>
                    <div class="price-tag px-8 py-4 rounded-2xl text-right">
                        <div class="text-sm text-white/80">Monthly Rent</div>
                        <div class="text-4xl font-black text-white">Rs. <fmt:formatNumber value="${property.rent}" pattern="#,##0"/></div>
                    </div>
                </div>

                <!-- Property Features -->
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mt-8">
                    <div class="text-center p-4 glass-effect rounded-xl">
                        <div class="feature-icon w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-2">
                            <i class="fas fa-building text-white"></i>
                        </div>
                        <div class="text-sm text-slate-400">Type</div>
                        <div class="font-bold text-white">${property.type}</div>
                    </div>
                    <div class="text-center p-4 glass-effect rounded-xl">
                        <div class="feature-icon w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-2">
                            <i class="fas fa-hashtag text-white"></i>
                        </div>
                        <div class="text-sm text-slate-400">Property ID</div>
                        <div class="font-bold text-white">#${property.propertyId}</div>
                    </div>
                    <div class="text-center p-4 glass-effect rounded-xl">
                        <div class="feature-icon w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-2">
                            <i class="fas fa-star text-white"></i>
                        </div>
                        <div class="text-sm text-slate-400">Rating</div>
                        <div class="font-bold text-white">${reviewStats.averageRating} / 5</div>
                    </div>
                    <div class="text-center p-4 glass-effect rounded-xl">
                        <div class="feature-icon w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-2">
                            <i class="fas fa-comments text-white"></i>
                        </div>
                        <div class="text-sm text-slate-400">Reviews</div>
                        <div class="font-bold text-white">${reviewStats.totalReviews}</div>
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="glass-effect rounded-3xl p-8">
                <h2 class="text-2xl font-bold text-teal-400 mb-4 flex items-center">
                    <i class="fas fa-info-circle mr-3"></i>
                    Property Description
                </h2>
                <p class="text-slate-300 leading-relaxed text-lg">
                    ${property.description != null ? property.description : 'No description available for this property.'}
                </p>
            </div>

            <!-- Location Map -->
            <div class="glass-effect rounded-3xl p-8">
                <h2 class="text-2xl font-bold text-teal-400 mb-4 flex items-center">
                    <i class="fas fa-map-marked-alt mr-3"></i>
                    Location
                </h2>
                <div class="bg-slate-700 rounded-xl overflow-hidden h-96">
                    <iframe
                            width="100%"
                            height="100%"
                            frameborder="0"
                            scrolling="no"
                            marginheight="0"
                            marginwidth="0"
                            src="https://maps.google.com/maps?q=${property.address}&t=&z=15&ie=UTF8&iwloc=&output=embed">
                    </iframe>
                </div>
                <div class="mt-4 flex items-center text-slate-300">
                    <i class="fas fa-location-arrow text-teal-400 mr-3"></i>
                    <span class="font-medium">${property.address}</span>
                </div>
            </div>

            <!-- Reviews Section -->
            <div class="glass-effect rounded-3xl p-8">
                <h2 class="text-2xl font-bold text-teal-400 mb-6 flex items-center">
                    <i class="fas fa-star mr-3"></i>
                    Reviews & Ratings
                </h2>

                <c:choose>
                    <c:when test="${reviewStats.totalReviews > 0}">
                        <!-- Rating Overview -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
                            <!-- Average Rating -->
                            <div class="text-center p-6 glass-effect rounded-xl">
                                <div class="text-6xl font-black text-teal-400 mb-2">${reviewStats.averageRating}</div>
                                <div class="flex justify-center mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star ${i <= reviewStats.averageRating ? 'text-yellow-400' : 'text-slate-600'}"></i>
                                    </c:forEach>
                                </div>
                                <div class="text-slate-400">Based on ${reviewStats.totalReviews} reviews</div>
                            </div>

                            <!-- Rating Distribution -->
                            <div class="space-y-3">
                                <c:forEach begin="1" end="5" var="rating">
                                    <c:set var="starCount" value="${6 - rating}" />
                                    <c:set var="percentKey" value="${starCount == 5 ? 'fiveStarPercent' : starCount == 4 ? 'fourStarPercent' : starCount == 3 ? 'threeStarPercent' : starCount == 2 ? 'twoStarPercent' : 'oneStarPercent'}" />
                                    <div class="flex items-center gap-3">
                                        <span class="text-sm text-slate-300 w-16">${starCount} stars</span>
                                        <div class="flex-1 rating-bar">
                                            <div class="rating-fill" style="width: ${reviewStats[percentKey]}%"></div>
                                        </div>
                                        <span class="text-sm text-slate-400 w-12">${reviewStats[percentKey]}%</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Individual Reviews -->
                        <div class="space-y-4">
                            <c:forEach var="review" items="${reviews}">
                                <div class="review-card p-6 rounded-xl">
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-12 h-12 bg-teal-500 rounded-full flex items-center justify-center text-white font-bold text-lg">
                                                    ${review.tenantName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div>
                                                <div class="font-bold text-white">${review.tenantName}</div>
                                                <div class="text-sm text-slate-400">${review.reviewedAt}</div>
                                            </div>
                                        </div>
                                        <div class="flex gap-1">
                                            <c:forEach begin="1" end="${review.rating}">
                                                <i class="fas fa-star text-yellow-400"></i>
                                            </c:forEach>
                                            <c:forEach begin="${review.rating + 1}" end="5">
                                                <i class="far fa-star text-slate-600"></i>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <p class="text-slate-300 leading-relaxed">${review.comment}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-12">
                            <i class="fas fa-comments text-6xl text-slate-600 mb-4"></i>
                            <h3 class="text-xl font-bold text-slate-400 mb-2">No Reviews Yet</h3>
                            <p class="text-slate-500">Be the first to review this property!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <!-- Right Column - Landlord Info & Actions -->
        <div class="lg:col-span-1 space-y-6">

            <!-- Book Property Card -->
            <div class="glass-effect rounded-3xl p-8 sticky top-6">
                <h3 class="text-2xl font-bold text-white mb-6">Book This Property</h3>

                <div class="space-y-4 mb-6">
                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Monthly Rent</span>
                        <span class="text-2xl font-bold text-teal-400">Rs. <fmt:formatNumber value="${property.rent}" pattern="#,##0"/></span>
                    </div>
                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Status</span>
                        <span class="px-4 py-2 rounded-full text-sm font-bold
                            ${property.status eq 'Available' ? 'bg-green-500' : property.status eq 'Booked' ? 'bg-orange-500' : 'bg-red-500'}">
                            ${property.status}
                        </span>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/book-property?id=${property.propertyId}"
                   class="block w-full py-4 bg-gradient-to-r from-teal-500 to-blue-500 text-white text-center rounded-xl font-bold text-lg hover:shadow-2xl transition-all transform hover:scale-105"
                   onclick="return checkAvailability('${property.status}')">
                    <i class="fas fa-calendar-check mr-2"></i>
                    Book Now
                </a>
            </div>

            <!-- Landlord Contact Card -->
            <div class="contact-card rounded-3xl p-8">
                <h3 class="text-xl font-bold text-white mb-6 flex items-center">
                    <i class="fas fa-user-circle text-teal-400 mr-3"></i>
                    Contact Landlord
                </h3>

                <div class="space-y-4">
                    <div class="flex items-center gap-3 p-4 glass-effect rounded-xl">
                        <div class="w-12 h-12 bg-teal-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-user text-white"></i>
                        </div>
                        <div>
                            <div class="text-xs text-slate-400">Name</div>
                            <div class="font-bold text-white">${property.landlordName}</div>
                        </div>
                    </div>

                    <div class="flex items-center gap-3 p-4 glass-effect rounded-xl">
                        <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-envelope text-white"></i>
                        </div>
                        <div class="flex-1">
                            <div class="text-xs text-slate-400">Email</div>
                            <div class="font-medium text-white break-all">${property.landlordEmail}</div>
                        </div>
                    </div>

                    <a href="mailto:${property.landlordEmail}"
                       class="block w-full py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white text-center rounded-xl font-bold hover:shadow-lg transition-all">
                        <i class="fas fa-paper-plane mr-2"></i>
                        Send Email
                    </a>
                </div>
            </div>

            <!-- Property Info Card -->
            <div class="glass-effect rounded-3xl p-8">
                <h3 class="text-xl font-bold text-white mb-4">Property Information</h3>
                <div class="space-y-3">
                    <div class="flex justify-between py-2 border-b border-slate-700">
                        <span class="text-slate-400">Property ID</span>
                        <span class="font-bold text-white">#${property.propertyId}</span>
                    </div>
                    <div class="flex justify-between py-2 border-b border-slate-700">
                        <span class="text-slate-400">Type</span>
                        <span class="font-bold text-white">${property.type}</span>
                    </div>
                    <div class="flex justify-between py-2 border-b border-slate-700">
                        <span class="text-slate-400">Listed Date</span>
                        <span class="font-bold text-white">${property.createdAt}</span>
                    </div>
                    <div class="flex justify-between py-2">
                        <span class="text-slate-400">Landlord ID</span>
                        <span class="font-bold text-white">#${property.landlordId}</span>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Similar Properties -->
    <c:if test="${not empty similarProperties}">
        <div class="mt-16">
            <h2 class="text-3xl font-bold text-white mb-8 flex items-center">
                <i class="fas fa-home text-teal-400 mr-3"></i>
                Similar Properties
            </h2>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <c:forEach var="similar" items="${similarProperties}">
                    <div class="property-card-mini rounded-2xl overflow-hidden">
                        <div class="relative h-48">
                            <c:choose>
                                <c:when test="${not empty similar.mainImage}">
                                    <img src="${pageContext.request.contextPath}/assets/properties/${similar.mainImage}"
                                         alt="${similar.title}"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'"
                                         class="w-full h-full object-cover">
                                </c:when>
                                <c:otherwise>
                                    <div class="w-full h-full bg-gradient-to-br from-slate-700 to-slate-800 flex items-center justify-center">
                                        <div class="text-center text-white">
                                            <i class="fas fa-image text-2xl mb-2 opacity-50"></i>
                                            <p class="text-xs opacity-75">No Image</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="absolute top-3 right-3">
                                <span class="px-3 py-1 rounded-full text-xs font-bold
                                    ${similar.status eq 'Available' ? 'bg-green-500' : similar.status eq 'Booked' ? 'bg-orange-500' : 'bg-red-500'}">
                                        ${similar.status}
                                </span>
                            </div>
                        </div>

                        <div class="p-6">
                            <h3 class="text-xl font-bold text-white mb-2">${similar.title}</h3>
                            <div class="flex items-center text-slate-400 text-sm mb-3">
                                <i class="fas fa-map-marker-alt text-teal-400 mr-2"></i>
                                <span>${similar.address}</span>
                            </div>

                            <div class="flex justify-between items-center mb-4">
                                <div class="text-2xl font-bold text-teal-400">
                                    Rs. <fmt:formatNumber value="${similar.rent}" pattern="#,##0"/>
                                    <span class="text-xs text-slate-400">/mo</span>
                                </div>
                                <span class="glass-effect px-3 py-1 rounded-full text-sm">
                                    <i class="fas fa-building text-teal-400 mr-1"></i>
                                    ${similar.type}
                                </span>
                            </div>

                            <a href="${pageContext.request.contextPath}/property-detail?id=${similar.propertyId}"
                               class="block w-full py-3 bg-gradient-to-r from-teal-600 to-teal-700 text-white text-center rounded-xl font-bold hover:shadow-lg transition-all">
                                <i class="fas fa-eye mr-2"></i>
                                View Details
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

</div>

<!-- Image Modal -->
<div id="imageModal" class="modal" onclick="closeModal()">
    <span class="absolute top-8 right-12 text-white text-5xl font-bold cursor-pointer hover:text-teal-400 transition-colors z-10">&times;</span>
    <img class="modal-content" id="modalImage">
    <div class="text-center mt-4">
        <button onclick="closeModal()" class="glass-effect px-6 py-3 rounded-xl text-white hover:bg-teal-500/20 transition-all">
            <i class="fas fa-times mr-2"></i>Close
        </button>
    </div>
</div>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<script>
    // Image Modal
    function openModal(imageSrc) {
        const modal = document.getElementById('imageModal');
        const modalImg = document.getElementById('modalImage');
        modal.style.display = 'flex';
        modal.style.alignItems = 'center';
        modal.style.justifyContent = 'center';
        modal.style.flexDirection = 'column';
        modalImg.src = imageSrc;
    }

    function closeModal() {
        document.getElementById('imageModal').style.display = 'none';
    }

    // Check availability before booking
    function checkAvailability(status) {
        if (status !== 'Available') {
            // Create alert
            const alertDiv = document.createElement('div');
            alertDiv.className = 'fixed top-4 right-4 z-50 glass-effect border border-red-400/30 rounded-xl p-4 max-w-sm transform translate-x-full transition-transform duration-300';
            alertDiv.innerHTML = `
                <div class="flex items-center space-x-3">
                    <i class="fas fa-exclamation-triangle text-red-400 text-xl"></i>
                    <div>
                        <h4 class="font-semibold text-white">Booking Unavailable</h4>
                        <p class="text-sm text-slate-300">This property is currently ${status.toLowerCase()}.</p>
                    </div>
                    <button onclick="this.parentElement.parentElement.remove()" class="text-slate-400 hover:text-white">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;

            document.body.appendChild(alertDiv);

            setTimeout(() => {
                alertDiv.style.transform = 'translateX(0)';
            }, 100);

            setTimeout(() => {
                if (alertDiv.parentElement) {
                    alertDiv.style.transform = 'translateX(400px)';
                    setTimeout(() => alertDiv.remove(), 300);
                }
            }, 5000);

            return false;
        }
        return true;
    }

    // Animate elements on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.addEventListener('DOMContentLoaded', () => {
        // Animate review cards
        document.querySelectorAll('.review-card').forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = `opacity 0.5s ease ${index * 0.1}s, transform 0.5s ease ${index * 0.1}s`;
            observer.observe(card);
        });

        // Animate rating bars
        setTimeout(() => {
            document.querySelectorAll('.rating-fill').forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0';
                setTimeout(() => {
                    bar.style.width = width;
                }, 100);
            });
        }, 500);

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
    });

    // Close modal on Escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeModal();
        }
    });
</script>

</body>
</html>