/*
NORMALISATION -- Normalization is the process of minimizing redundancy from a relation or set of relations. Redundancy in relation may cause insertion, deletion, and update anomalies. So, it helps to minimize the redundancy in relations. Normal forms are used
to eliminate or reduce redundancy in database tables
------------------------------------------------------------------------------------------------------------------------
First Normal Form (1NF)
Definition: A table is in 1NF if it only contains atomic (indivisible) values, and each column contains values of a single type.

Example: Unnormalized Table

StudentID	Name			Courses
1			John Smith		Math, Science
2			Jane Doe		English, History
3			Alice Brown		Math, History
Normalized Table (1NF)

StudentID	Name	Course
1		John Smith	Math
1		John Smith	Science
2		Jane Doe	English
2		Jane Doe	History
3		Alice Brown	Math
3		Alice Brown	History
------------------------------------------------------------------------------------------------------------------------- */
CREATE TABLE UnnormalizedStudents (
    StudentID INT,
    Name VARCHAR(255),
    Courses VARCHAR(255)
);

INSERT INTO UnnormalizedStudents (StudentID, Name, Courses) VALUES
(1, 'John Smith', 'Math, Science'),
(2, 'Jane Doe', 'English, History'),
(3, 'Alice Brown', 'Math, History');

CREATE TABLE NormalizedStudents (
    StudentID INT,
    Name VARCHAR(255),
    Course VARCHAR(255)
);

INSERT INTO NormalizedStudents (StudentID, Name, Course) VALUES (1, 'John Smith', 'Math');
INSERT INTO NormalizedStudents (StudentID, Name, Course) VALUES (1, 'John Smith', 'Science');
INSERT INTO NormalizedStudents (StudentID, Name, Course) VALUES (2, 'Jane Doe', 'English');
INSERT INTO NormalizedStudents (StudentID, Name, Course) VALUES (2, 'Jane Doe', 'History');
INSERT INTO NormalizedStudents (StudentID, Name, Course) VALUES (3, 'Alice Brown', 'Math');


/*
Second Normal Form (2NF)
Definition: A table is in 2NF if it is in 1NF and all non-key attributes are fully functional dependent on the primary key. This means no partial dependency (i.e., no non-key attribute is dependent on part of the primary key).

Example: 1NF Table

StudentID	Course	InstructorID	InstructorName
1			Math		101			Dr. Brown
1			Science		102			Dr. Green
2			English		103			Dr. White
2			History		104			Dr. Black
3			Math		101			Dr. Brown
3			History		104			Dr. Black
Normalized Table (2NF)

Students Table

StudentID	Course
1			Math
1			Science
2			English
2			History
3			Math
3			History

Instructors Table

InstructorID	InstructorName
	101			Dr. Brown
	102			Dr. Green
	103			Dr. White
	104			Dr. Black
----------------------------------------------------------------------------------------------------------------------------
*/
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(255)
);

-- Insert data into Employees table
INSERT INTO Employees (Employee_ID, Employee_Name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Alex Johnson');

CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(255),
    Project_Manager VARCHAR(255)
);

-- Insert data into Projects table
INSERT INTO Projects (Project_ID, Project_Name, Project_Manager) VALUES
(101, 'Project X', 'Jane Smith'),
(102, 'Project Y', 'John Davis');

CREATE TABLE Employee_Project_Assignment (
    Employee_ID INT,
    Project_ID INT,
    PRIMARY KEY (Employee_ID, Project_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID)
);

-- Insert data into Employee_Project_Assignment table
INSERT INTO Employee_Project_Assignment (Employee_ID, Project_ID) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 102);

/*
Third Normal Form (3NF)
Definition: A table is in 3NF if it is in 2NF and all attributes are functionally dependent only on the primary key, with no transitive dependency.

Example: 2NF Table

StudentID	Course	InstructorID	InstructorName	InstructorDept
	1		Math		101			Dr. Brown			Math
	1		Science		102			Dr. Green			Science
	2		English		103			Dr. White			English
	2		History		104			Dr. Black			History
	3		Math		101			Dr. Brown			Math
	3		History		104			Dr. Black			History
Normalized Table (3NF)

Students Table

StudentID	Course
	1		Math
	1		Science
	2		English
	2		History
	3		Math
	3		History
Instructors Table

InstructorID	InstructorName	InstructorDept
101				Dr. Brown		Math
102				Dr. Green		Science
103				Dr. White		English
104				Dr. Black		History
--------------------------------------------------------------------------------------------------------------------------*/
/*
Example Table (Violates 3NF)
Consider a table Student_Courses where information about students and the courses they are enrolled in is stored:

Student_ID	Student_Name	Course_ID	Course_Name	Instructor	Instructor_Department
1	John Smith	101	Math	Dr. Brown	Mathematics
1	John Smith	102	Science	Dr. Green	Science
2	Jane Doe	103	English	Dr. White	Literature
2	Jane Doe	104	History	Dr. Black	History
3	Alice Brown	101	Math	Dr. Brown	Mathematics
3	Alice Brown	104	History	Dr. Black	History
In this table:

Candidate Key: (Student_ID, Course_ID)
Non-Key Attributes: Student_Name, Course_Name, Instructor, Instructor_Department
Normalizing into 3NF
To normalize this table into 3NF, we need to:

Eliminate Transitive Dependencies.
1) Identify Transitive Dependencies

Student_ID → Student_Name
Course_ID → Course_Name, Instructor, Instructor_Department

2) Remove Transitive Dependencies

Students (Student_ID (PK), Student_Name)
Courses (Course_ID (PK), Course_Name)
Course_Instructors (Course_ID (FK), Instructor, Instructor_Department)

Normalized Tables (3NF)
*/
CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(255)
);

-- Insert data into Students table
INSERT INTO Students (Student_ID, Student_Name) VALUES
(1, 'John Smith'),
(2, 'Jane Doe'),
(3, 'Alice Brown');

CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(255)
);

-- Insert data into Courses table
INSERT INTO Courses (Course_ID, Course_Name) VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'English'),
(104, 'History');

CREATE TABLE Course_Instructors (
    Course_ID INT,
    Instructor VARCHAR(255),
    Instructor_Department VARCHAR(255),
    PRIMARY KEY (Course_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);

-- Insert data into Course_Instructors table
INSERT INTO Course_Instructors (Course_ID, Instructor, Instructor_Department) VALUES
(101, 'Dr. Brown', 'Mathematics'),
(102, 'Dr. Green', 'Science'),
(103, 'Dr. White', 'Literature'),
(104, 'Dr. Black', 'History');

/*
Boyce-Codd Normal Form (BCNF)
Definition: A table is in BCNF if it is in 3NF and for every functional dependency 
𝑋
→
𝑌
X→Y, 
𝑋
X is a super key.

Example: 3NF Table

Course	InstructorID	InstructorName	StudentID
Math		101			Dr. Brown			1
Science		102			Dr. Green			1
English		103			Dr. White			2
History		104			Dr. Black			2
Math		101			Dr. Brown			3
History		104			Dr. Black			3

Normalized Table (BCNF)

Courses Table
Course	InstructorID
	Math	101
	Science	102
	English	103
	History	104

Instructors Table
InstructorID	InstructorName
	101			Dr. Brown
	102			Dr. Green
	103			Dr. White
	104			Dr. Black
Enrollments Table

StudentID	Course
	1		Math
	1		Science
	2		English
	2		History
	3		Math
	3		History
---------------------------------------------------------------------------------------------------------------------------*/
/*
Example Table
Suppose we have a table Employee_Projects that tracks which employees work on which projects and their roles:

Employee_ID	Project_ID	Employee_Name	Project_Name	Role
1	101	John Smith	Project X	Developer
2	101	Jane Doe	Project X	Tester
3	102	Alice Brown	Project Y	Project Lead
3	102	Alice Brown	Project Z	Developer
In this table:

Candidate Key: (Employee_ID, Project_ID)
Non-Key Attributes: Employee_Name, Project_Name, Role
Determinants Analysis
To determine if the table is in BCNF, we need to check if every determinant is a candidate key.

Determinants:
Employee_ID → Employee_Name
Project_ID → Project_Name
Checking BCNF Violations
From the determinants:

Employee_ID is a determinant but not a candidate key (multiple employees can have the same ID).
Project_ID is a determinant but not a candidate key (multiple projects can have the same ID).
Normalizing into BCNF
To normalize this table into BCNF, we need to split the table into two tables: 
Employees and Projects, ensuring that each determinant is a candidate key.
*/

CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(255)
);

-- Insert data into Employees table
INSERT INTO Employees (Employee_ID, Employee_Name) VALUES
(1, 'John Smith'),
(2, 'Jane Doe'),
(3, 'Alice Brown');

CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(255)
);

-- Insert data into Projects table
INSERT INTO Projects (Project_ID, Project_Name) VALUES
(101, 'Project X'),
(102, 'Project Y'),
(103, 'Project Z');

CREATE TABLE Employee_Projects (
    Employee_ID INT,
    Project_ID INT,
    Role VARCHAR(255),
    PRIMARY KEY (Employee_ID, Project_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID)
);

-- Insert data into Employee_Projects table
INSERT INTO Employee_Projects (Employee_ID, Project_ID, Role) VALUES
(1, 101, 'Developer'),
(2, 101, 'Tester'),
(3, 102, 'Project Lead'),
(3, 103, 'Developer');

/*
Fourth Normal Form (4NF)
Definition: A table is in 4NF if it is in BCNF and contains no multi-valued dependencies.

Example: BCNF Table with multi-valued dependencies

StudentID	Course	Hobby
	1		Math	Reading
	1		Math	Swimming
	1		Science	Reading
	1		Science	Swimming
	2		English	Painting
	2		English	Cycling
	2		History	Painting
	2		History	Cycling
Normalized Table (4NF)

Students Table

StudentID	Course
1	Math
1	Science
2	English
2	History
Hobbies Table

StudentID	Hobby
1	Reading
1	Swimming
2	Painting
2	Cycling

 The Fourth Normal Form (4NF) deals with multi-valued dependencies and is an extension of the Third Normal Form (3NF). It aims to eliminate non-trivial multi-valued dependencies where attributes depend on each other in a way that is not covered by 3NF. Let's consider an example to illustrate 4NF:

Example Table
Suppose we have a table Student_Courses that tracks which courses each student is enrolled in:

Student_ID	Course_ID	Student_Name	Course_Name
1	101	John Smith	Math
1	102	John Smith	Science
2	103	Jane Doe	English
2	104	Jane Doe	History
3	101	Alice Brown	Math
3	104	Alice Brown	History
In this table:

Candidate Key: (Student_ID, Course_ID)
Non-Key Attributes: Student_Name, Course_Name
Multi-Valued Dependency Analysis
To determine if the table is in 4NF, we need to check for multi-valued dependencies where non-key attributes depend on each other.

Multi-Valued Dependencies:
Student_ID →→ Student_Name
Course_ID →→ Course_Name
Here, →→ denotes a multi-valued dependency.

Checking for Violations
In this example, there are no violations of 4NF because:

Each student can enroll in multiple courses, and each course can be taken by multiple students independently.
Student_Name and Course_Name depend only on Student_ID and Course_ID respectively, which are candidate keys.
Normal Form Verification
Since there are no non-trivial multi-valued dependencies
(dependencies where attributes do not directly depend on a candidate key) in the table, it is already in 4NF.
-----------------------------------------------------------------------------------------------------------------------*/


/*

/*
The Fifth Normal Form (5NF) is concerned with addressing cases where a table has join dependencies involving more than one candidate key. It aims to decompose tables in such a way that ensures all join dependencies are logically implied by the candidate keys. Let's consider an example to illustrate 5NF:

Example Table
Suppose we have a table Student_Courses_Grades that tracks which courses each student is enrolled in and their grades:

Student_ID	Course_ID	Student_Name	Course_Name	Grade
1			101			John Smith		Math		A
1			102			John Smith		Science		B
2			103			Jane Doe		English		A
2			104			Jane Doe		History		A
3			101			Alice Brown		Math		B
3			104			Alice Brown		History		A
In this table:

Candidate Keys: (Student_ID, Course_ID)
Non-Key Attributes: Student_Name, Course_Name, Grade
Join Dependencies Analysis
To determine if the table is in 5NF, we need to consider the join dependencies involving the candidate keys.

Join Dependencies:
(Student_ID, Course_ID) → Student_Name, Course_Name
(Student_ID, Course_ID) → Grade
Decomposition into 5NF
To achieve 5NF, we can decompose the table into two separate tables:

Student_Courses Table:

Student_ID	Course_ID	Student_Name	Course_Name
1			101			John Smith			Math
1			102			John Smith			Science
2			103			Jane Doe			English
2			104			Jane Doe			History
3			101			Alice Brown			Math
3			104			Alice Brown			History
This table contains information about which courses each student is enrolled in.

Student_Grades Table:

Student_ID	Course_ID		Grade
1				101			A
1				102			B
2				103			A
2				104			A
3				101			B
3				104			A
This table contains information about the grades each student received in each course.

Verification of 5NF
By decomposing the original table into Student_Courses and Student_Grades, we ensure that:

Each table now contains only attributes that are functionally dependent on the candidate keys (Student_ID, Course_ID).
There are no non-trivial join dependencies other than those logically implied by the candidate keys.

*/