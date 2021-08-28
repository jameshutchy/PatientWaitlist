USE [PatientWaitList]
GO

SET STATISTICS IO ON
GO
SELECT p.[NHI], CONCAT(p.[patientFName], ' ',p.[patientLName] ) AS 'Patient Name', 
CAST(DATEDIFF(DAY,p.DOB,r.referralDate) /365.25 AS INT) AS 'Patient Age'
FROM [dbo].[Referral] r
INNER JOIN [dbo].[Patient]p ON r.[NHI]=p.[NHI]
