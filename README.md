# customer-churn-revenue-retention-Analysis
📊 Customer Churn & Revenue Retention Analysis

🧩 Project Overview

Customer churn directly impacts business revenue and long-term growth.

This project analyzes customer churn patterns, identifies key churn drivers, and quantifies revenue loss and retention using SQL Server, Power BI, and analytical best practices.

The goal is to help business stakeholders reduce churn and improve revenue retention through data-driven insights.
_____________________
🎯 Business Objectives

•	Identify churned vs active customers

•	Calculate churn rate and revenue loss

•	Analyze churn by plan type, region, and customer segment

•	Understand impact of usage behavior and support issues

•	Provide actionable insights to reduce churn
________________________________________

🏗️ Data Model (Industry Standard)

This project follows a Star Schema approach:

Fact Table

•	subscriptions

o	churn_flag

o	monthly_fee

o	tenure_months

o	plan_type

Dimension Tables

•	customers

o	region

o	customer_segment

o	demographics

•	usage_data

o	avg_monthly_usage

o	complaints

o	support_tickets

A SQL View is created to provide an analysis-ready dataset.
________________________________________

🧠 Key KPIs

•	Total Customers

•	Churned Customers

•	Churn Rate (%)

•	Revenue Lost Due to Churn

•	Revenue Retained

•	Average Tenure Before Churn

________________________________________
🛠️ Tools & Technologies

•	SQL Server – Data extraction, joins, views, KPIs

•	Power BI – Interactive dashboards & DAX measures

•	Python (optional) – EDA & statistical analysis
________________________________________

🗄️ SQL View Used

CREATE VIEW churn_analysis_view AS

SELECT

    s.customer_id,
    
    s.plan_type,
    
    s.monthly_fee,
    
    s.tenure_months,
    
    s.churn_flag,
    
    c.region,
    
    c.customer_segment,
    
    u.avg_monthly_usage,
    
    u.complaints,
    
    u.support_tickets
    
FROM subscriptions s

LEFT JOIN customers c ON s.customer_id = c.customer_id

LEFT JOIN usage_data u ON s.customer_id = u.customer_id;

This view acts as a semantic layer for Power BI.
________________________________________

📊 Power BI Dashboard Features

•	KPI Cards (Churn Rate, Revenue Lost, Retained Revenue)

•	Churn Analysis by Region & Plan Type

•	Usage & Support Impact on Churn

•	Interactive slicers for business users

•	Auto-refresh with updated SQL data

______________________________________

📈 Key Insights (Example)

•	Higher churn observed in basic plans

•	Customers with more complaints and support tickets churn faster

•	Certain regions show high revenue loss but low customer volume

•	Short tenure customers are most likely to churn

________________________________________
💡 Business Recommendations

•	Improve pricing strategy in high-churn plans

•	Proactively engage customers with high complaint counts

•	Focus retention offers on low-tenure customers

•	Strengthen customer support in high-churn regions

________________________________________
🧪 Statistical Analysis

•	Chi-Square Test used to check association between churn and categorical variables

•	Results indicate whether churn is statistically dependent on customer segments or plans

________________________________________
🚀 Outcome

This project demonstrates:

•	Real-world data modeling

•	Enterprise SQL & BI practices

•	Business-focused analytical thinking

•	Stakeholder-ready reporting
________________________________________

📌 Author

S.SAI VAMSHIDHAR

Data Analyst
