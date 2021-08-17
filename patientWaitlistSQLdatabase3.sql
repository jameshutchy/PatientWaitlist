CREATE database PatientWaitList;
GO
USE PatientWaitList;
GO
CREATE TABLE Doctor(
doctorID INT PRIMARY KEY,
doctorFName VARCHAR(25),
doctorLName VARCHAR(25),
doctorType VARCHAR(15)
);

BULK INSERT Doctor
FROM '\\ADFSSTUD2\j-m\jch233\WindowsSettings\Desktop\dataTables\doctor.csv'
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
FROM '\\ADFSSTUD2\j-m\jch233\WindowsSettings\Desktop\dataTables\department.csv'
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
);

BULK INSERT Patient
FROM '\\ADFSSTUD2\j-m\jch233\WindowsSettings\Desktop\dataTables\patient.csv'
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
FROM '\\ADFSSTUD2\j-m\jch233\WindowsSettings\Desktop\dataTables\referral.csv'
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
FROM '\\ADFSSTUD2\j-m\jch233\WindowsSettings\Desktop\dataTables\waitlist.csv'
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
FROM '\\ADFSSTUD2\j-m\jch233\WindowsSettings\Desktop\dataTables\surgeon.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Surgeon]
