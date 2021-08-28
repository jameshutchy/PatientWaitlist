CREATE database PatientWaitList;
GO
USE PatientWaitList;
GO
CREATE TABLE Doctor(
doctorID INT PRIMARY KEY NOT NULL,
doctorFName VARCHAR(25) NOT NULL,
doctorLName VARCHAR(25) NOT NULL,
doctorType VARCHAR(15) NOT NULL
);

BULK INSERT Doctor
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Final Database\dataTables\doctor.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

--SELECT * FROM [dbo].[Doctor]

CREATE TABLE Department(
departmentID INT PRIMARY KEY NOT NULL,
departmentName VARCHAR(25) NOT NULL
);

BULK INSERT Department
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Final Database\dataTables\department.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

--SELECT * FROM [dbo].[Department]

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
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Final Database\dataTables\patient.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

--SELECT * FROM [dbo].[Patient]

CREATE TABLE Surgeon(
surgeonID INT PRIMARY KEY NOT NULL,
surgeonFName VARCHAR(25) NOT NULL,
surgeonLName VARCHAR(25) NOT NULL,
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (DepartmentID)
);


BULK INSERT Surgeon
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Final Database\dataTables\surgeon.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO

--SELECT * FROM [dbo].[Surgeon]



CREATE TABLE Referral(
referralID INT PRIMARY KEY NOT NULL,
referralDate DATE NOT NULL,
healthTargetEligible VARCHAR(10) NOT NULL,
waitlistDate DATE NULL,
FSA DATE NULL,
doctorID INT,
FOREIGN KEY (doctorID) REFERENCES Doctor (doctorID),
NHI VARCHAR(10) NOT NULL,
FOREIGN KEY (NHI) REFERENCES Patient (NHI),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department (departmentID),
surgeonID INT,
FOREIGN KEY (surgeonID) REFERENCES Surgeon (surgeonID)
);

BULK INSERT Referral
FROM 'C:\Users\james\OneDrive - Ara Institute of Canterbury\Bachelors level 5\Database Design\Assignment#1\Final Final Database\dataTables\referral.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO 

--SELECT * FROM [dbo].[Referral]

--DROP TABLE Referral 
--DROP TABLE Patient
SELECT r.[referralDate], CONCAT(DATEPART(yy,r.[referralDate]), '-', DATEPART(mm,r.[referralDate])) AS 'Year Month',
dr.[doctorType] AS 'Referred From', 
CONCAT(dr.[doctorFName], ' ', dr.[doctorLName]) AS 'Referred By',
p.[NHI], CONCAT(p.[patientFName], ' ', p.[patientLName]) AS 'Patient Name',
p.[DOB], p.[gender] AS Gender,
d.[departmentName] AS 'Department Name',
r.[waitlistDate] AS 'Added to Waitlist Date',
CONCAT(s.[surgeonFName], ' ', s.[surgeonLName]) AS 'Surgeon',
r.[FSA] AS 'FSA Date', r.[healthTargetEligible] AS 'Health Target Eligible',
CAST(DATEDIFF(DAY,p.[DOB],r.[referralDate]) /365.25 AS INT) AS 'Patient Age',
DATEDIFF(DAY,r.[referralDate],r.[FSA]) AS 'Days Waiting'
FROM [dbo].[Referral] r
INNER JOIN [dbo].[Department] d ON r.[departmentID]=d.[departmentID]
INNER JOIN [dbo].[Doctor] dr ON r.[doctorID]=dr.[doctorID]
INNER JOIN [dbo].[Patient] p ON r.[NHI]=p.[NHI]
INNER JOIN [dbo].[Surgeon] s ON r.[surgeonID]=s.[surgeonID]
GO

