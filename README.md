## Library Management System Database

# Project Overview

This project implements a comprehensive Library Management System Database using Postgres. The system is designed to mage all aspects of a library operation, including book inventory, member management, loans, reservations, staff records, events and more.

# Features

Member Management: Track member information, membership status, and activity
Book Catalog: Maintain a detailed catalog of books with metadata
Author & Publisher Management: Store information about authors and publishers
Book Copy Tracking: Track individual copies of books and their status
Loan System: Manage book borrowing, returns, and fines
Reservation System: Allow members to reserve books
Event Management: Schedule and track library events and registrations
Staff Records: Maintain staff information and roles
Category Organization: Organize books by categories
Database Schema
The database consists of the following tables with appropriate relationships:

# Primary Tables

members: Store member personal information and membership details
books: Main book catalog with bibliographic information
book_copies: Individual copies of books with status tracking
authors: Information about book authors
publishers: Information about book publishers
categories: Book categories/genres
loans: Track book borrowing and returns
reservations: Track book reservations
staff: Library staff information
events: Library events and activities
fines: Track fines for late returns
Junction Tables (Many-to-Many Relationships)
book_authors: Connect books with their authors (M:M)
book_categories: Associate books with categories (M:M)
event_registrations: Track member registrations for events (M:M)

# Entity Relationship Diagram (ERD)

+-------------+     +--------------+     +-------------+
|   Members   |     |    Loans     |     | Book Copies |
+-------------+     +--------------+     +-------------+
| PK member_id |<---| FK member_id |     | PK copy_id  |
|   details    |     | FK copy_id   |---->|  FK book_id |
+-------------+     |   details    |     |   details   |
       ^             +--------------+     +-------------+
       |                                        |
       |                                        |
       |                                        v
+----------------+    +---------------+    +-------------+
| Reservations   |    | Book_Authors |    |    Books    |
+----------------+    +---------------+    +-------------+
| PK reservation_id | | PK book_id    |<---| PK book_id  |
| FK member_id   |----| PK author_id  |    | FK publisher|
| FK book_id     |--->|               |    |   details   |
|    details     |    +---------------+    +-------------+
+----------------+           |                    ^
                            |                    |
                            v                    |
                     +-------------+    +----------------+
                     |   Authors   |    | Book_Categories|
                     +-------------+    +----------------+
                     | PK author_id|    | PK book_id     |----+
                     |   details   |    | PK category_id |    |
                     +-------------+    +----------------+    |
                                               |              |
                                               v              |
                                        +-------------+       |
                                        |  Categories |       |
                                        +-------------+       |
                                        |PK category_id|      |
                                        |   details   |      |
                                        +-------------+      |
                                                             |
                     +-------------+    +----------------+   |
                     | Publishers  |    |     Events     |   |
                     +-------------+    +----------------+   |
                     |PK publisher_id|   | PK event_id   |   |
                     |   details   |    |    details    |   |
                     +-------------+    +----------------+   |
                            ^                   ^           |
                            |                   |           |
                            |                   |           |
                     +-------------+    +----------------+  |
                     |    Staff    |    |Event_Registrations|
                     +-------------+    +----------------+  |
                     | PK staff_id |    | PK event_id   |<--+
                     |   details   |    | PK member_id  |----+
                     +-------------+    +----------------+

# How to Set Up the Database

Ensure you have Postgres and PgAdmin installed on your system
Open your Postgres terminal
Run the SQL script to create and populate the database:
Implementation Details
The database uses appropriate constraints (Primary Keys, Foreign Keys, NOT NULL, UNIQUE) to maintain data integrity
Timestamps are automatically managed for creation and updates
Indexes are created for frequently queried columns to improve performance
Sample data is included for demonstration purposes
The schema supports various relationships (one-to-one, one-to-many, many-to-many)

# Future Enhancements

Add stored procedures for common operations (checking out books, calculating fines)
Implement triggers for automatic status updates
Create views for common reporting needs
Add user authentication and authorization system
