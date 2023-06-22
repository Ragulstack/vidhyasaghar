-- Out of total patients how many patients has heart disease

SELECT 
    COUNT(*) AS total_patients,
    SUM(CAST(target AS INT)) AS patients_with_heart_disease,
   SUM(CAST(target AS INT)) * 100.0 / COUNT(*) AS prevalence
FROM 
    Healthcare.dbo.Heart;

-- Male and Female
SELECT 
    sex, 
    COUNT(*) AS total_patients,
    SUM(cast(target as int)) AS patients_with_heart_disease,
    100.0*SUM(cast(target as int))/COUNT(*) AS prevalence
FROM 
    Healthcare.dbo.Heart
GROUP BY 
    sex;

-- Average age of patient

select avg(cast(age as int)) as Average_age from Healthcare.dbo.Heart

-- Different Chest pain 
SELECT chestpain, 
       COUNT(*) AS C_total_patients, 
       SUM(cast(target as int)) AS Chest_with_heart_disease, 
       AVG(cast(target as int))*100 AS Chest_prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart 
GROUP BY ChestPain;

-- Relationships between resting blood pressure, serum cholesterol, and the presence of heart disease

SELECT target, 
       AVG(cast(BloodPressure as int)) AS avg_resting_bp, 
       AVG(cast(Cholesterol as int)) AS avg_serum_cholesterol 

FROM Healthcare.dbo.Heart
GROUP BY target;

-- blood sugar levels relate to the presence of heart disease

SELECT BloodSugar, 
       COUNT(*) AS b_total_patients, 
       SUM(cast(target as int)) AS b_total_with_heart_disease, 
       AVG(cast(target as float))*100 AS b_Avg_prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart 
GROUP BY BloodSugar;

-- Electrocardiogram results relate to the presence of heart disease
SELECT [Result of electrocardiogram], 
       COUNT(*) AS re_total_patients, 
       SUM(cast(target as int)) AS re_total_with_heart_disease, 
       AVG(cast(target as float))*100 AS re_prevalence_of_heart_disease 
FROM healthcare.dbo.Heart 
GROUP BY [Result of electrocardiogram];

-- relationship between the maximum heart rate 

SELECT target, 
       AVG(cast([Max Heart Rate] as float)) AS avg_max_heart_rate 
FROM Healthcare.dbo.Heart
GROUP BY target;

--presence of exercise-induced angina relate to the presence of heart disease

SELECT Angina, 
       COUNT(*) AS a_total_patients, 
       SUM(cast(target as int)) AS a_total_with_heart_disease, 
       AVG(cast(target as float))*100 AS a_prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart
GROUP BY Angina;

--relationship between the extent of ST-segment and the presence of heart disease

SELECT target, 
       AVG(cast(oldpeak as float)*100) AS avg_st_segment_depression 
FROM Healthcare.dbo.Heart 
GROUP BY target;

-- slope of the ST-segment to the presence of heart disease

SELECT slope, 
       COUNT(*) AS s_total_patients, 
       SUM(cast(target as int)) AS s_total_with_heart_disease, 
       AVG(cast(target as float))*100 AS s_prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart 
GROUP BY slope;

-- relationship between the number of major vessels and the presence of heart disease

SELECT ca, COUNT(ca) AS num_patients, AVG(num) AS prevalence
FROM (
    SELECT ca, COUNT(*) AS num
    FROM Healthcare.dbo.Heart
    WHERE target = 1
    GROUP BY ca
) AS t
GROUP BY ca;

--presence of thalassemia relate to the presence of heart disease

SELECT [ Thalassemia], COUNT([ Thalassemia]) AS num_patients, AVG(cast(target as float)*100) AS prevalence
FROM Healthcare.dbo.Heart
GROUP BY [ Thalassemia];

-- most important predictors of heart disease
SELECT 
    AVG(cast(target as float)) as heart_disease,
    avg(cast(age as float)) as avg_age,
    AVG(cast(BloodPressure as float)) as Avg_blood_pressure,
    AVG(cast (Cholesterol as float)) as Avg_cholesterol,
    AVG(cast([Max Heart Rate] as float)) as Avg_max_heart_rate,
    COUNT(*) as num_cases
FROM 
    Healthcare.dbo.Heart
GROUP BY 
    target;
-- correlation coefficient 

SELECT 
    (COUNT(*) * SUM(X*Y) - SUM(X) * SUM(Y)) / 
        (SQRT(COUNT(*) * SUM(X*X) - SUM(X) * SUM(X)) * SQRT(COUNT(*) * SUM(Y*Y) - SUM(Y) * SUM(Y))) AS correlation_coefficient
FROM 
    (SELECT 
        CAST([Cholesterol ] AS FLOAT) AS X, 
        CAST(BloodPressure AS FLOAT) AS Y 
    FROM 
        Healthcare.dbo.Heart 
    WHERE 
        target = 1) AS T;

--

/*CREATE VIEW HeartDataView AS
SELECT 
    COUNT(*) AS total_patients,
    SUM(CAST(target AS INT)) AS patients_with_heart_disease,
   SUM(CAST(target AS INT)) * 100.0 / COUNT(*) AS prevalence
FROM 
    Healthcare.dbo.Heart;

SELECT sex, 
    COUNT(*) AS total_patients,
    SUM(cast(target as int)) AS patients_with_heart_disease,
    100.0*SUM(cast(target as int))/COUNT(*) AS prevalence
FROM 
    Healthcare.dbo.Heart
GROUP BY 
    sex;

select avg(cast(age as int)) as Average_age from Healthcare.dbo.Heart

SELECT chestpain, 
       COUNT(*) AS total_patients, 
       SUM(cast(target as int)) AS total_with_heart_disease, 
       AVG(cast(target as int))*100 AS prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart 
GROUP BY ChestPain;

SELECT target, 
       AVG(cast(BloodPressure as int)) AS avg_resting_bp, 
       AVG(cast(Cholesterol as int)) AS avg_serum_cholesterol 

FROM Healthcare.dbo.Heart
GROUP BY target;

SELECT BloodSugar, 
       COUNT(*) AS total_patients, 
       SUM(cast(target as int)) AS total_with_heart_disease, 
       AVG(cast(target as float))*100 AS Avg_prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart 
GROUP BY BloodSugar;

SELECT [Result of electrocardiogram], 
       COUNT(*) AS total_patients, 
       SUM(cast(target as int)) AS total_with_heart_disease, 
       AVG(cast(target as float))*100 AS prevalence_of_heart_disease 
FROM healthcare.dbo.Heart 
GROUP BY [Result of electrocardiogram];

SELECT target, 
       AVG(cast([Max Heart Rate] as float)) AS avg_max_heart_rate 
FROM Healthcare.dbo.Heart
GROUP BY target;

SELECT Angina, 
       COUNT(*) AS total_patients, 
       SUM(cast(target as int)) AS total_with_heart_disease, 
       AVG(cast(target as float))*100 AS prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart
GROUP BY Angina;

SELECT target, 
       AVG(cast(oldpeak as float)*100) AS avg_st_segment_depression 
FROM Healthcare.dbo.Heart 
GROUP BY target;

SELECT slope, 
       COUNT(*) AS total_patients, 
       SUM(cast(target as int)) AS total_with_heart_disease, 
       AVG(cast(target as float))*100 AS prevalence_of_heart_disease 
FROM Healthcare.dbo.Heart 
GROUP BY slope;

SELECT ca, COUNT(ca) AS num_patients, AVG(num) AS prevalence
FROM (
    SELECT ca, COUNT(*) AS num
    FROM Healthcare.dbo.Heart
    WHERE target = 1
    GROUP BY ca
) AS t
GROUP BY ca;

SELECT [ Thalassemia], COUNT([ Thalassemia]) AS num_patients, AVG(cast(target as float)*100) AS prevalence
FROM Healthcare.dbo.Heart
GROUP BY [ Thalassemia];

SELECT 
    AVG(cast(target as float)) as heart_disease,
    avg(cast(age as float)) as avg_age,
    AVG(cast(BloodPressure as float)) as Avg_blood_pressure,
    AVG(cast (Cholesterol as float)) as Avg_cholesterol,
    AVG(cast([Max Heart Rate] as float))
from Healthcare.dbo.Heart*/

