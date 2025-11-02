
-- ============================================
-- Online Bookstore Microservices Database Schema
-- ============================================
-- This file creates all databases and their schemas with sample data
-- For Docker initialization, see mysql-init/ directory for individual files


-- Create databases for all microservices
CREATE DATABASE IF NOT EXISTS book_service_db;
CREATE DATABASE IF NOT EXISTS user_service_db;
CREATE DATABASE IF NOT EXISTS order_service_db;
CREATE DATABASE IF NOT EXISTS payment_service_db;


-- ============================================
-- BOOK SERVICE DATABASE
-- ============================================
USE book_service_db;

CREATE TABLE IF NOT EXISTS books (
    book_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_author (author),
    INDEX idx_genre (genre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample Books Data
INSERT INTO books (title, author, genre, price, stock) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 12.99, 50),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 14.99, 45),
('1984', 'George Orwell', 'Dystopian Fiction', 13.99, 60),
('Pride and Prejudice', 'Jane Austen', 'Romance', 11.99, 40),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 12.49, 35),
('Lord of the Flies', 'William Golding', 'Fiction', 11.99, 42),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 15.99, 55),
('Animal Farm', 'George Orwell', 'Allegory', 10.99, 48),
('Brave New World', 'Aldous Huxley', 'Dystopian Fiction', 13.49, 38),
('Fahrenheit 451', 'Ray Bradbury', 'Science Fiction', 12.99, 43),
('The Chronicles of Narnia', 'C.S. Lewis', 'Fantasy', 16.99, 52),
('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Fantasy', 14.99, 65),
('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 19.99, 58),
('Moby Dick', 'Herman Melville', 'Adventure', 13.99, 30),
('War and Peace', 'Leo Tolstoy', 'Historical Fiction', 17.99, 25);

-- ============================================
-- USER SERVICE DATABASE
-- ============================================
USE user_service_db;

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'buyer',
    address VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample Users Data (password hash represents: "password123")
INSERT INTO users (name, email, password, role, address) VALUES
('John Doe', 'john.doe@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '123 Main St, New York, NY 10001'),
('Jane Smith', 'jane.smith@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '456 Oak Ave, Los Angeles, CA 90001'),
('Admin User', 'admin@bookstore.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'admin', '789 Admin Blvd, Chicago, IL 60601'),
('Alice Johnson', 'alice.johnson@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '321 Elm St, Houston, TX 77001'),
('Bob Williams', 'bob.williams@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '654 Pine Rd, Phoenix, AZ 85001'),
('Charlie Brown', 'charlie.brown@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '987 Cedar Ln, Philadelphia, PA 19101'),
('Diana Prince', 'diana.prince@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '147 Maple Dr, San Antonio, TX 78201'),
('Edward Norton', 'edward.norton@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '258 Birch St, San Diego, CA 92101'),
('Fiona Green', 'fiona.green@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '369 Spruce Ave, Dallas, TX 75201'),
('George Miller', 'george.miller@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwNmdl0Hy', 'buyer', '741 Willow Way, San Jose, CA 95101');

-- ============================================
-- ORDER SERVICE DATABASE
-- ============================================
USE order_service_db;

CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_book_id (book_id),
    INDEX idx_status (status),
    INDEX idx_order_date (order_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample Orders Data
INSERT INTO orders (user_id, book_id, quantity, total_price, order_date, status) VALUES
(1, 1, 2, 25.98, '2024-01-15 10:30:00', 'COMPLETED'),
(1, 3, 1, 13.99, '2024-01-15 10:35:00', 'COMPLETED'),
(2, 2, 1, 14.99, '2024-01-16 14:20:00', 'COMPLETED'),
(2, 7, 2, 31.98, '2024-01-16 14:25:00', 'COMPLETED'),
(3, 12, 3, 44.97, '2024-01-17 09:15:00', 'COMPLETED'),
(4, 4, 1, 11.99, '2024-01-18 11:00:00', 'PENDING'),
(4, 5, 2, 24.98, '2024-01-18 11:05:00', 'PENDING'),
(5, 8, 1, 10.99, '2024-01-19 16:45:00', 'COMPLETED'),
(6, 9, 1, 13.49, '2024-01-20 08:30:00', 'PROCESSING'),
(7, 11, 2, 33.98, '2024-01-21 13:20:00', 'COMPLETED'),
(8, 13, 1, 19.99, '2024-01-22 15:10:00', 'COMPLETED'),
(9, 6, 1, 11.99, '2024-01-23 10:00:00', 'CANCELLED'),
(10, 10, 2, 25.98, '2024-01-24 12:30:00', 'COMPLETED'),
(1, 14, 1, 13.99, '2024-01-25 14:00:00', 'PROCESSING'),
(2, 15, 1, 17.99, '2024-01-26 09:45:00', 'PENDING');

-- ============================================
-- PAYMENT SERVICE DATABASE
-- ============================================
USE payment_service_db;

CREATE TABLE IF NOT EXISTS payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    transaction_id VARCHAR(100),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order_id (order_id),
    INDEX idx_status (status),
    INDEX idx_payment_date (payment_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample Payments Data
INSERT INTO payments (order_id, amount, method, status, transaction_id, payment_date) VALUES
(1, 25.98, 'CREDIT_CARD', 'SUCCESSFUL', 'TXN-20240115-001', '2024-01-15 10:31:00'),
(2, 13.99, 'DEBIT_CARD', 'SUCCESSFUL', 'TXN-20240115-002', '2024-01-15 10:36:00'),
(3, 14.99, 'UPI', 'SUCCESSFUL', 'TXN-20240116-001', '2024-01-16 14:21:00'),
(4, 31.98, 'CREDIT_CARD', 'SUCCESSFUL', 'TXN-20240116-002', '2024-01-16 14:26:00'),
(5, 44.97, 'PAYPAL', 'SUCCESSFUL', 'TXN-20240117-001', '2024-01-17 09:16:00'),
(6, 11.99, 'CREDIT_CARD', 'PENDING', 'TXN-20240118-001', '2024-01-18 11:01:00'),
(7, 24.98, 'DEBIT_CARD', 'PENDING', 'TXN-20240118-002', '2024-01-18 11:06:00'),
(8, 10.99, 'UPI', 'SUCCESSFUL', 'TXN-20240119-001', '2024-01-19 16:46:00'),
(9, 13.49, 'CREDIT_CARD', 'PROCESSING', 'TXN-20240120-001', '2024-01-20 08:31:00'),
(10, 33.98, 'PAYPAL', 'SUCCESSFUL', 'TXN-20240121-001', '2024-01-21 13:21:00'),
(11, 19.99, 'CREDIT_CARD', 'SUCCESSFUL', 'TXN-20240122-001', '2024-01-22 15:11:00'),
(12, 11.99, 'DEBIT_CARD', 'REFUNDED', 'TXN-20240123-001', '2024-01-23 10:01:00'),
(13, 25.98, 'UPI', 'SUCCESSFUL', 'TXN-20240124-001', '2024-01-24 12:31:00'),
(14, 13.99, 'CREDIT_CARD', 'PROCESSING', 'TXN-20240125-001', '2024-01-25 14:01:00'),
(15, 17.99, 'PAYPAL', 'PENDING', 'TXN-20240126-001', '2024-01-26 09:46:00');

