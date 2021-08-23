USE PatientWaitListFinal
GO
SELECT  s.surgeonFName, s.surgeonLName, p.NHI AS PatientNHI, pr.DaysWaiting
FROM PatientReferral pr
INNER JOIN Surgeon s ON pr.surgeonID=s.surgeonID
INNER JOIN Referral r ON pr.referralID=r.referralID
INNER JOIN Patient p ON pr.NHI=p.NHI
WHERE pr.DaysWaiting IS NOT NULL 
AND r.healthTargetEligible = 'Yes'
ORDER BY s.surgeonFName
