<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Edit Property</title>
  <link rel="icon" href="${pageContext.request.contextPath}/admin/assets/favicon.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body class="bg-slate-900 text-gray-100 min-h-screen flex">

  <!-- Sidebar -->
  <%@ include file="../partials/lordsidebar.jsp" %>

  <!-- Main Content -->
  <div class="flex-1 md:ml-60 flex flex-col min-h-screen">

    <!-- Topbar -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Form Content -->
    <main class="flex-1 p-6 overflow-y-auto">
      <div class="mx-auto bg-slate-800 border border-slate-700 rounded-2xl shadow-xl p-8 space-y-6">

        <div class="flex justify-between items-center">
          <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-edit mr-2"></i> Edit Property</h3>
          <a href="${pageContext.request.contextPath}/admin/my-property" class="text-sm text-blue-400 hover:underline">
            ← Back to Property List
          </a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/my-property?action=update" method="POST" enctype="multipart/form-data" class="grid md:grid-cols-2 gap-6">
          <input type="hidden" name="id" value="${property.propertyId}" />

          <!-- Title -->
          <div>
            <label class="block text-sm mb-1" for="title">Title</label>
            <input type="text" id="title" name="title" required value="${property.title}"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Address -->
          <div>
            <label class="block text-sm mb-1" for="address">Address</label>
            <input type="text" id="address" name="address" required value="${property.address}"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Type -->
          <div>
            <label class="block text-sm mb-1" for="type">Type</label>
            <select id="type" name="type" required
                    class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
              <option value="Apartment" ${property.type == 'Apartment' ? 'selected' : ''}>Apartment</option>
              <option value="House" ${property.type == 'House' ? 'selected' : ''}>House</option>
              <option value="Room" ${property.type == 'Room' ? 'selected' : ''}>Room</option>
            </select>
          </div>

          <!-- Rent -->
          <div>
            <label class="block text-sm mb-1" for="rent">Rent (Rs.)</label>
            <input type="number" id="rent" name="rent" min="0" step="0.01" required value="${property.rent}"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Status -->
          <div>
            <label class="block text-sm mb-1" for="status">Status</label>
            <select id="status" name="status" required
                    class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
              <option value="Available" ${property.status == 'Available' ? 'selected' : ''}>Available</option>
              <option value="Rented" ${property.status == 'Rented' ? 'selected' : ''}>Rented</option>
              <option value="Inactive" ${property.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
          </div>

          <!-- Main Image -->
          <div>
            <label class="block text-sm mb-1" for="main_image">Main Image</label>
            <input type="file" id="main_image" name="main_image" accept="image/*"
                   class="w-full text-sm text-gray-300 file:bg-blue-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
            <c:if test="${not empty property.mainImage}">
              <img src="${pageContext.request.contextPath}/assets/properties/${property.mainImage}"
                   alt="Main Image" class="mt-3 w-40 rounded-lg border border-slate-600" />
            </c:if>
            <p class="text-xs text-gray-400 mt-1">Upload a new main image to replace the current one</p>
          </div>

          <!-- Additional Images -->
          <div class="md:col-span-2">
            <label class="block text-sm mb-1">Additional Images (up to 5)</label>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              <div>
                <input type="file" name="image1" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <c:if test="${not empty property.image1}">
                  <img src="${pageContext.request.contextPath}/assets/properties/${property.image1}"
                       alt="Image 1" class="mt-2 w-32 rounded-lg border border-slate-600" />
                </c:if>
                <p class="text-xs text-gray-400 mt-1">Image 1</p>
              </div>
              <div>
                <input type="file" name="image2" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <c:if test="${not empty property.image2}">
                  <img src="${pageContext.request.contextPath}/assets/properties/${property.image2}"
                       alt="Image 2" class="mt-2 w-32 rounded-lg border border-slate-600" />
                </c:if>
                <p class="text-xs text-gray-400 mt-1">Image 2</p>
              </div>
              <div>
                <input type="file" name="image3" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <c:if test="${not empty property.image3}">
                  <img src="${pageContext.request.contextPath}/assets/properties/${property.image3}"
                       alt="Image 3" class="mt-2 w-32 rounded-lg border border-slate-600" />
                </c:if>
                <p class="text-xs text-gray-400 mt-1">Image 3</p>
              </div>
              <div>
                <input type="file" name="image4" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <c:if test="${not empty property.image4}">
                  <img src="${pageContext.request.contextPath}/assets/properties/${property.image4}"
                       alt="Image 4" class="mt-2 w-32 rounded-lg border border-slate-600" />
                </c:if>
                <p class="text-xs text-gray-400 mt-1">Image 4</p>
              </div>
              <div>
                <input type="file" name="image5" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <c:if test="${not empty property.image5}">
                  <img src="${pageContext.request.contextPath}/assets/properties/${property.image5}"
                       alt="Image 5" class="mt-2 w-32 rounded-lg border border-slate-600" />
                </c:if>
                <p class="text-xs text-gray-400 mt-1">Image 5</p>
              </div>
            </div>
            <p class="text-xs text-gray-400 mt-2">Upload new images to replace existing ones. Leave empty to keep current images.</p>
          </div>

          <!-- Description -->
          <div class="md:col-span-2">
            <label class="block text-sm mb-1" for="description">Description</label>
            <textarea id="description" name="description" rows="4" required
                      class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">${property.description}</textarea>
          </div>

          <!-- Submit -->
          <div class="md:col-span-2">
            <button type="submit"
                    class="w-full py-2 px-4 bg-blue-500 hover:bg-blue-600 text-white font-semibold rounded-lg transition">
              <i class="fas fa-save mr-2"></i> Update Property
            </button>
          </div>
        </form>
      </div>
    </main>
  </div>
</body>
</html>