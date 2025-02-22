SELECT * FROM [dbo].[healthcare_dataset]


--COUNT OF RECORDS
SELECT COUNT (*) AS TOTAL_RECORDS 
FROM [dbo].[healthcare_dataset]


--OLDEST AGE OF PATIENT
SELECT MAX(AGE) AS OldestAge
FROM DBO.healthcare_dataset


--AVEARGE AGE HOSPITALIZED
SELECT AVG(AGE) AS AverageAgeHospitalized 
FROM DBO.healthcare_dataset 


--Calculating Patients Hospitalized Age-wise from Maximum to Minimum
SELECT AGE, cOUNT(AGE) AS TOTAL
FROM DBO.healthcare_dataset
GROUP BY AGE
ORDER BY AGE DESC


--Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.
SELECT AGE, COUNT(*) AS PATIENTCOUNT
FROM DBO.healthcare_dataset
GROUP BY AGE 
ORDER BY PATIENTCOUNT

--Ranking Age on the number of patients Hospitalized   
SELECT AGE, COUNT (*) AS HOSPITALIZED,
RANK() OVER (ORDER BY COUNT(*) DESC) AS RANKAGE
FROM [dbo].[healthcare_dataset]
GROUP BY AGE 
ORDER BY RANKAGE



SELECT AGE, COUNT(AGE) As Total, dense_RANK() OVER(ORDER BY COUNT(AGE) DESC, age DESC) as Ranking_Admitted
FROM HEALTHCARE_DATASET
GROUP BY age
HAVING COUNT(AGE) > Avg(age);



--7 Find Count of Medical Condition of patients and listing it by Max no. of patients

Select [Medical_Condition], Count (*) as 'Max NUM. OF PATIENTS'
From HEALTHCARE_DATASET
Group By [Medical_Condition]

--8 Finding Rank & MAX number of medicines recommended to patients based on Medical_Condition pertaining to them

Select [Medical_Condition],medication, COUNT(medication) as 'MAX NUM OF MEDS',
DENSE_RANK() OVER (order by COUNT(medication) DESC) as Rank
FROM HEALTHCARE_DATASET
Group By [Medical_Condition], medication



--9 Most Preffered Insurance Provider by Patients

Select TOP 1 [Insurance_Provider], MAX(Count) as Count
From
(
Select [Insurance_Provider], Count(*) as Count
From HEALTHCARE_DATASET
Group By [Insurance_Provider]
) D
Group By [Insurance_Provider]
Order By Count DESC

------ANOTHER APPROCH
SELECT TOP 1 [Insurance_Provider] , Count(*) as Count
From HEALTHCARE_DATASET
GROUP BY [Insurance_Provider]
ORDER BY COUNT(*) DESC

--10 Most Preffered Hospital
Select TOP 1 Hospital, MAX(Count) as Count
From
(
Select Hospital, Count(*) as Count
From HEALTHCARE_DATASET
Group By Hospital
) D
Group By Hospital
Order By Count DESC

------ANOTHER APPROCH

SELECT TOP 1 Hospital , Count(*) as Count
From HEALTHCARE_DATASET
GROUP BY Hospital
ORDER BY COUNT(*) DESC




--11 Identify Average Billing Amount by Medical_Condition
Select top 1 [Medical_Condition], AVG([Billing_Amount]) AS 'AVG BILLING AMT' from
HEALTHCARE_DATASET
Group By [Medical_Condition]

--TOP 6
Select [Medical_Condition], AVG([Billing_Amount]) AS 'AVG BILLING AMT' from
HEALTHCARE_DATASET
Group By [Medical_Condition]




--12 Find Billing amount of patients admitted and number of days spent in respective hospital

SELECT Billing_Amount, Name,
DATEDIFF(DAY,CAST([Date_of_Admission] AS DATE)
, CAST ([Discharge_Date] AS DATE)) [NUMBER_OF_DAYS_ADMITTED]
FROM HEALTHCARE_DATASET


Select *
From HEALTHCARE_DATASET
--WHERE Hospital =


--13 Find total number of days spent by patient in a hospital for given Medical_Condition
SELECT Medical_Condition
, SUM(DATEDIFF(DAY, CAST(Date_of_Admission AS DATE)
,CAST([Discharge_Date] AS DATE))) AS TOTAL_DAYS_SPENT
FROM healthcare_dataset
GROUP BY Medical_Condition, Hospital
ORDER BY TOTAL_DAYS_SPENT 





--14 Find hospitals which were succesful in discharging patients after 
--having test results as Normal with count of days taken to get results to Normal
SELECT [Hospital]
,CAST([Discharge_Date] AS DATE) AS SUCCSESSFUL_DISCHARGE
,COUNT
FROM healthcare_dataset
WHERE Test_Results = 'NORMAL'

SELECT 

Select Hospital, [Test Results]







--15 Calculate number of blood types of patients which lies between age 20 to 45

Select [Blood_Type]
, count(*) as 'Count of Blood Type'
From HEALTHCARE_DATASET
Where Age Between 20 and 45
Group By [blood_type]
Order By Count(*) DESC



-- 16 Find how many patients are Universal blood doners and Universal Blood reciever

Select Count(*) as 'Count of Uni Blood Doner & Uni Blood Reci'
From HEALTHCARE_DATASET
Where [Blood_Type] IN('O-', 'AB+')



--Select [Blood_Type], Count(*) as 'Count of Uni Blood Doner & Uni Blood Reci'
--From HEALTHCARE_DATASET
--Where [Blood_Type] IN ('O-', 'AB+')
--Group By [Blood_Type]
