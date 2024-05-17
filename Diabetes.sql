CREATE DATABASE DIABETES;
USE DIABETES;

CREATE TABLE IF NOT EXISTS DIABETES_DATA (
PREGNANCIES INT,
GLUCOSE INT,
BLOODPRESSURE INT,
SKIN_THICKNESS INT,
INSULIN INT,
BMI DECIMAL(10,4),
DiabetesPedigreeFunction FLOAT,
AGE INT,
OUTCOME INT);

LOAD DATA INFILE
'E:/diabetes.csv'
INTO TABLE DIABETES_DATA
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM DIABETES_DATA;

/* Q-1. Find records where pregnancies is 10 and Glucose is 115, 168, 139 */
SELECT * FROM DIABETES_DATA WHERE PREGNANCIES IN(10) AND GLUCOSE IN(115, 160, 139);
/* Q-2. Find Ratio for Outcome 0 and 1 */
SELECT 
COUNT(IF(OUTCOME = 0, 1, 0)) OUTCOME_0,
COUNT(IF(OUTCOME = 1, 1, 0)) OUTCOME_1,
COUNT(IF(OUTCOME = 0, 1, 0))/COUNT(IF(OUTCOME = 1, 1, 0)) AS RATIO FROM DIABETES_DATA; /* To know and learn how to get ratio with this type of select statement */

SELECT ((SELECT COUNT(*) FROM DIABETES_DATA WHERE OUTCOME = 0)/(SELECT COUNT(*) FROM DIABETES_DATA WHERE OUTCOME = 1)) AS RATIO FROM DIABETES_DATA LIMIT 1; /* Answer is ok */
/* Q-3. Find records of skin thickness and outcome where both are same */
SELECT SKIN_THICKNESS, OUTCOME FROM DIABETES_DATA WHERE SKIN_THICKNESS = OUTCOME;
/* Q-4. Find records where BMI is more than 20 and less than equal to 30.1 */
SELECT * FROM DIABETES_DATA WHERE BMI > 20 AND BMI <= 30.1;
/* Q-5. Find all records where Age is not equal to 31 */
SELECT * FROM DIABETES_DATA WHERE AGE <> 31;
/* Q-6. Find Blood Pressure where Blood Presure is less than or equal to 76 */
SELECT BLOODPRESSURE FROM DIABETES_DATA WHERE BLOODPRESSURE <= 76;
/* Q-7. Find Insulin, BMI and Diabetes Pedigree Function betwwen age 30 and 50 */
SELECT INSULIN, AGE, BMI, DIABETESPEDIGREEFUNCTION FROM DIABETES_DATA WHERE AGE BETWEEN 30 AND 50;
/* Q-8. Find Highest and lowest Blood Pressure with respect to BMI and Age */
SELECT BMI, AGE, MAX(BLOODPRESSURE) AS HIGHEST_BP FROM DIABETES_DATA GROUP BY BMI, AGE ORDER BY HIGHEST DESC LIMIT 1;
SELECT BMI, AGE, MIN(BLOODPRESSURE) AS LOWEST_BP FROM DIABETES_DATA GROUP BY BMI, AGE ORDER BY LOWEST ASC LIMIT 1;
/* Q-9. find all records where the value is zero for any one column in each respective row */
SELECT * FROM DIABETES_DATA WHERE PREGNANCIES = 0 OR GLUCOSE = 0 OR BLOODPRESSURE = 0 OR SKIN_THICKNESS = 0 OR INSULIN = 0 OR BMI = 0
 OR OUTCOME = 0;
/* Q-10. Find Average Blood Pressure with respect to Age and Pregnancies where blood pressure is more than 70 */
SELECT AVG(BLOODPRESSURE) AS AVERAGE_BP, AGE, PREGNANCIES FROM DIABETES_DATA WHERE BLOODPRESSURE > 70 GROUP BY AGE, PREGNANCIES ORDER BY AVERAGE_BP;

/* Other New Questions */
/* What is standard deviaton for blood pressure with repsect to BMI? */ /* Standard deviation is statistics that measures the number of vairations or dispersion of a set of 
values relative to the mean */
SELECT BMI,  ROUND(STDDEV(BLOODPRESSURE),2) AS STANDARD_DEVIATION FROM DIABETES_DATA GROUP BY BMI  ORDER BY STANDARD_DEVIATION;
/* What is variance for blood pressure with repsect to BMI? */ /* It measures how much the values differ from the average */
SELECT BMI, ROUND(VARIANCE(BLOODPRESSURE),2) AS VARIANCE FROM DIABETES_DATA GROUP BY BMI ORDER BY VARIANCE;