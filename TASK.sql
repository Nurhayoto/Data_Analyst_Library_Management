SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;


-- Project Task
-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', '6.00', 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address ='125 Oak St'
WHERE member_id = 'C103';

UPDATE members
SET member_name = 'Nurhayoto'
WHERE member_id = 'C102';

-- TASK 3:Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id,
	COUNT(*) AS sum_issued
FROM issued_Status
GROUP BY issued_emp_id
HAVING COUNT(issued_emp_id) >1;

-- CTAS
--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status AS ist
JOIN books AS b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

SELECT * FROM book_issued_cnt;

-- Data Analyst Finding
-- Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Fiction';


-- Task 8: Find Total Rental Income by Category:
SELECT 
	b.category,
	SUM(b.rental_price),
	COUNT(*)
FROM 
	issued_status AS ist
JOIN
	books AS b
ON b.isbn = ist.issued_book_isbn
GROUP BY b.category;

-- TASK 9 : List Members Who Registered in the Last 360 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '360 days';

-- TASK 10 : List Employees with Their Branch Manager's Name and their branch details:
SELECT 
	e1.emp_id,
	e1.emp_name,
	e1.position,
	e1.salary,
	b.*,
	e2.emp_name AS manager
FROM employees AS e1
JOIN
	branch AS b
ON e1.branch_id = b.branch_id
JOIN
	employees AS e2
ON e2.emp_id = b.manager_id;


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;
SELECT * FROM expensive_books;

-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;
