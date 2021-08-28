USE PatientWaitListFinal
GO
SELECT d.departmentName AS 'Department Name',
CAST(CASE WHEN (CAST(m.MetCount AS DECIMAL(5,3)) / CAST(p.NoPatient AS DECIMAL(5,3))) *100 IS NULL THEN 0 
ELSE (CAST(m.MetCount AS DECIMAL(5,3)) / CAST(p.NoPatient AS DECIMAL(5,3))) *100 END AS DECIMAL(3,2)) AS 'Percentage Met'
FROM
(
	SELECT departmentID, COUNT(*) AS MetCount 
	FROM PatientReferral 
	WHERE DaysWaiting < 76
	GROUP BY departmentID
) AS m
RIGHT JOIN 
(
	SELECT departmentID, COUNT(*) AS NoPatient
	FROM PatientReferral
	GROUP BY departmentID
) AS p ON p.departmentID=m.departmentID
INNER JOIN Department d ON d.departmentID=p.departmentID
