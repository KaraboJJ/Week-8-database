-- PostgreSQL: Library Management System Schema

-- Drop existing tables if they exist (to reset schema)
DROP TABLE IF EXISTS Fines, Reservations, Loans, Book_Authors, Books, Authors, Members CASCADE;

-- Authors Table
CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT
);

-- Books Table
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year INT CHECK (published_year >= 0),
    genre VARCHAR(50),
    copies_available INT DEFAULT 0 CHECK (copies_available >= 0)
);

-- Book_Authors Table (Many-to-Many between Books and Authors)
CREATE TABLE Book_Authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Members Table
CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    membership_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Loans Table
CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Reservations Table
CREATE TABLE Reservations (
    reservation_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Fines Table (1-to-1 or 1-to-M with Loans)
CREATE TABLE Fines (
    fine_id SERIAL PRIMARY KEY,
    loan_id INT UNIQUE NOT NULL,
    amount NUMERIC(6,2) NOT NULL CHECK (amount >= 0),
    paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);
