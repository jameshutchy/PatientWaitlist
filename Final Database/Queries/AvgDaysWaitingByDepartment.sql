USE PatientWaitListFinal
GO
SELECT d.departmentName, AVG(pr.DaysWaiting) AS Avg_DaysWaiting 
FROM PatientReferral pr
INNER JOIN Department d ON pr.departmentID=d.departmentID
INNER JOIN Referral r ON pr.referralID=r.referralID
WHERE pr.DaysWaiting IS NOT NULL 
AND r.healthTargetEligible = 'Yes'
GROUP BY departmentName
ORDER BY departmentName
