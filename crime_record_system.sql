-- Crime Record Management System SQL Project

-- 1. Create Tables (NOTE: Remove 'CREATE DATABASE' and 'USE' if running in platforms that don't support them)

-- Officers Table
CREATE TABLE IF NOT EXISTS Officers (
    officer_id INT PRIMARY KEY,
    name VARCHAR(100),
    rank VARCHAR(50),
    department VARCHAR(50)
);

-- Criminals Table
CREATE TABLE IF NOT EXISTS Criminals (
    criminal_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    crime_type VARCHAR(100),
    arrest_date DATE
);

-- FIR Table
CREATE TABLE IF NOT EXISTS FIRs (
    fir_id INT PRIMARY KEY,
    filed_by_officer_id INT,
    criminal_id INT,
    description TEXT,
    filed_date DATE,
    FOREIGN KEY (filed_by_officer_id) REFERENCES Officers(officer_id),
    FOREIGN KEY (criminal_id) REFERENCES Criminals(criminal_id)
);

-- Cases Table
CREATE TABLE IF NOT EXISTS Cases (
    case_id INT PRIMARY KEY,
    fir_id INT,
    status VARCHAR(50),
    open_date DATE,
    close_date DATE,
    FOREIGN KEY (fir_id) REFERENCES FIRs(fir_id)
);

-- Case Updates Table
CREATE TABLE IF NOT EXISTS CaseUpdates (
    update_id INT PRIMARY KEY,
    case_id INT,
    updated_by_officer_id INT,
    update_detail TEXT,
    update_date DATE,
    FOREIGN KEY (case_id) REFERENCES Cases(case_id),
    FOREIGN KEY (updated_by_officer_id) REFERENCES Officers(officer_id)
);

-- 2. Sample Data Insertion

INSERT INTO Officers VALUES (1, 'Ravi Kumar', 'Inspector', 'Homicide');
INSERT INTO Officers VALUES (2, 'Anjali Mehra', 'Sub-Inspector', 'Cyber Crime');

INSERT INTO Criminals VALUES (101, 'Rahul Sharma', 30, 'Male', 'Robbery', '2025-02-15');
INSERT INTO Criminals VALUES (102, 'Sunita Rao', 26, 'Female', 'Fraud', '2025-03-05');

INSERT INTO FIRs VALUES (201, 1, 101, 'Robbery at State Bank', '2025-02-16');
INSERT INTO FIRs VALUES (202, 2, 102, 'Online bank fraud', '2025-03-06');

INSERT INTO Cases VALUES (301, 201, 'Open', '2025-02-17', NULL);
INSERT INTO Cases VALUES (302, 202, 'Closed', '2025-03-07', '2025-03-20');

INSERT INTO CaseUpdates VALUES (401, 301, 1, 'Initial investigation started', '2025-02-18');
INSERT INTO CaseUpdates VALUES (402, 302, 2, 'Evidence found and submitted', '2025-03-10');

-- 3. Sample Queries

-- a. List all open cases with NULL handled
SELECT 
    case_id,
    fir_id,
    status,
    open_date,
    IFNULL(close_date, 'Not Closed Yet') AS close_date
FROM Cases
WHERE status = 'Open';

-- b. Case updates with officer names
SELECT 
    cu.update_detail, 
    cu.update_date, 
    COALESCE(o.name, 'Unknown') AS officer_name
FROM CaseUpdates cu
JOIN Officers o ON cu.updated_by_officer_id = o.officer_id;

-- c. FIRs with criminal and officer names
SELECT 
    f.fir_id, 
    c.name AS criminal_name, 
    o.name AS officer_name, 
    f.description
FROM FIRs f
JOIN Criminals c ON f.criminal_id = c.criminal_id
JOIN Officers o ON f.filed_by_officer_id = o.officer_id;

-- d. Total cases filed by each officer
SELECT 
    o.name, 
    COUNT(c.case_id) AS total_cases
FROM Officers o
JOIN FIRs f ON o.officer_id = f.filed_by_officer_id
JOIN Cases c ON f.fir_id = c.fir_id
GROUP BY o.name;
