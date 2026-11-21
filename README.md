# 🏦 Bank Loan Approval Analysis

An end-to-end data analytics project that explores which factors decide whether a loan gets approved. The data is cleaned in Python, analysed with SQL (MySQL) and presented in an interactive 6-page Power BI dashboard.

## 🎯 Objective
- Find out how many loan applications are approved and how many are rejected.
- Identify which factors (credit history, property area, education, income, marital status) affect loan approval.
- Give simple insights to understand the approval pattern.

## 🗂️ Dataset
Loan Approval dataset: 614 applicants and 13 columns.

**Key columns:** Gender, Married, Dependents, Education, Self_Employed, ApplicantIncome, CoapplicantIncome, LoanAmount, Loan_Amount_Term, Credit_History, Property_Area, Loan_Status.

## 🛠️ Tools Used
| Tool | Purpose |
|------|---------|
| 🐍 Python (Pandas, NumPy, Matplotlib, Seaborn) | Data checking, EDA and data cleaning |
| 🗄️ SQL (MySQL) | 24 analysis queries on the `l_approved` table |
| 📈 Power BI | Interactive Loan Approval dashboard with 6 pages |

## 🔄 Project Workflow

### 1️⃣ Data Cleaning and EDA (Python)
- Loaded the CSV and checked shape, data types and summary statistics.
- Renamed the column `Loan_Status (Approved)` to `Loan_Status`.
- Univariate analysis: count plots and histograms.
- Bivariate analysis: count plots against Loan Status.
- Handled missing values: most frequent value for categorical columns (Gender, Married, Dependents, Self_Employed, Credit_History, Loan_Amount_Term) and median for LoanAmount.
- Checked for duplicate rows (none found).
- Exported the cleaned dataset to CSV.

### 2️⃣ Data Analysis (SQL)
Created the `bank_loan` database and wrote 24 queries covering:
- **Basic queries:** total applications, unique property areas, approved loans, self-employed applicants.
- **Aggregations:** average loan amount by education and credit history, approval rate by gender.
- **Filtering:** graduates with high loan amount, approved loans from urban area with good credit history.
- **Derived columns:** total income, income groups (Low, Medium, High) using `CASE WHEN`.
- **Subqueries:** loans above average, income above the average of the education group.
- **Window functions:** `RANK()` and `AVG() OVER (PARTITION BY ...)`.
- **Approval rate analysis:** by education, credit history, property area and self-employment.

### 3️⃣ Dashboard (Power BI)
Built a 6-page Loan Approval Dashboard:
- **Overview:** KPI cards (Total Applications, Total Approved, Approval Rate %, Average Income, Average Loan Amount), Gender and Education slicers.
- **Applicant Demographics:** approval by education, gender, marital status and self-employment.
- **Financial Insights:** income vs loan amount, income groups.
- **Property & Location:** applications and approvals by property area.
- **Credit Risk Analysis:** effect of credit history on approval.
- **Key Insights & Recommendations.**

## 💡 Key Insights
- 📊 Out of 614 applications, **422 were approved** and **192 were rejected**.
- 📈 The overall approval rate is **68.73%**.
- 💳 **Credit history is the biggest factor:** applicants with good credit history have a **79.05%** approval rate, while those with bad credit history have only **7.87%**.
- 🏘️ Semiurban area has the highest approval rate (**76.82%**), followed by Urban (65.84%) and Rural (61.45%).
- 🎓 Graduates (70.83%) have a higher approval rate than non-graduates (61.19%).

## ✅ Recommendations
- 💳 Applicants should maintain a good credit history before applying for a loan.
- 🏘️ Rural applicants may need extra support, since their approval rate is the lowest.
- 🎓 Review the approval criteria for non-graduate applicants.
