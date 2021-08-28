USE [PatientWaitList]
GO

SET STATISTICS IO ON
GO

SELECT d.[departmentName] AS 'Department Name',
CAST((CAST(m.MetCount AS DECIMAL(5,3)) / CAST(p.NoPatient AS DECIMAL(5,3))) *100 AS DECIMAL) AS 'Percentage Met'
FROM
(
	SELECT r.[departmentID], COUNT(*) AS MetCount 
	FROM  [dbo].[Referral] r
	WHERE DATEDIFF(DAY,r.[referralDate],r.[FSA]) < 76 
	AND r.[healthTargetEligible] = 'Yes'
	GROUP BY r.[departmentID]
) AS m
RIGHT JOIN 
(
	SELECT r.[departmentID], COUNT(*) AS NoPatient
	FROM  [dbo].[Referral] r
	WHERE r.[healthTargetEligible] = 'Yes'
	GROUP BY r.[departmentID]
) AS p ON p.[departmentID]=m.[departmentID]
INNER JOIN [dbo].[Department] d ON d.[departmentID]=p.[departmentID]