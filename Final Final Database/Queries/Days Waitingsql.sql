USE [PatientWaitList]
GO
SET STATISTICS IO ON
GO

SELECT r.[referralID] AS 'Referral ID', DATEDIFF(DAY,r.[referralDate],r.[FSA]) AS 'Days Waiting'
FROM [dbo].[Referral] r
WHERE r.[healthTargetEligible] = 'Yes'
AND r.[FSA] IS NOT NULL
