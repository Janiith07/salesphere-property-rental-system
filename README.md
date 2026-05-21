## 🏠 Project Overview

SaleSphere is a comprehensive property rental web application designed to connect tenants with landlords in a seamless and secure manner. Developed as a university-level project using Java Servlets, JSP, MySQL, and HTML/CSS/JavaScript (with Tailwind CSS), it facilitates property listings, bookings, reviews, and payments for urban housing needs.

The system supports multiple user roles — Tenants (Users), Landlords (Admins), and System Admins — each with dedicated dashboards and functionalities. Tenants can browse properties, book rentals, leave reviews, and manage profiles. Landlords can list properties, manage bookings, and handle tenant interactions. System Admins oversee users, properties, and system-wide operations.

With its modular MVC architecture and fully responsive design, RentSphere provides a scalable solution for property rental management, emphasizing user experience and data security.

## 📸 Sample Pages Preview

<img src="./Sample Images/home.png" width="100%" alt="User Dashboard" />

Homepage for Users and Landlords

## 🔑 Key Features

### 👤 Tenant (User) Module

* User registration and login
* View & update profile (including address, NIC, phone)
* Browse available properties (apartments, houses, rooms)
* Book properties and proceed to payment
* Leave reviews and ratings for rented properties
* Manage bookings (view status: Pending, Approved, Rejected, Cancelled)
* Add and manage payment cards

### 🏢 Landlord Module

* Landlord signup/login
* List and manage properties (title, address, type, rent, description, status)
* Approve/reject tenant bookings
* View tenant reviews and ratings
* Dashboard for property analytics and bookings

### 🛠️ Admin Module

* Manage users (tenants) and landlords
* Oversee properties, bookings, and reviews
* Handle system notifications and user roles (Admin/Landlord)
* View system-wide dashboards and reports

### 💳 Payment Integration

* Secure payment card management
* Simulated payment processing for bookings

### ⭐ Reviews & Ratings

* Tenants can rate properties (1-5 stars) with comments
* Display average ratings on property listings

## ⚙️ Technologies Used

* **Backend**: Java Servlets, JSP, JDBC
* **Frontend**: HTML, CSS (Tailwind CSS), JavaScript
* **Database**: MySQL
* **Tools**: Apache Tomcat, Eclipse/NetBeans IDE
* **Architecture**: MVC (Model-View-Controller)
* **Styling**: Tailwind CSS for responsive, modern UI
* **Icons**: Font Awesome

## 🛠️ Local Setup Instructions

1. **Clone the Repository**
   ```
   git clone https://github.com/JKPLakshithaDilshan/Salesphere-Property-Rental-System.git
   ```

2. **Open in IDE**
   Open the project folder in IntelliJ, NetBeans, or your preferred Java IDE.

3. **Configure MySQL Database**
   - Create a new database named `rentsphere_db`.
   - Import the provided SQL script (from the conversation history or create based on the schema provided).
   - Update database credentials in the relevant Java files (e.g., DBConnection.java if present, or configure in context.xml for Tomcat).

   Sample SQL Schema (from provided content):
   ```
   CREATE DATABASE IF NOT EXISTS rentsphere_db;
   USE rentsphere_db;

   -- Tables for users, admins,sellers, properties, bookings, reviews, paymentcards, etc.
   -- (Paste the full SQL from the history here)
   ```

4. **Deploy to Server**
   - Ensure Apache Tomcat is installed and configured in your IDE.
   - Add the project to the Tomcat server.
   - Run the server and access at:
     ```
     http://localhost:8080/SaleSphere/
     ```

5. **Sample Credentials**
   - Use the inserted sample data from the SQL script for testing (e.g., users like 'lakshitha@gmail.com', admins like 'lakshitha@gmail.com').

## 🖼️ Screenshots

### 🚀 Login Page
<img src="./Sample Images/login.png" width="100%" alt="Login Page" />

### 🧍 Tenant Side
#### 🧍 Tenant Dashboard
<img src="./Sample Images/profile.png" width="100%" alt="Tenant Dashboard" />

#### 🧍 Browse Properties
<img src="./Sample Images/properties.png" width="100%" alt="Properties List" />
<img src="./Sample Images/properties..png" width="100%" alt="Properties List" />

#### 🧍 Book a Property
<img src="./Sample Images/book.png" width="100%" alt="Booking Confirmation" />

#### 🧍 Payment Conform & Success

<img src="./Sample Images/Payment Confirmation.png" width="100%" alt="Payment Success" />
<img src="./Sample Images/payment_success.png" width="100%" alt="Payment Success" />

#### 🧍 Leave Review
<img src="./Sample Images/review.png" width="100%" alt="Review Form" />

### 👨‍✈️ Landlord Side
#### 👨‍✈️ Landlord Dashboard
<img src="./Sample Images/My Properties.png" width="100%" alt="Landlord Properties" />

#### 👨‍✈️ Manage Bookings
<img src="./Sample Images/Bookings Management.png" width="100%" alt="Bookings View" />

### 🧑‍💼 Admin Side
#### 🧑‍💼 Admin Dashboard
<img src="./Sample Images/admin_users.png" width="100%" alt="Admin Users" />

#### 🧑‍💼 Manage Properties
<img src="./Sample Images/admin_properties.png" width="100%" alt="Admin Properties" />

## 📢 Notification System
- Real-time alerts for booking status changes, approvals, and reviews.
- Integrated into user dashboards.

## 🧱 Folder Structure

```
SaleSphere/
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── com/rentsphere/  (Packages for servlets, models, services, utils)
│   │   └── webapp/
│   │       ├── admin/          (Admin JSPs like index.jsp, create.jsp, update.jsp)
│   │       ├── assets/         (CSS, JS, images, favicon)
│   │       ├── bookings/       (Booking-related JSPs)
│   │       ├── my-properties/  (User properties management)
│   │       ├── partials/       (Reusable components like header.jsp, footer.jsp, sidebar.jsp)
│   │       ├── payments/       (Payment JSPs like pay.jsp, PaymentSuccessful.jsp)
│   │       ├── properties/     (Properties list and details)
│   │       ├── reviews/        (Review JSPs)
│   │       ├── users/          (User profile, settings)
│   │       ├── META-INF/
│   │       ├── WEB-INF/        (web.xml, classes)
│   │       ├── about.jsp
│   │       ├── book.jsp
│   │       ├── contact.jsp
│   │       ├── home.jsp
│   │       ├── login.jsp
│   │       ├── my-bookings.jsp
│   │       ├── my-reviews.jsp
│   │       ├── profile.jsp
│   │       ├── register.jsp
│   │       ├── review.jsp
│   │       ├── seller-register.jsp
│   │       ├── settings.jsp
│   │       └── ... (other JSPs)
│
├── database/
│   └── rentsphere_db.sql   (SQL schema and sample data)
│
├── sample_pages/
│   └── [Screenshots of UI pages]
│
└── README.md
```

## 🧱 System Architecture

The architecture of RentSphere follows a modular MVC (Model-View-Controller) pattern, ensuring separation of concerns and ease of scalability.

### 🔹 1. Presentation Layer (View)
- Built using JSP, HTML, Tailwind CSS, and JavaScript.
- Provides role-specific dashboards for Tenants, Landlords, and Admins.
- Displays properties, bookings, reviews, and forms with real-time updates.

### 🔹 2. Controller Layer
- Implemented using Java Servlets.
- Handles HTTP requests, routes to services, and manages sessions.
- Validates inputs and forwards to appropriate views.

### 🔹 3. Service Layer
- Java classes containing business logic for bookings, reviews, payments, etc.
- Interacts with database utilities.

### 🔹 4. Data Access Layer
- Manages MySQL connections via JDBC.
- Executes CRUD operations on tables like `users`, `admins`, `properties`, `bookings`, `reviews`, `PaymentCards`.

### 🔹 5. Database Layer
- MySQL with tables: `users` (tenants), `admins` (landlords/admins), `properties`, `bookings`, `reviews`, `PaymentCards`.
- Views for simplified queries: `bookings_view`, `reviews_view`, `properties_view`.
- Ensures data integrity with foreign keys and constraints.

### 🔄 Flow Overview
```
User Request
↓
Servlet Controller (HTTP)
↓
Service Layer (Java)
↓
Database Access (SQL via JDBC)
↓
Response to JSP (View)
```

This architecture ensures:
- 🔐 Security through session management and hashed passwords.
- ⚡ Performance with efficient queries and caching where applicable.
- 📦 Modularity for extensions (e.g., API integration, mobile views).

## 📱 Fully Responsive Design

SaleSphere is built with a mobile-first approach using Tailwind CSS, ensuring seamless responsiveness across all screen sizes — from smartphones and tablets to large desktop monitors.

- Layouts adapt automatically using Tailwind's responsive utility classes.
- Pages scale and reflow for optimal viewing on small and large devices.
- Forms, dashboards, tables, and navigation are fully optimized for touch and mouse interaction.

🔍 The design has been tested on:
- Android and iOS devices
- Chrome, Firefox, and Edge browsers
- Desktop resolutions (1366px+, 1920px+)
- Common breakpoints (`sm`, `md`, `lg`, `xl`)

This ensures that users — whether tenants or landlords — enjoy a smooth and intuitive experience on any device.

## 📜 License
This project is for academic purposes only. All rights reserved to the authors.

## 📬 Contact
Have questions? Reach out via:

GitHub: https://github.com/JKPLakshithaDilshan

Email: lakshithadilshan.info@gmail.com
"# salesphere-property-rental-system" 
