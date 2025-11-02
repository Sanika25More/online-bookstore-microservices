-- Order Service Database Schema and Sample Data

USE order_service_db;

-- Create orders table
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

-- Insert sample orders data
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

