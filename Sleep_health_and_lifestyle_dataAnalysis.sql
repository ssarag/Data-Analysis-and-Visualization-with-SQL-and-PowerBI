describe patient_details;

-- 1. Retrieve the information of all individuals in the dataset. 
SELECT * FROM patient_details; 

-- 2.  Retrieve the count of males and females in the dataset.

SELECT
(SELECT COUNT(*) FROM patient_details WHERE Gender = 'Male') AS Male_Count,
(SELECT COUNT(*) FROM patient_details WHERE Gender = 'Female') AS Female_Count;


-- 3. Calculate the average sleep duration of all individuals in the dataset.

SELECT AVG(Sleep_Duration) as avg_count
FROM patient_details;


-- 4. Determine the number of individuals with each type of sleep disorder (Insomnia, Sleep Apnea, None).
-- Title: Sleep Health and Lifestyle Dataset Analysis

SELECT Sleep_disorder, COUNT(*) AS Count
FROM patient_details
GROUP BY Sleep_disorder;

 -- 5. Find the average age of individuals grouped by occupation.
 
 SELECT Occupation, AVG(age) as avg_age
 FROM patient_details
 GROUP BY Occupation;


-- 6. Calculate the average quality of sleep for individuals with stress levels above 5

SELECT AVG(Quality_of_Sleep) As QoS
FROM patient_details
WHERE Stress_Level > 5;

-- 7. Retrieve the average physical activity level for each BMI category
SELECT BMI_Category, AVG(Physical_Activity_Level) AS Avg_Physical_Activity_Level
FROM Patient_details
GROUP BY BMI_Category;


-- 8. Find the number of individuals with systolic blood pressure greater than 120.

SELECT COUNT(*) AS num_individuals
FROM patient_details
WHERE SUBSTRING_INDEX(Blood_Pressure, '/', 1) > 120;

-- 9. Determine if there is any correlation between sleep duration and heart rate.

SELECT 
    (
        SUM((Sleep_Duration - Sleep_Duration_mean) * (Heart_Rate - Heart_Rate_mean)) /
        SQRT(SUM(POWER(Sleep_Duration - Sleep_Duration_mean, 2)) * SUM(POWER(Heart_Rate - Heart_Rate_mean, 2)))
    ) AS correlation_coefficient
FROM (
    SELECT 
        AVG(Sleep_Duration) AS Sleep_Duration_mean, 
        AVG(Heart_Rate) AS Heart_Rate_mean
    FROM Patient_details
) AS means,
(
    SELECT Sleep_Duration, Heart_Rate
    FROM Patient_details
) AS data;

-- 10. 	Predict the likelihood of an individual having a sleep disorder based on their occupation, stress level
SELECT 
    Occupation,
    Stress_Level,
    Sleep_Duration,
    COUNT(*) AS  Total_Individuals,
    SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) AS Individuals_With_Disorder,
    ROUND(SUM(CASE WHEN Sleep_Disorder <> 'None' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Likelihood_of_Disorder
FROM 
    patient_details
GROUP BY 
    Occupation, Stress_Level, Sleep_Duration;



