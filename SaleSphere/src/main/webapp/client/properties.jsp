<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Properties - RentSphere</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <link rel="stylesheet" href="client/css/properties.css">
</head>
<body class="gradient-bg text-white font-sans overflow-x-hidden">

<!-- Header -->
<c:choose>
  <c:when test="${isLoggedIn}">
    <jsp:include page="./partials/sessionheader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="./partials/header.jsp" />
  </c:otherwise>
</c:choose>

<!-- Hero Section -->
<section class="hero-gradient relative py-24 overflow-hidden">
  <div class="absolute inset-0">
    <div class="absolute inset-0 bg-gradient-to-r from-teal-500/10 to-blue-500/10 animate-pulse"></div>
  </div>

  <div class="container mx-auto px-6 relative z-10">
    <div class="text-center animate-float">
      <h1 class="text-6xl md:text-7xl font-black mb-6 glow-text">
        Available <span class="price-highlight">Properties</span>
      </h1>
      <p class="text-xl text-slate-300 max-w-2xl mx-auto">
        Discover your perfect home with our premium collection of modern properties
      </p>
      <div class="mt-8 flex justify-center">
        <div class="w-24 h-1 bg-gradient-to-r from-teal-400 to-blue-500 rounded-full"></div>
      </div>
    </div>
  </div>

  <!-- Floating Elements -->
  <div class="absolute top-20 left-10 w-20 h-20 bg-teal-400/10 rounded-full blur-xl animate-pulse"></div>
  <div class="absolute bottom-20 right-20 w-32 h-32 bg-blue-400/10 rounded-full blur-2xl animate-pulse"></div>
  <div class="absolute top-1/2 right-10 w-16 h-16 bg-purple-400/10 rounded-full blur-lg animate-bounce"></div>
</section>

<!-- Search and Filter Section -->
<section class="py-8 relative">
  <div class="container mx-auto px-6">
    <form id="searchForm" method="GET" action="${pageContext.request.contextPath}/properties" class="glass-effect rounded-3xl p-8 mb-8">
      <!-- Search Bar -->
      <div class="mb-6">
        <div class="relative">
          <i class="fas fa-search absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400 text-lg"></i>
          <input
                  type="text"
                  id="searchInput"
                  name="search"
                  value="${searchTerm}"
                  placeholder="Search by title, address, landlord name, or type..."
                  class="search-input w-full pl-12 pr-4 py-4 rounded-xl text-white placeholder-slate-400"
          >
        </div>
      </div>

      <!-- Hidden status input -->
      <input type="hidden" id="statusInput" name="status" value="${statusFilter}">

      <!-- Filter Buttons -->
      <div class="flex flex-wrap gap-3">
        <button type="button" class="filter-btn ${statusFilter eq 'all' || empty statusFilter ? 'active' : ''} px-6 py-3 rounded-xl font-semibold text-white" data-status="all">
          <i class="fas fa-th-large mr-2"></i>All Properties
        </button>
        <button type="button" class="filter-btn ${statusFilter eq 'Available' ? 'active' : ''} px-6 py-3 rounded-xl font-semibold text-white" data-status="Available">
          <i class="fas fa-check-circle mr-2"></i>Available
        </button>
        <button type="button" class="filter-btn ${statusFilter eq 'Booked' ? 'active' : ''} px-6 py-3 rounded-xl font-semibold text-white" data-status="Booked">
          <i class="fas fa-calendar-check mr-2"></i>Booked
        </button>
        <button type="button" class="filter-btn ${statusFilter eq 'Unavailable' ? 'active' : ''} px-6 py-3 rounded-xl font-semibold text-white" data-status="Unavailable">
          <i class="fas fa-times-circle mr-2"></i>Unavailable
        </button>
        <button type="button" id="resetBtn" class="filter-btn px-6 py-3 rounded-xl font-semibold text-white ml-auto">
          <i class="fas fa-redo mr-2"></i>Reset
        </button>
      </div>

      <!-- Results Counter -->
      <div class="mt-4 text-slate-300 text-sm">
        <c:choose>
          <c:when test="${not empty properties}">
            <span>${properties.size()}</span> properties found
          </c:when>
          <c:otherwise>
            <span>0</span> properties found
          </c:otherwise>
        </c:choose>
      </div>
    </form>
  </div>
</section>

<!-- Main Content -->
<main class="pb-20 relative">
  <div class="container mx-auto px-6">

    <c:choose>
      <c:when test="${empty properties}">
        <!-- Empty State -->
        <div class="text-center py-20">
          <div class="glass-effect rounded-3xl p-12 max-w-md mx-auto">
            <i class="fas fa-search text-6xl text-teal-400 mb-6"></i>
            <h3 class="text-2xl font-bold mb-4">No Properties Found</h3>
            <p class="text-slate-400">Try adjusting your search or filters</p>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Property Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <c:forEach var="property" items="${properties}" varStatus="status">
            <div class="property-card rounded-3xl overflow-hidden group fade-in cursor-pointer" style="animation-delay: ${status.index * 0.1}s" 
                 onclick="window.location.href='${pageContext.request.contextPath}/property-detail?id=${property.propertyId}'">

              <!-- Property Image -->
              <div class="relative overflow-hidden h-64">
                <img src="${pageContext.request.contextPath}/assets/properties/${not empty property.mainImage ? property.mainImage : 'default.jpg'}"
                     alt="${property.title}"
                     onerror="this.src='${pageContext.request.contextPath}/assets/properties/default.jpg'"
                     class="property-image w-full h-full object-cover">

                <!-- Status Badge -->
                <div class="absolute top-4 left-4 z-20">
                  <span class="px-4 py-2 rounded-full text-sm font-semibold text-white
                    <c:choose>
                      <c:when test='${property.status eq "Available"}'>status-available</c:when>
                      <c:when test='${property.status eq "Booked"}'>status-booked</c:when>
                      <c:otherwise>status-unavailable</c:otherwise>
                    </c:choose>
                  ">
                    <i class="fas fa-circle mr-2"></i>${property.status}
                  </span>
                </div>

                <!-- Property ID -->
                <div class="absolute top-4 right-4 z-20">
                  <span class="glass-effect px-3 py-1 rounded-full text-xs font-mono text-teal-400">
                    #${property.propertyId}
                  </span>
                </div>

                <!-- View Details Overlay -->
                <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-40 transition-all duration-300 flex items-center justify-center">
                  <div class="opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    <span class="bg-white text-gray-900 px-6 py-3 rounded-full font-semibold text-lg">
                      <i class="fas fa-eye mr-2"></i>View Details
                    </span>
                  </div>
                </div>
              </div>

              <!-- Property Details -->
              <div class="p-8 relative z-10">
                <h3 class="text-2xl font-bold text-white mb-3 group-hover:text-teal-400 transition-colors duration-300">
                    ${property.title}
                </h3>

                <div class="flex items-center text-slate-300 mb-2">
                  <i class="fas fa-map-marker-alt text-teal-400 mr-3"></i>
                  <span>${property.address}</span>
                </div>

                <div class="flex items-center text-slate-400 text-sm mb-6">
                  <i class="fas fa-user text-teal-400 mr-3"></i>
                  <span>Owned by: <strong class="text-white">${property.landlordName}</strong></span>
                </div>

                <!-- Price and Action Buttons -->
                <div class="flex justify-between items-center mb-6">
                  <div class="text-3xl font-black price-highlight">
                    Rs. ${property.rent}<span class="text-sm text-slate-400 font-normal">/month</span>
                  </div>

                  <div class="flex gap-2">
                    <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}"
                       class="glass-effect text-white px-4 py-3 rounded-xl font-semibold hover:bg-teal-500/20 transition-all duration-300"
                       onclick="event.stopPropagation();">
                      <i class="fas fa-eye mr-2"></i>View
                    </a>
                    <a href="${pageContext.request.contextPath}/book-property?id=${property.propertyId}"
                       class="btn-primary text-white px-4 py-3 rounded-xl font-semibold book-now-btn flex items-center space-x-2 transform transition-all duration-300"
                       data-status="${property.status}"
                       onclick="event.stopPropagation();">
                      <i class="fas fa-calendar-check"></i>
                      <span>Book</span>
                    </a>
                  </div>
                </div>

                <!-- Property Tags -->
                <div class="flex flex-wrap gap-2">
                  <span class="glass-effect px-4 py-2 rounded-full text-sm font-medium">
                    <i class="fas fa-building mr-2 text-teal-400"></i>${property.type}
                  </span>
                  <span class="glass-effect px-4 py-2 rounded-full text-sm font-medium text-slate-300">
                    <i class="fas fa-envelope mr-2 text-blue-400"></i>${property.landlordEmail}
                  </span>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</main>

<!-- Footer -->
<%@ include file="./partials/footer.jsp" %>

<!-- Enhanced JavaScript -->
<script>
  document.addEventListener("DOMContentLoaded", () => {
    const searchForm = document.getElementById('searchForm');
    const searchInput = document.getElementById('searchInput');
    const statusInput = document.getElementById('statusInput');
    const filterButtons = document.querySelectorAll('.filter-btn[data-status]');
    const resetBtn = document.getElementById('resetBtn');
    const bookButtons = document.querySelectorAll(".book-now-btn");

    // Debounce function for search
    let searchTimeout;
    function debounceSearch() {
      clearTimeout(searchTimeout);
      searchTimeout = setTimeout(() => {
        searchForm.submit();
      }, 500); // Wait 500ms after user stops typing
    }

    // Search input handler with debounce
    searchInput.addEventListener('input', debounceSearch);

    // Filter button handlers
    filterButtons.forEach(button => {
      button.addEventListener('click', (e) => {
        e.preventDefault();

        // Remove active class from all buttons
        filterButtons.forEach(btn => btn.classList.remove('active'));

        // Add active class to clicked button
        button.classList.add('active');

        // Update hidden status input
        const status = button.getAttribute('data-status');
        statusInput.value = status;

        // Submit form
        searchForm.submit();
      });
    });

    // Reset button handler
    resetBtn.addEventListener('click', (e) => {
      e.preventDefault();
      window.location.href = '${pageContext.request.contextPath}/properties';
    });

    // Add scroll animations
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

    // Animate property cards on scroll
    document.querySelectorAll('.property-card').forEach((card, index) => {
      card.style.opacity = '0';
      card.style.transform = 'translateY(50px)';
      card.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
      observer.observe(card);
    });

    // Enhanced booking validation with modern alerts
    bookButtons.forEach(button => {
      button.addEventListener("click", (event) => {
        const status = button.getAttribute("data-status");

        if (status !== "Available") {
          event.preventDefault();

          // Create modern alert
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

          // Animate in
          setTimeout(() => {
            alertDiv.style.transform = 'translateX(0)';
          }, 100);

          // Auto remove after 5 seconds
          setTimeout(() => {
            if (alertDiv.parentElement) {
              alertDiv.style.transform = 'translateX(400px)';
              setTimeout(() => alertDiv.remove(), 300);
            }
          }, 5000);
        }
      });
    });

    // Add smooth scrolling
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
</script>

</body>
</html>