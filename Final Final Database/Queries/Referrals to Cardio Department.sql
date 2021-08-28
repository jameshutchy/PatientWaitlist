USE PatientWaitList
GO

SET STATISTICS IO ON
GO

SELECT COUNT(referralID) PatientsReferredToCardio
FROM Referral r
WHERE r.departmentID = 102 
AND r.healthTargetEligible = 'Yes'
--Not sure if needed to be where departmentName = cardio~ 
--as it seems to be most efficient to check by departmentID (no joins needed)

