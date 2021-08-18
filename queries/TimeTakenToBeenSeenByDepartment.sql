USE PatientWaitList3;
GO

SELECT DATEDIFF(DAY,waitlistDate,FSA) AS TimeTaken, departmentName AS DepartmentName
INTO TimeTakenToBeSeen
FROM Waitlist 
JOIN Department ON Waitlist.departmentID=Department.departmentID
WHERE NOT FSA = '19000101'
;
SELECT * FROM TimeTakenToBeSeen

SELECT DepartmentName, AVG(TimeTaken) AS [Avg_TimeTaken]
FROM TimeTakenToBeSeen
GROUP BY DepartmentName
ORDER BY DepartmentName
