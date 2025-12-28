select *from subscriptions
select *from customers
select *from usage_data

select *,
         CASE 
             WHEN [Churn_Flag] = 1 THEN 'Churned'
             WHEN [Churn_Flag] = 0 THEN 'Active'
             Else 'Nothing'
         END AS Churn_status
from subscriptions

alter table subscriptions add Churn_status varchar(20)


Update subscriptions set Churn_status=
         CASE 
             WHEN [Churn_Flag] = 1 THEN 'Churned'
             WHEN [Churn_Flag] = 0 THEN 'Active'
             Else 'Nothing'
         END
from subscriptions

--### KPI Queries ###
-->>total customers>>
select count(distinct Customer_ID) as Total_Customers from subscriptions

--->>churned customers>>

select count(distinct Customer_ID) as Churned_customers From subscriptions where churn_Flag=1


--#Churn Rate#

select cast(sum(case when churn_Flag =1 then 1 else 0 end) as float)/count(*)*100 as Churn_rate_percentage from subscriptions

---Revenue Lost>>>
select sum(Monthly_Fee) as [Revenue Lost] from subscriptions where churn_flag=1

--Average tenure before churn>>

select  avg(Tenure_months) as Average_Tenure_Churn from subscriptions where churn_flag=1

--Churn Analysis by dimensions>>

select plan_type, count(customer_id) as Total_Customers,sum(cast(churn_flag as int)) as churned_customers from subscriptions group by plan_type

select plan_type,count(*)as Total_customers,sum(cast(churn_flag as int)) as churned_customers,
round(cast(sum(cast(churn_flag as int)) as float)/count(*)*100,2) as churn_rate_pct 
from subscriptions group by plan_type

--churn by region>>


select Region, count(s.Customer_ID) as Total_Customers,sum(cast(churn_flag as int)) as churned_customers
from subscriptions s left outer join customers c on s.customer_id = c.customer_id
group by Region

select Region, count(*) as Total_customers,sum(cast(churn_flag as int)) as churned_customers,
round(cast(sum(cast(churn_flag as int))as float)/count(*)*100,2) as churn_rate_pctm from subscriptions s left outer join customers c 
on s.customer_id=c.customer_id group by Region

--Churn by Customer_segment>>

select customer_segment,count(*) as Total_customers,sum(cast(churn_flag as int)) as churned_customers,
round(cast(sum(cast(churn_flag as int))as float)/count(*)*100,2) as churn_rate_pct from subscriptions s left outer join customers c
on s.customer_id=c.customer_id group by customer_segment

--tenure vs Churn Analysis>>

select churn_flag,avg(tenure_months) as avg_tenure from subscriptions group by churn_flag

--complaints and support impact>>

select churn_status,round(avg(cast(complaints as float)),2) as avg_complaints 
from subscriptions s left outer join usage_data u on s.customer_id=u.customer_id group by churn_status

--support_tickets vs churn

select churn_status,round(avg(cast(support_tickets as float)),2) as avg_support_tickets 
from subscriptions s left outer join usage_data u on s.customer_id=u.customer_id group by churn_status

--high risk customer identification>>

select customer_id,plan_type,monthly_fee,Tenure_Months from subscriptions where churn_flag=1 order by monthly_fee desc

--high complaints churned customers>>

select s.customer_id,avg_monthly_usage,complaints,support_tickets from subscriptions s  left join usage_data u 
on s.customer_id=u.customer_id where churn_flag=1 order by complaints desc

--Inactive Customer
select churn_flag,count(*) as Total_customers from subscriptions where last_active_date < dateadd(day,-30,getdate()) group by churn_flag

create view churn_analysis_view as select
s.customer_id,s.plan_type,s.monthly_fee,s.tenure_months,s.churn_flag,s.churn_status,c.region,c.gender,
c.customer_segment,u.avg_monthly_usage,u.complaints,u.support_tickets from subscriptions s left join customers c on s.customer_id=c.customer_id
left join usage_data u on s.customer_id = u.customer_id
