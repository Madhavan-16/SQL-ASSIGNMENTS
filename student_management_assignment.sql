
CREATE DATABASE SMS;

USE SMS;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount Double,
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number) 
VALUES 
(1, 'Jon', 'S', '2000-01-15', 'john@gmail.com', '123-456-7890'),
(2, 'Alice', 'M', '2001-05-20', 'alice@gmail.com', '987-654-3210'),
(4, 'Rob', 'J', '1999-11-10', 'bob@gmail.com', '555-123-4567'),
(5, 'Bran', 'S', '1998-10-01', 'bob@gmail.com', '555-123-4567'),
(6, 'Arya', 'J', '2002-03-16', 'arya@gmail.com', '555-123-4567');


INSERT INTO Courses (course_id, course_name, credits, teacher_id) 
VALUES 
(1, 'Java', 3, 1),
(2, 'Python', 4, 2),
(3, 'C', 3, 3),
(4, 'C++', 3, 4);


INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) 
VALUES 
(1, 1, 1, '2023-07-11'),
(2, 2, 2, '2024-01-21'),
(3, 3, 3, '2021-02-09'),
(4, 4, 4, '2022-05-13'),
(5, 5, 3, '2020-09-10'),
(6, 6, 1, '2023-02-19');


INSERT INTO Teacher (teacher_id, first_name, last_name, email) 
VALUES 
(1, 'Mr.', 'Smith', 'smith@gmail.com'),
(2, 'Ms.', 'Johnson', 'johnson@gmail.com'),
(3, 'Dr.', 'Doe', 'doe@gmail.com'),
(4, 'Mr.', 'Will', 'will@gmail.com');


INSERT INTO Payments (payment_id, student_id, amount, payment_date) 
VALUES 
(1, 1, 500.00, '2024-01-15'),
(2, 2, 600.00, '2021-02-20'),
(3, 3, 450.00, '2023-03-25'),
(4, 4, 550.00, '2022-07-05'),
(5, 5, 650.00, '2022-12-02'),
(6, 6, 750.00, '2023-03-19');

/*----Queries----*/
##TASK-1
/*Write an SQL query to insert a new student into the "Students" table with the following details:
a. First Name: John
© Hexaware Technologies Limited. All rights www.hexaware.com
b. Last Name: Doe
c. Date of Birth: 1995-08-15
d. Email: john.doe@example.com
e. Phone Number: 1234567890 */
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) 
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

/*Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date*/
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 1, '2024-03-06');

#Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
UPDATE Teacher
SET email = 'new_email@example.com'
WHERE teacher_id = 1;

#Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select  an enrollment record based on the student and course
DELETE FROM Enrollments
WHERE student_id = 1
AND course_id = 1;

#Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.
UPDATE Courses
SET teacher_id = 2
WHERE course_id = 3;

#Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.
DELETE FROM Enrollments
WHERE student_id = specific_student_id;

-- Delete the specific student from the "Students" table
DELETE FROM Enrollments
WHERE student_id = 2;
DELETE FROM Students
WHERE student_id = 2;

#Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount
UPDATE Payments
SET amount = 750.00
WHERE payment_id = 1;

/*---TASK-3-----*/

#Calculate the total payments made by a specific student:
SELECT SUM(amount) AS total_payments
FROM Payments
WHERE student_id = 2;

#Retrieve a list of courses along with the count of students enrolled in each course:
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

#Find the names of students who have not enrolled in any course:
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

#Retrieve the first name, last name of students, and the names of the courses they are enrolled in:
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

#List the names of teachers and the courses they are assigned to:
SELECT t.first_name, t.last_name, c.course_name
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id;

#Retrieve a list of students and their enrollment dates for a specific course:
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Java';

#Find the names of students who have not made any payments:
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.student_id IS NULL;

#Identify courses that have no enrollments:
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;



