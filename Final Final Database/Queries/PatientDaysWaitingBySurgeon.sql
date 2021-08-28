USE [PatientWaitList]
GO

SET STATISTICS IO ON
GO

SELECT s.[surgeonID] AS 'Surgeon ID',
CONCAT(s.[surgeonFName], ' ', s.[surgeonLName]) AS 'Surgeon Name', 
p.[NHI] AS 'Patient NHI',
CONCAT(p.[patientFName], ' ',p.[patientLName]) AS 'Patient Name',
DATEDIFF(DAY,r.[referralDate],r.[FSA]) AS 'Days Waiting'
FROM [dbo].[Referral] r
INNER JOIN [dbo].[Surgeon] s ON r.[surgeonID]=s.[surgeonID]
INNER JOIN [dbo].[Patient] p ON r.[NHI]=p.[NHI]
WHERE r.[FSA] IS NOT NULL 
AND r.[healthTargetEligible] = 'Yes'
ORDER BY s.[surgeonFName]
