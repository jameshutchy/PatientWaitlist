USE PatientWaitListFinal
GO
SELECT p.NHI, p.patientFName, p.patientLName, PatientAge, departmentName
FROM Patient p
INNER JOIN PatientReferral pr ON p.NHI=pr.NHI
INNER JOIN Referral r ON pr.referralID=r.referralID
INNER JOIN Department d ON pr.departmentID=d.departmentID
WHERE pr.PatientAge < 18 AND r.healthTargetEligible = 'Yes' 
AND d.departmentName !='Paediatric Surgery'

