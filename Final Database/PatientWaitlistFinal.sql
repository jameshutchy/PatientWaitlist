CREATE database PatientWaitListFinal;
GO
USE PatientWaitListFinal;
GO
CREATE TABLE Doctor(
doctorID INT PRIMARY KEY NOT NULL,
doctorFName VARCHAR(25) NOT NULL,
doctorLName VARCHAR(25) NOT NULL,
doctorType VARCHAR(15) NOT NULL
);

BULK INSERT Doctor
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Database\dataTables\doctor.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Doctor]

CREATE TABLE Department(
departmentID INT PRIMARY KEY NOT NULL,
departmentName VARCHAR(25) NOT NULL
);

BULK INSERT Department
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Database\dataTables\department.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Department]

CREATE TABLE Patient(
NHI VARCHAR(10) PRIMARY KEY NOT NULL,
patientFName VARCHAR(25) NOT NULL,
patientLName VARCHAR(25) NOT NULL,
gender VARCHAR(25) NOT NULL,
DOB DATE NOT NULL,
doctorID INT,
FOREIGN KEY (doctorID) REFERENCES Doctor (doctorID)
);

BULK INSERT Patient
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Database\dataTables\patient.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Patient]

CREATE TABLE Surgeon(
surgeonID INT PRIMARY KEY NOT NULL,
surgeonFName VARCHAR(25) NOT NULL,
surgeonLName VARCHAR(25) NOT NULL,
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (DepartmentID)
);


BULK INSERT Surgeon
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Database\dataTables\surgeon.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

SELECT * FROM [dbo].[Surgeon]



CREATE TABLE Referral(
referralID INT PRIMARY KEY NOT NULL,
referralDate DATE NOT NULL,
healthTargetEligible VARCHAR(10) NOT NULL,
waitlistDate DATE NULL,
FSA DATE NULL,
doctorID INT,
FOREIGN KEY (doctorID) REFERENCES Doctor (doctorID)
);

BULK INSERT Referral
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Database\dataTables\referral.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO 

SELECT * FROM [dbo].[Referral]

CREATE TABLE PatientReferral(
patientReferralID INT PRIMARY KEY NOT NULL,
NHI VARCHAR(10) NOT NULL,
FOREIGN KEY (NHI) REFERENCES Patient (NHI),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (departmentID),
surgeonID INT,
FOREIGN KEY (surgeonID) REFERENCES Surgeon (surgeonID),
referralID INT,
FOREIGN KEY (referralID) REFERENCES Referral (referralID)
);

BULK INSERT PatientReferral
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Database\dataTables\patientReferral.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO 

SELECT * FROM [dbo].[PatientReferral]

--creating added fields

ALTER TABLE PatientReferral ADD PatientAge INT

UPDATE PatientReferral
SET [PatientAge] = DATEDIFF(DAY,p.DOB,r.referralDate) /365.25
FROM PatientReferral pr
JOIN Patient p ON pr.NHI=p.NHI
JOIN Referral r ON pr.referralID = r.referralID

SELECT * FROM PatientReferral

ALTER TABLE PatientReferral ADD DaysWaiting INT

UPDATE PatientReferral
SET DaysWaiting = DATEDIFF(DAY,r.referralDate,r.FSA)
FROM PatientReferral p
JOIN Referral r ON p.referralID = r.referralID



--ALTER TABLE PatientReferral DROP COLUMN DaysWaiting;

