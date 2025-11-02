-- User Service Database Schema and Sample Data

USE user_service_db;

-- Create users table
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

-- Insert sample users data
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

