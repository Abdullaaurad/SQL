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
    ('Charlie', 'Brown', '2003-01-10', 'charlie.brown@example.com', 21, 3)
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

ALTER TABLE Students ADD COLUMN PhoneNumber INT(10) NOT NULL;

ALTER TABLE Students ADD CONSTRAINT phone UNIQUE (PhoneNumber);

ALTER TABLE Students MODIFY PhoneNumber VARCHAR(10) UNIQUE;

ALTER TABLE participations ADD CONSTRAINT MarksCheck CHECK(Marks BETWEEN 0 AND 100);

ALTER TABLE participations DROP CONSTRAINT MarksCheck;

ALTER TABLE Students DROP COLUMN Age;

ALTER TABLE Students 
ADD COLUMN Age INT,
ADD CONSTRAINT chk_Age CHECK (Age BETWEEN 20 AND 26);

ALTER TABLE students CHANGE COLUMN Age StudentAge TINYINT;

ALTER TABLE participations ADD UNIQUE(StudentID, CourseID);

REPLACE INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email, StudentAge, DepartmentID, PhoneNumber)
VALUES (1, 'Alice', 'Johnson', '2002-03-15', 'alice.newemail@example.com', 22, 1, '777362229');

UPDATE Students 
SET Email = 'alice.newemail@example.com' 
WHERE StudentID = 1;

SELECT S.StudentID, S.FirstName, S.LastName, D.DepartmentName
FROM Students S
JOIN department D ON S.`DepartmentID` = D.`DepartmentID`
ORDER BY StudentID;

SELECT COUNT(StudentID) AS CountOfStudents, D.DepartmentName, D.`DepartmentID`
FROM Students S
JOIN department D ON S.`DepartmentID` = D.`DepartmentID`
GROUP BY `DepartmentID`
ORDER BY `DepartmentID`;

SELECT S.StudentID , CONCAT(S.FirstName , ' ', S.LastName ) AS FullName,  C.CourseName, P.Marks
FROM Students S
JOIN Participations P ON P.`StudentID` = `S`.`StudentID`
JOIN courses C ON P.`CourseID` = C.`CourseID`; 

CREATE VIEW StudentDetails AS
SELECT S.StudentID , CONCAT(S.FirstName , ' ', S.LastName ) AS FullName,  C.CourseName, P.Marks
FROM Students S
JOIN Participations P ON P.`StudentID` = `S`.`StudentID`
JOIN courses C ON P.`CourseID` = C.`CourseID`; 

DROP VIEW StudentDetails;

SELECT * FROM StudentDetails;

CREATE OR REPLACE VIEW StudentDetails AS
SELECT * FROM Students;

CREATE VIEW StudentPassed AS
SELECT S.StudentID , CONCAT(S.FirstName , ' ', S.LastName ) AS FullName,  C.CourseName, P.Marks
FROM Students S
JOIN Participations P ON P.`StudentID` = `S`.`StudentID`
JOIN courses C ON P.`CourseID` = C.`CourseID`
WHERE P.Marks > 70;

SELECT * FROM studentPassed;

CREATE OR REPLACE VIEW StudentGrade AS
SELECT 
    S.StudentID, 
    CONCAT(S.FirstName, ' ', S.LastName) AS FullName,  
    C.CourseName, 
    P.Marks,
    CASE 
        WHEN P.Marks >= 70 THEN 'A'
        WHEN P.Marks >= 60 THEN 'B'
        WHEN P.Marks >= 50 THEN 'C'
        WHEN P.Marks >= 30 THEN 'D'
        ELSE 'F'
    END AS Grade
FROM Students S
JOIN Participations P ON P.StudentID = S.StudentID
JOIN Courses C ON P.CourseID = C.CourseID;

SELECT * FROM studentgrade;

CREATE PROCEDURE StoreStudent (
    IN FirstName VARCHAR(50),
    IN LastName VARCHAR(50),
    IN DateOfBirth DATE,
    IN Email VARCHAR(100),
    IN DepartmentID INT,
    IN PhoneNumber VARCHAR(10)
)
BEGIN
    INSERT INTO Students(`FirstName`, `LastName`, `DateOfBirth`, `Email`, `DepartmentID`, `PhoneNumber`) 
    VALUES(
        `FirstName`,
        `LastName`,
        `DateOfBirth`,
        `Email`,
        `DepartmentID`,
        `PhoneNumber`
    );
END;

CALL StoreStudent("Abdulla", "Aurad", '2002-11-24', 'Abdullauarda@gmail.com', 1, '0779991124' );

CREATE PROCEDURE StoreDepartment (
    IN DepartmentName VARCHAR(50),
    IN Location VARCHAR(100)
)
BEGIN 
    IF Location IS NULL THEN
        SET Location = 'Building A';
    END IF;
    INSERT INTO department(`DepartmentName`, `Location`)
    VALUES (`DepartmentName`, `Location`);
END;

CALL StoreDepartment("Chemistry", null);

DROP PROCEDURE `StoreDepartment`;

CREATE PROCEDURE GradeStudent (IN StudentID INT)
BEGIN
    SELECT S.StudentID , CONCAT(S.FirstName , ' ', S.LastName ) AS FullName,  C.CourseName,
    CASE 
        WHEN P.Marks > 70 THEN 'A'
        WHEN P.Marks > 60 THEN 'B'
        WHEN P.Marks > 50 THEN 'C'
        WHEN P.Marks > 40 THEN 'D'
    END AS Grade
    FROM Students S
    JOIN Participations P ON P.`StudentID` = `S`.`StudentID`
    JOIN courses C ON P.`CourseID` = C.`CourseID`
    WHERE S.StudentID = StudentID;
END

CALL GradeStudent(2);

CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.DateOfBirth, CURDATE()) < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student must be at least 18 years old';
    END IF;
END 
DELIMITER ;

CALL StoreStudent("Yunus", "Mahir", '2017-11-24', 'Ayyub@gmail.com', 1, '07799911289' );

CREATE TRIGGER before_marks_insert
BEFORE INSERT ON Participations
FOR EACH ROW
BEGIN
    IF NEW.Marks IS NULL THEN
        SET NEW.Marks = 0;
    END IF;
END;

INSERT INTO Participations (StudentID, CourseID, Marks)
VALUES 
    (1, 3, NULL)
;

CREATE TABLE StudentArchive (
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER after_student_delete
AFTER DELETE ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentArchive (StudentID, FirstName, LastName)
    VALUES (OLD.StudentID, OLD.FirstName, OLD.LastName);
END

CREATE PROCEDURE EnrollStudent(
    IN p_StudentID INT,
    IN p_CourseID INT
)
BEGIN
    DECLARE studentExists INT;

    SELECT COUNT(*) INTO studentExists FROM Students WHERE StudentID = p_StudentID;

    IF studentExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not exist!';
    ELSE
        INSERT INTO Participations (StudentID, CourseID, Marks) VALUES (p_StudentID, p_CourseID, 0);
    END IF;
END;

Call EnrollStudent(3,2);