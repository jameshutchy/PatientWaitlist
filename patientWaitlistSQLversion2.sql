CREATE database PatientWaitList;
GO
USE PatientWaitList;
GO
CREATE TABLE Doctor(
doctorID INT IDENTITY(1000,1) PRIMARY KEY,
doctorFName VARCHAR(25),
doctorLName VARCHAR(25),
doctorType VARCHAR(15)
);

BULK INSERT Doctor
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\doctor.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Doctor]

CREATE TABLE Department(
departmentID INT IDENTITY(1000,1) PRIMARY KEY,
departmentName VARCHAR(25)
);

BULK INSERT Department
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\department.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Department]

CREATE TABLE Referral(
referralID INT IDENTITY(1000,1) PRIMARY KEY,
referralDate DATE,
healthTargetEligible VARCHAR(10)
);

BULK INSERT Referral
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\referral.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO 

SELECT * FROM [dbo].[Referral]
--comented out not sure how to set date
--insert INTo Referral ( referralID, referralDate, healthTargetEligible) VALUES (1, date(01/07/2015), 'Yes');

CREATE TABLE Waitlist(
waitlistID INT IDENTITY(1000,1) PRIMARY KEY,
waitlistDate DATE,
FSA DATE
);

BULK INSERT Waitlist
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\waitlist.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Waitlist]

CREATE TABLE Surgeon(
surgeonID INT IDENTITY(1000,1) PRIMARY KEY,
surgeonFName VARCHAR(25),
surgeonLName VARCHAR(25),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (DepartmentID)
);

BULK INSERT Surgeon
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\surgeon.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Surgeon]

CREATE TABLE Patient(
NHI VARCHAR(10) PRIMARY KEY,
patientFName VARCHAR(25),
patientLName VARCHAR(25),
DOB VARCHAR(25),
gender VARCHAR(25),
doctorID INT,
FOREIGN KEY (doctorID) REFERENCES Doctor (doctorID),
referralId INT,
FOREIGN KEY (referralID) REFERENCES Referral (referralID),
waitlistID INT,
FOREIGN KEY (waitlistID) REFERENCES Waitlist (waitlistID)
);

BULK INSERT Patient
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\patient.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Patient]

CREATE TABLE DepartmentReferral(
departmentReferralID INT IDENTITY(1000,1) PRIMARY KEY,
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (departmentID),
referralID INT,
FOREIGN KEY (referralID) REFERENCES Referral (referralID)
);

BULK INSERT DepartmentReferral
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\departmentReferral.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[DepartmentReferral]

CREATE TABLE DepartmentWaitlist(
departmentWaitlistID INT IDENTITY(1000,1) PRIMARY KEY,
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (departmentID),
waitlistID INT,
FOREIGN KEY (waitlistID) REFERENCES Waitlist (waitlistID)
);

BULK INSERT DepartmentWaitlist
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment1\TableData\departmentWaitlist.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO


SELECT * FROM [dbo].[DepartmentWaitlist]