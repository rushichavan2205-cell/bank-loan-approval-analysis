USE bank_loan;
SELECT * FROM l_approved;

-- Basic SQL Queries 
-- 1. View the first 10 records from the table. 
select * from l_approved limit 10;

-- 2. Count the total number of loan applications. 
select count(*) as total_applicants from l_approved;

-- 3. List all unique property areas. 
select distinct(property_area) from l_approved;

-- 4. Show all applicants who are self-employed and have an income above 5000. 
select * from l_approved where Self_Employed = 'Yes' and ApplicantIncome>5000;
select count(*) from l_approved where Self_Employed = 'Yes' and ApplicantIncome>5000;

-- 5. Find the total number of approved loans. 
select count(*) from l_approved where loan_status = 'Y';

-- Aggregation & Grouping 
-- 6. Find average loan amount by education level. 
select education, round(avg(loanamount), 2) as avg_loan_amount from l_approved group by education;

-- 7. Find average total income (Applicant + Coapplicant) by marital status.
select Married, round(avg(applicantincome+coapplicantincome), 2) as avg_total_income 
from l_approved group by Married;
 
-- 8. Show average loan amount by credit history. 
select Credit_History, round(avg(loanamount), 2) as avg_loan_amount from l_approved
group by Credit_History;

-- 9. Find total applications and approval rate by gender. 
select
      gender,
      count(*) as applicants,
      sum(case when loan_status = 'Y' then 1 else 0 end) as approved,
      sum(case when loan_status = 'Y' then 1 else 0 end)/count(*)*100 as approval_rate
      from l_approved
group by Gender;

-- 10. Show approval rate by property area.

-- Filtering & Conditions 
-- 11. Show applicants who are graduates, not self-employed, and have loan amount greater than 150.
select * from l_approved where Education = 'Graduate' and Self_Employed = 'No' and
LoanAmount>150;
select count(*) from l_approved where Education = 'Graduate' and Self_Employed = 'No' and
LoanAmount>150;
 
-- 12. Display approved loans from urban area with good credit history. 
select * from l_approved where Property_Area = 'urban' and
Credit_History = 1;
select count(*) from l_approved where Property_Area = 'urban' and
Credit_History = 1;

-- 13. List top 5 applicants with highest total income.
select * from l_approved order by ApplicantIncome+CoapplicantIncome desc limit 5;

-- Derived Columns & CASE WHEN 
-- 14. Create derived columns for total income for each applicant. 
select *, ApplicantIncome+CoapplicantIncome as total_income from l_approved;

-- 15. Classify applicants into income groups (Low, Medium, High) based on applicant income. 
SELECT *,
       CASE
           WHEN ApplicantIncome < 3000 THEN 'Low'
           WHEN ApplicantIncome BETWEEN 3000 AND 5999 THEN 'Medium'
           ELSE 'High'
       END AS income_group
FROM l_approved;

-- 16. Find average loan amount for each income group.
 SELECT CASE
           WHEN ApplicantIncome < 3000 THEN 'Low'
           WHEN ApplicantIncome BETWEEN 3000 AND 5999 THEN 'Medium'
           ELSE 'High'
       END AS income_group,
       ROUND(AVG(LoanAmount), 2) AS avg_loan_amount
FROM l_approved
GROUP BY income_group;

-- 17. Applicants whose loan amount is greater than the overall average loan amount.
SELECT * FROM l_approved
WHERE LoanAmount > (SELECT AVG(LoanAmount) FROM l_approved);

-- 18. Property area with the highest average total income.
SELECT Property_Area, ROUND(AVG(ApplicantIncome + CoapplicantIncome), 2) AS avg_total_income
FROM l_approved
GROUP BY Property_Area
ORDER BY avg_total_income DESC
LIMIT 1;

-- 19. Applicants whose income is above the average income of their education category.
SELECT * FROM l_approved a
WHERE ApplicantIncome > (SELECT AVG(ApplicantIncome)
                         FROM l_approved b
                         WHERE b.Education = a.Education);

-- 20. Rank applicants based on total income (highest income = rank 1).
SELECT Loan_ID,
       ApplicantIncome + CoapplicantIncome AS total_income,
       RANK() OVER (ORDER BY ApplicantIncome + CoapplicantIncome DESC) AS income_rank
FROM l_approved;

-- 21. Average loan amount per property area using a window function.
SELECT Loan_ID, Property_Area, LoanAmount,
       ROUND(AVG(LoanAmount) OVER (PARTITION BY Property_Area), 2) AS avg_loan_in_area
FROM l_approved;

-- 22. Approval rate by education.
SELECT Education,
       COUNT(*) AS applicants,
       ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS approval_rate
FROM l_approved
GROUP BY Education;


-- 23. Approval rate by credit history and education (best combination first).
SELECT Credit_History, Education,
       COUNT(*) AS applicants,
       ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS approval_rate
FROM l_approved
GROUP BY Credit_History, Education
ORDER BY approval_rate DESC;

-- 24. Property area + education combination with the highest approval rate.
SELECT Property_Area, Education,
       COUNT(*) AS applicants,
       ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS approval_rate
FROM l_approved
GROUP BY Property_Area, Education
ORDER BY approval_rate DESC
LIMIT 1;

-- 25. Approval rate: self-employed vs not, by credit history.
SELECT Self_Employed, Credit_History,
       COUNT(*) AS applicants,
       ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS approval_rate
FROM l_approved
GROUP BY Self_Employed, Credit_History
ORDER BY Self_Employed, Credit_History;
