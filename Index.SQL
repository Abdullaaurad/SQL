CREATE TABLE Department (
    DepartmentID INT NOT NULL AUTO_INCREMENT,
    DepartmentName VARCHAR(50),
    Location VARCHAR(100),
    PRIMARY KEY (DepartmentID)
);

CREATE TABLE Students (
    StudentID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Email VARCHAR(100) UNIQUE,
    Age TINYINT,  -- Corrected Age type
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) 
    REFERENCES Department(DepartmentID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);

CREATE TABLE Courses (
    CourseID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT CHECK (Credits > 0)
);

CREATE TABLE Teachers (
    TeacherID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    FullName VARCHAR(100),
    DepartmentID INT UNIQUE,  -- Changed from VARCHAR(50) to INT
    CourseID INT,
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (CourseID)
    REFERENCES Courses(CourseID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Participations (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Marks INT NOT NULL,
    FOREIGN KEY (StudentID)
    REFERENCES Students(StudentID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (CourseID)
    REFERENCES Courses(CourseID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

ALTER TABLE students ADD CONSTRAINT CHECK (DateOfBirth > '2000-11-24');

INSERT INTO Department (DepartmentName, Location)
VALUES 
    ('Computer Science', 'Building A'),
    ('Mathematics', 'Building B'),
    ('Physics', 'Building C')
;

INSERT INTO Students (FirstName, LastName, DateOfBirth, Email, Age, DepartmentID)
VALUES 
    ('Alice', 'Johnson', '2002-03-15', 'alice.johnson@example.com', 22, 1),
    ('Bob', 'Smith', '2001-07-20', 'bob.smith@example.com', 23, 2),
    ('Charlie', 'Brown', '2003-01-10', 'charlie.brown@example.com', 21, 3),
    ('David', 'Williams', '2000-05-22', 'david.williams@example.com', 24, 1),
    ('Emma', 'Davis', '2002-08-13', 'emma.davis@example.com', 22, 2),
    ('Frank', 'Miller', '2001-09-17', 'frank.miller@example.com', 23, 3),
    ('Grace', 'Wilson', '2003-06-25', 'grace.wilson@example.com', 21, 1),
    ('Henry', 'Moore', '2000-12-30', 'henry.moore@example.com', 24, 2),
    ('Isabella', 'Taylor', '2002-04-05', 'isabella.taylor@example.com', 22, 3),
    ('Jack', 'Anderson', '2001-11-11', 'jack.anderson@example.com', 23, 1),
    ('Katherine', 'Thomas', '2003-02-09', 'katherine.thomas@example.com', 21, 2),
    ('Leo', 'Jackson', '2000-07-18', 'leo.jackson@example.com', 24, 3),
    ('Mia', 'White', '2002-09-27', 'mia.white@example.com', 22, 1),
    ('Nathan', 'Harris', '2001-05-14', 'nathan.harris@example.com', 23, 2),
    ('Olivia', 'Martin', '2003-12-02', 'olivia.martin@example.com', 21, 3),
    ('Peter', 'Thompson', '2000-03-29', 'peter.thompson@example.com', 24, 1),
    ('Quinn', 'Garcia', '2002-06-06', 'quinn.garcia@example.com', 22, 2),
    ('Ryan', 'Martinez', '2001-10-20', 'ryan.martinez@example.com', 23, 3),
    ('Sophia', 'Robinson', '2003-08-12', 'sophia.robinson@example.com', 21, 1),
    ('Tyler', 'Clark', '2000-11-25', 'tyler.clark@example.com', 24, 2),
    ('Ursula', 'Rodriguez', '2002-01-07', 'ursula.rodriguez@example.com', 22, 3),
    ('Vincent', 'Lewis', '2001-04-16', 'vincent.lewis@example.com', 23, 1),
    ('Willow', 'Walker', '2003-07-28', 'willow.walker@example.com', 21, 2),
    ('Xavier', 'Hall', '2000-09-10', 'xavier.hall@example.com', 24, 3),
    ('Yvonne', 'Allen', '2002-05-03', 'yvonne.allen@example.com', 22, 1),
    ('Zachary', 'Young', '2001-02-15', 'zachary.young@example.com', 23, 2),
    ('Adam', 'King', '2003-11-08', 'adam.king@example.com', 21, 3),
    ('Beatrice', 'Scott', '2000-06-24', 'beatrice.scott@example.com', 24, 1),
    ('Caleb', 'Green', '2002-10-19', 'caleb.green@example.com', 22, 2),
    ('Diana', 'Adams', '2001-08-05', 'diana.adams@example.com', 23, 3),
    ('Edward', 'Baker', '2003-04-12', 'edward.baker@example.com', 21, 1),
    ('Fiona', 'Gonzalez', '2000-01-29', 'fiona.gonzalez@example.com', 24, 2),
    ('George', 'Nelson', '2002-07-17', 'george.nelson@example.com', 22, 3),
    ('Hannah', 'Carter', '2001-09-21', 'hannah.carter@example.com', 23, 1),
    ('Ian', 'Mitchell', '2003-05-08', 'ian.mitchell@example.com', 21, 2),
    ('Julia', 'Perez', '2000-02-28', 'julia.perez@example.com', 24, 3),
    ('Kyle', 'Roberts', '2002-06-30', 'kyle.roberts@example.com', 22, 1),
    ('Laura', 'Evans', '2001-07-12', 'laura.evans@example.com', 23, 2),
    ('Michael', 'Turner', '2003-09-18', 'michael.turner@example.com', 21, 3),
    ('Nina', 'Phillips', '2000-08-23', 'nina.phillips@example.com', 24, 1),
    ('Oscar', 'Campbell', '2002-03-14', 'oscar.campbell@example.com', 22, 2),
    ('Paula', 'Parker', '2001-11-27', 'paula.parker@example.com', 23, 3),
    ('Quincy', 'Hughes', '2003-01-31', 'quincy.hughes@example.com', 21, 1),
    ('Riley', 'Flores', '2000-10-22', 'riley.flores@example.com', 24, 2),
    ('Sarah', 'Morris', '2002-02-09', 'sarah.morris@example.com', 22, 3),
    ('Thomas', 'Stewart', '2001-05-06', 'thomas.stewart@example.com', 23, 1),
    ('Uma', 'Sanchez', '2003-12-10', 'uma.sanchez@example.com', 21, 2),
    ('Victor', 'Morgan', '2000-07-29', 'victor.morgan@example.com', 24, 3),
    ('Wendy', 'Reed', '2002-08-15', 'wendy.reed@example.com', 22, 1),
    ('Xander', 'Bailey', '2001-04-21', 'xander.bailey@example.com', 23, 2),
    ('Yasmin', 'Diaz', '2003-06-02', 'yasmin.diaz@example.com', 21, 3),
    ('Zane', 'Rivera', '2000-03-07', 'zane.rivera@example.com', 24, 1)
;

INSERT INTO Courses (CourseName, Credits)
VALUES 
    ('Database Systems', 3),
    ('Linear Algebra', 4),
    ('Quantum Mechanics', 5)
;

INSERT INTO Teachers (FullName, DepartmentID, CourseID)
VALUES 
    ('Dr. Emily Carter', 1, 1),  -- Computer Science, Database Systems
    ('Dr. James Miller', 2, 2),  -- Mathematics, Linear Algebra
    ('Dr. Sarah Wilson', 3, 3)
;  -- Physics, Quantum Mechanics

INSERT INTO Participations (StudentID, CourseID, Marks)
VALUES 
    (1, 1, 85),  -- Alice in Database Systems
    (2, 2, 78),  -- Bob in Linear Algebra
    (3, 3, 92)
;

CREATE INDEX idx_student_lastname ON Students (LastName);

SELECT * FROM Students WHERE LastName = 'Smith';

CREATE INDEX idx_name ON Students (FirstName, LastName);

SELECT * FROM Students WHERE FirstName = 'John' AND LastName = 'Doe';

CREATE UNIQUE INDEX idx_unique_email ON Students (Email);

UPDATE Students SET Email = 'alice@example.com' WHERE `StudentID` = 109;

UPDATE Students SET Email = 'alice@example.com' WHERE `StudentID` = 108; 

CREATE INDEX idx_active_students 
ON Students(Age)
WHERE Age > 21;

SELECT * FROM Students WHERE Age > 21;

CREATE FULLTEXT INDEX idx_search_name ON Students (FirstName, LastName);

SELECT * FROM Students WHERE MATCH(FirstName, LastName) AGAINST ('Alice');

SHOW INDEXES FROM Students;

DROP INDEX idx_student_lastname ON Students;

EXPLAIN ANALYZE SELECT * FROM Students WHERE LastName = 'Smith';

