<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentSphere | Add Property</title>
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
          <h3 class="text-lg font-semibold text-blue-400"><i class="fas fa-home mr-2"></i> Create New Property</h3>
          <a href="${pageContext.request.contextPath}/admin/my-property" class="text-sm text-blue-400 hover:underline">
            ← Back to Property List
          </a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/my-property?action=create" method="POST" enctype="multipart/form-data" class="grid md:grid-cols-2 gap-6">
          
          <!-- Title -->
          <div>
            <label class="block text-sm mb-1" for="title">Title</label>
            <input type="text" id="title" name="title" required
                   placeholder="E.g. Spacious Apartment"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Address -->
          <div>
            <label class="block text-sm mb-1" for="address">Address</label>
            <input type="text" id="address" name="address" required
                   placeholder="123 Street, City"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Type (ENUM: Apartment, House, Room) -->
          <div>
            <label class="block text-sm mb-1" for="type">Type</label>
            <select id="type" name="type" required
                    class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
              <option value="" disabled selected>Select Property Type</option>
              <option value="Apartment">Apartment</option>
              <option value="House">House</option>
              <option value="Room">Room</option>
            </select>
          </div>

          <!-- Rent -->
          <div>
            <label class="block text-sm mb-1" for="rent">Rent (Rs.)</label>
            <input type="number" id="rent" name="rent" required min="0" step="0.01"
                   placeholder="e.g. 35000"
                   class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
          </div>

          <!-- Status (ENUM: Available, Rented, Inactive) -->
          <div>
            <label class="block text-sm mb-1" for="status">Status</label>
            <select id="status" name="status" required
                    class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
              <option value="Available">Available</option>
              <option value="Rented">Rented</option>
              <option value="Inactive">Inactive</option>
            </select>
          </div>

          <!-- Main Image -->
          <div>
            <label class="block text-sm mb-1" for="main_image">Main Image</label>
            <input type="file" id="main_image" name="main_image" accept="image/*" required
                   class="w-full text-sm text-gray-300 file:bg-blue-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
            <p class="text-xs text-gray-400 mt-1">This will be the primary image shown in listings</p>
          </div>

          <!-- Additional Images -->
          <div class="md:col-span-2">
            <label class="block text-sm mb-1">Additional Images (up to 5)</label>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              <div>
                <input type="file" name="image1" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <p class="text-xs text-gray-400 mt-1">Image 1</p>
              </div>
              <div>
                <input type="file" name="image2" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <p class="text-xs text-gray-400 mt-1">Image 2</p>
              </div>
              <div>
                <input type="file" name="image3" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <p class="text-xs text-gray-400 mt-1">Image 3</p>
              </div>
              <div>
                <input type="file" name="image4" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <p class="text-xs text-gray-400 mt-1">Image 4</p>
              </div>
              <div>
                <input type="file" name="image5" accept="image/*"
                       class="w-full text-sm text-gray-300 file:bg-green-600 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:cursor-pointer" />
                <p class="text-xs text-gray-400 mt-1">Image 5</p>
              </div>
            </div>
            <p class="text-xs text-gray-400 mt-2">These additional images will be shown in the property gallery</p>
          </div>

          <!-- Description -->
          <div class="md:col-span-2">
            <label class="block text-sm mb-1" for="description">Description</label>
            <textarea id="description" name="description" rows="4" required
                      placeholder="Write a short description about the property"
                      class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
          </div>

          <!-- Submit -->
          <div class="md:col-span-2">
            <button type="submit"
                    class="w-full py-2 px-4 bg-blue-500 hover:bg-blue-600 text-white font-semibold rounded-lg transition">
              <i class="fas fa-save mr-2"></i> Save Property
            </button>
          </div>
        </form>
      </div>
    </main>
  </div>
</body>
</html>