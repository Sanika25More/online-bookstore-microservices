-- Book Service Database Schema and Sample Data

USE book_service_db;

-- Create books table
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

-- Insert sample books data
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

