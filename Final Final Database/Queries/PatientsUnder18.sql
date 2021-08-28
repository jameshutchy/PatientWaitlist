USE [PatientWaitList]
GO

SET STATISTICS IO ON
GO

SELECT p.[NHI] AS 'Patient NHI',
CONCAT(p.[patientFName], ' ', p.[patientLName]) AS 'Patient Name',
CAST(DATEDIFF(DAY,p.[DOB],r.[referralDate]) /365.25 AS INT) AS 'Patient Age',
d.[departmentName] AS 'Department Name'
FROM  [dbo].[Referral] r
INNER JOIN [dbo].[Patient] p ON p.[NHI]=r.[NHI]
INNER JOIN [dbo].[Department] d ON r.[departmentID]=d.[departmentID]
WHERE CAST(DATEDIFF(DAY,p.[DOB],r.[referralDate]) /365.25 AS INT) < 18 
AND r.[healthTargetEligible] = 'Yes' 
AND d.[departmentName] !='Paediatric Surgery'


