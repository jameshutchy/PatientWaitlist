USE PatientWaitListFinal
GO

SELECT COUNT(*) PatientsReferredToCardio
FROM PatientReferral pr
INNER JOIN Referral r ON pr.referralID=r.referralID
WHERE pr.departmentID = 102 
AND r.healthTargetEligible = 'Yes'


