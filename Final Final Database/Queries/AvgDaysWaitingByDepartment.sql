USE [PatientWaitList]
GO

SET STATISTICS IO ON
GO

SELECT d.[departmentName], AVG(DATEDIFF(DAY,r.[referralDate],r.[FSA])) AS 'Average Days Waiting'
FROM [dbo].[Referral] r
INNER JOIN [dbo].[Department] d ON r.[departmentID]=d.[departmentID]
WHERE r.[FSA] IS NOT NULL 
AND r.[healthTargetEligible] = 'Yes'
GROUP BY d.[departmentName]
ORDER BY d.[departmentName]
