-- project library management system

CREATE TABLE branch(branch_id VARCHAR(10) PRIMARY KEY,
	manager_id VARCHAR(10),
	branch_address VARCHAR(30), 
	contact_no VARCHAR(10)
	);
ALTER TABLE branch
ALTER COLUMN manager_id TYPE VARCHAR(20), 
ALTER COLUMN contact_no TYPE VARCHAR(20);

CREATE TABLE employees(emp_id VARCHAR(10) PRIMARY KEY, 
			emp_name VARCHAR(20),	
			position VARCHAR (20),	
			salary INT,	
			branch_id VARCHAR(10) -- FK
	);
ALTER TABLE employees
ALTER COLUMN emp_id TYPE VARCHAR(20),
ALTER COLUMN branch_id TYPE VARCHAR(20);

DROP TABLE IF EXISTS books;
CREATE TABLE books 
	(isbn VARCHAR(20) PRIMARY KEY,
	book_title VARCHAR(75),
	category VARCHAR(20),
	rental_price FLOAT,
	status VARCHAR (5),
	author VARCHAR(30),
	publisher VARCHAR(55)
	);
ALTER TABLE books
ALTER COLUMN rental_price TYPE DECIMAL(10,2);
DROP TABLE IF EXISTS members;
CREATE TABLE members
	(member_id VARCHAR(10) PRIMARY KEY,
	member_name VARCHAR(20),
	member_address VARCHAR(20),
	reg_date DATE
	);
ALTER TABLE members
ALTER COLUMN member_id TYPE VARCHAR(20);

DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
	(
	issued_id VARCHAR(10) PRIMARY KEY,
	issued_member_id VARCHAR(10), -- FK
	issued_book_name VARCHAR(75)	,
	issued_date DATE,
	issued_book_isbn VARCHAR(25), -- FK
	issued_emp_id VARCHAR(10) -- FK
	);

ALTER TABLE issued_status
ALTER COLUMN issued_member_id TYPE VARCHAR(20),
ALTER COLUMN issued_id TYPE VARCHAR (20),
ALTER COLUMN issued_emp_id TYPE VARCHAR(20);

ALTER TABLE issued_status
ADD PRIMARY KEY (issued_id);

DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
	(
	return_id VARCHAR(10) PRIMARY KEY,
	issued_id VARCHAR(10),
	return_book_name VARCHAR(75),
	return_date DATE,
	return_book_isbn VARCHAR(20)
	);

ALTER TABLE return_status
ALTER COLUMN return_id TYPE VARCHAR (20),
ALTER COLUMN issued_id TYPE VARCHAR(20);


-- FOREIGN KEY
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);