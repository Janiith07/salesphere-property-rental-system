-- ======================================
-- DATABASE: salesphere_db
-- ======================================
CREATE DATABASE IF NOT EXISTS salesphere_db;
USE salesphere_db;

-- ==============================
-- TABLE: users (Tenants)
-- ==============================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    nic_number VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Users
INSERT INTO users (full_name, email, password, phone, nic_number, address) VALUES
('Sanjaya Perera', 'sanjaya@example.com', 'hashed_pass1', '0771234567', '200011501234', 'Colombo'),
('Nimali Silva', 'nimali@example.com', 'hashed_pass2', '0719876543', '993456789V', 'Galle'),
('Thilina Rathnayake', 'thilina@example.com', 'hashed_pass3', '0782233445', '200234567890', 'Kandy'),
('Hasini Madushani', 'hasini@example.com', 'hashed_pass4', '0723344556', '200045612345', 'Negombo'),
('Ishan Fernando', 'ishan@example.com', 'hashed_pass5', '0745566778', '199987654321', 'Matara');

-- ==============================
-- TABLE: admins (Landlords, Admins)
-- ==============================
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    role ENUM('Admin', 'Landlord') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Admins
INSERT INTO admins (full_name, email, password, phone, role) VALUES
('Lakshan Fernando', 'lakshan@example.com', 'adminpass1', '0761122334', 'Admin'),
('Dilani Madushani', 'dilani@example.com', 'landlordpass1', '0756677889', 'Landlord'),
('Suranga De Silva', 'suranga@example.com', 'landlordpass2', '0709988776', 'Landlord'),
('Ishara Gunasekara', 'ishara@example.com', 'adminpass2', '0765566778', 'Admin');

-- ==============================
-- TABLE: sellers (linked to admins)
-- ==============================
CREATE TABLE IF NOT EXISTS sellers (
    seller_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admins(admin_id) ON DELETE CASCADE
);

-- Backfill sellers from admins where role='Landlord'
INSERT INTO sellers (admin_id, full_name, email, phone)
SELECT a.admin_id, a.full_name, a.email, a.phone
FROM admins a
WHERE a.role = 'Landlord'
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name), email = VALUES(email), phone = VALUES(phone);

-- ==============================
-- TABLE: properties
-- ==============================
CREATE TABLE properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    landlord_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    address TEXT NOT NULL,
    type ENUM('Apartment', 'House', 'Room') NOT NULL,
    rent DECIMAL(10,2) NOT NULL,
    status ENUM('Available', 'Rented', 'Inactive') DEFAULT 'Available',
    approval_status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    description TEXT,
    main_image VARCHAR(255),
    image1 VARCHAR(255),
    image2 VARCHAR(255),
    image3 VARCHAR(255),
    image4 VARCHAR(255),
    image5 VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (landlord_id) REFERENCES admins(admin_id) ON DELETE CASCADE
);

-- Sample Properties
INSERT INTO properties (landlord_id, title, address, type, rent, status, approval_status, description, main_image, image1, image2, image3, image4, image5) VALUES
(2, 'Luxury Apartment in Colombo 7', 'No. 12, Rosmead Place, Colombo 7', 'Apartment', 75000.00, 'Available', 'Approved', 'Modern 2-bedroom apartment with balcony.', '1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg'),
(2, 'Budget Room in Galle', '45A, Light House Street, Galle', 'Room', 18000.00, 'Available', 'Approved', 'Affordable single room near town.', '7.jpg', '8.jpg', '9.jpg', NULL, NULL, NULL),
(3, 'Family House in Kandy', '123, Hill Street, Kandy', 'House', 65000.00, 'Rented', 'Approved', 'Spacious family house with garden and garage.', '1.jpg', '2.jpg', '3.jpg', '4.jpg', NULL, NULL),
(3, 'Studio Apartment in Negombo', '8C, Beach Road, Negombo', 'Apartment', 32000.00, 'Available', 'Approved', 'Ideal for a couple, walking distance to beach.', '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg', NULL),
(2, 'Single Room in Matara', '22, Weligama Road, Matara', 'Room', 15000.00, 'Available', 'Approved', 'Furnished single room in a quiet neighborhood.', '1.jpg', '2.jpg', NULL, NULL, NULL, NULL);

-- ==============================
-- TABLE: bookings
-- ==============================
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    tenant_id INT NOT NULL,
    property_id INT NOT NULL,
    booking_date DATE NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (tenant_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE
);

-- Sample Bookings
INSERT INTO bookings (tenant_id, property_id, booking_date, status) VALUES
(1, 1, '2025-05-01', 'Pending'),
(2, 2, '2025-05-03', 'Approved'),
(3, 3, '2025-05-04', 'Rejected'),
(4, 4, '2025-05-02', 'Pending'),
(5, 5, '2025-05-05', 'Cancelled');

-- ==============================
-- TABLE: reviews
-- ==============================
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    tenant_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (tenant_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Sample Reviews
INSERT INTO reviews (property_id, tenant_id, rating, comment) VALUES
(1, 1, 5, 'Excellent place, very clean and well maintained.'),
(2, 2, 4, 'Good location, but bathroom could be cleaner.'),
(3, 3, 3, 'Nice house but a bit far from town.'),
(4, 4, 5, 'Perfect for a couple. Peaceful area.'),
(5, 5, 2, 'Affordable but noisy neighborhood.');

-- ==============================
-- TABLE: PaymentCards
-- ==============================
CREATE TABLE IF NOT EXISTS PaymentCards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    card_holder_name VARCHAR(100) NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    expiry_date VARCHAR(10) NOT NULL,
    cvv VARCHAR(10) NOT NULL,
    card_type VARCHAR(20),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Sample Payment Cards
INSERT INTO PaymentCards (user_id, card_holder_name, card_number, expiry_date, cvv, card_type) VALUES
(1, 'John Doe', '4111111111111111', '12/26', '123', 'Visa'),
(2, 'Jane Smith', '5500000000000004', '11/25', '456', 'MasterCard'),
(3, 'Alice Johnson', '340000000000009', '10/24', '789', 'American Express'),
(4, 'Bob Williams', '30000000000004', '09/25', '321', 'Diners Club'),
(5, 'Carol Brown', '6011000000000004', '08/26', '654', 'Discover');

-- ==============================
-- VIEW: bookings_view
-- ==============================
DROP VIEW IF EXISTS bookings_view;
CREATE VIEW bookings_view AS
SELECT 
    b.booking_id,
    b.tenant_id,
    b.property_id,
    u.full_name AS tenant_name,
    p.title AS property_title,
    b.booking_date,
    b.status
FROM bookings b
JOIN users u ON b.tenant_id = u.user_id
JOIN properties p ON b.property_id = p.property_id;

-- ==============================
-- VIEW: reviews_view
-- ==============================
DROP VIEW IF EXISTS reviews_view;
CREATE VIEW reviews_view AS
SELECT 
    r.review_id,
    r.property_id,
    r.tenant_id,
    u.full_name AS tenant_name,
    p.title AS property_title,
    r.rating,
    r.comment,
    r.reviewed_at
FROM reviews r
JOIN users u ON r.tenant_id = u.user_id
JOIN properties p ON r.property_id = p.property_id
ORDER BY r.reviewed_at DESC;

-- ==============================
-- VIEW: properties_view
-- ==============================
DROP VIEW IF EXISTS properties_view;
CREATE VIEW properties_view AS
SELECT 
    p.property_id,
    p.title,
    p.address,
    p.type,
    p.rent,
    p.status,
    p.approval_status,
    COALESCE(s.full_name, a.full_name) AS landlord_name,
    COALESCE(s.email, a.email) AS landlord_email
FROM properties p
JOIN admins a ON p.landlord_id = a.admin_id
LEFT JOIN sellers s ON s.admin_id = a.admin_id;

-- ======================================
-- ENCRYPTION MIGRATION SCRIPT
-- ======================================
USE rentsphere_db;

-- ==============================
-- BACKUP EXISTING DATA
-- ==============================
CREATE TABLE IF NOT EXISTS PaymentCards_backup AS 
SELECT * FROM PaymentCards;

-- ==============================
-- UPDATE TABLE SCHEMA
-- ==============================
ALTER TABLE PaymentCards 
MODIFY COLUMN card_number VARCHAR(255) NOT NULL,
MODIFY COLUMN cvv VARCHAR(255) NOT NULL;

-- ==============================
-- MIGRATION NOTES
-- ==============================
-- Note: The actual encryption of existing data should be done through the application
-- using the EncryptionUtil class, not through SQL directly.
-- 
-- Migration steps:
-- 1. Run this schema update
-- 2. Use the application's PaymentCardService to re-save all existing cards
-- 3. The service will automatically encrypt the data during the update process

-- ==============================
-- VERIFICATION QUERIES
-- ==============================
-- DESCRIBE PaymentCards;
-- SELECT COUNT(*) as backup_count FROM PaymentCards_backup;
-- SELECT COUNT(*) as current_count FROM PaymentCards;

-- ==============================
-- ROLLBACK INSTRUCTIONS
-- ==============================
-- DROP TABLE PaymentCards;
-- RENAME TABLE PaymentCards_backup TO PaymentCards;
-- ALTER TABLE PaymentCards 
-- MODIFY COLUMN card_number VARCHAR(20) NOT NULL,
-- MODIFY COLUMN cvv VARCHAR(10) NOT NULL;
