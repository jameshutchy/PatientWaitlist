CREATE database PatientWaitList2;
GO
USE PatientWaitList2;
GO
CREATE TABLE Doctor(
doctorID INT PRIMARY KEY,
doctorFName VARCHAR(25),
doctorLName VARCHAR(25),
doctorType VARCHAR(15)
);

BULK INSERT Doctor
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\TableData\doctor.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Doctor]

CREATE TABLE Department(
departmentID INT PRIMARY KEY,
departmentName VARCHAR(25)
);

BULK INSERT Department
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\TableData\department.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Department]

CREATE TABLE Patient(
NHI VARCHAR(10) PRIMARY KEY,
patientFName VARCHAR(25),
patientLName VARCHAR(25),
DOB VARCHAR(25),
gender VARCHAR(25),
doctorID INT,
FOREIGN KEY (doctorID) REFERENCES Doctor (doctorID)
surgeon
);

BULK INSERT Patient
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\database 2\dataTables\patient.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Patient]

CREATE TABLE Referral(
referralID INT PRIMARY KEY,
referralDate DATE,
healthTargetEligible VARCHAR(10),
NHI VARCHAR(10),
FOREIGN KEY (NHI) REFERENCES Patient (NHI),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (departmentID)
);

BULK INSERT Referral
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\database 2\dataTables\referral.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO 

SELECT * FROM [dbo].[Referral]

CREATE TABLE Waitlist(
waitlistID INT PRIMARY KEY,
waitlistDate DATE,
FSA DATE,
NHI VARCHAR(10),
FOREIGN KEY (NHI) REFERENCES Patient (NHI),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (departmentID)
);

BULK INSERT Waitlist
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\database 2\dataTables\waitlist.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Waitlist]

CREATE TABLE Surgeon(
surgeonID INT PRIMARY KEY,
surgeonFName VARCHAR(25),
surgeonLName VARCHAR(25),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (DepartmentID)
);

BULK INSERT Surgeon
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\database 2\dataTables\surgeon.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Surgeon]
