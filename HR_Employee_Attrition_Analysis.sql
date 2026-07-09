-- ===================================================================================================================================
-- HR Employee Attrition analysis project
-- SQL: Mysql
-- Dataset:IBM HR Analytics Employee Attrition
-- ====================================================================================================================================

-- create database
create database if not exists HR_analytics ;
-- use database
use HR_analytics;
-- create table hr_employee_attrition
create table hr_employee_attrition(
age INT,
Attrition varchar(20),
BusinessTravel varchar(50),
DailyRate INT,
Department varchar(50),
DistanceFromHome INT,
Education INT,
Educationfield varchar(50),
Employeecount INT,
EmployeeNumber int primary key,
environmentSatisfaction INT,
Gender varchar(30),
HourlyRate INT,
JobInvolvment INT,
JobLevel INT,
JobRole varchar(50),
JobSatisfaction INT,
MaritalStatus varchar(30),
MonthlyIncome INT,
MonthlyRate  INT,
NumCompaniesWorked INT,
Over18 varchar(10),
OverTime varchar(30),
PercentSalaryHike INT,
PerformanceRating INT,
RelationshipSatisfaction INT,
StandardHours INT,
StockOptionalLevel INT,
TotalWorkingYear INT,
TrainingTimesLastYear INT,
WorkLifeBalance INT,
YearsAtCompany INT,
YearsInCurrentrole INT,
YearsSinceLastPromotion INT,
YearWithCurrentManager INT);
-- basic analysis
SELECT*from hr_employee_attrition;
describe hr_employee_attrition;
select count(*) as emp_leftcompany from hr_employee_attrition where attrition='no';
select count(*) as emp_stayincompany from hr_employee_attrition where attrition='yes';
select count(*) as total_emp from hr_employee_attrition;
select avg(age) as average_age from hr_employee_attrition;
select round(sum(case when attrition='yes' then 1 else 0 end)*100.0)/count(*) as attrition_rate from hr_employee_attrition;
select round(avg(MonthlyIncome),2) as avg_monthlyincome from hr_employee_attrition;
-- department analysis
select department,count(*) from hr_employee_attrition
group by department;
select department,count(attrition) from hr_employee_attrition
where attrition='yes'
group by department;
select department, round(sum(case when attrition='yes' then 1 else 0 end)*100.0)/count(*) as attrition_rate from hr_employee_attrition
group by department;
select department,avg(MonthlyIncome) as avg_mincome from hr_employee_attrition
group by department;
select department,avg(TotalWorkingYear) as avg_totalworkingyear from hr_employee_attrition
group by department;
-- job role analysis
select JobRole,count(*) from hr_employee_attrition
group by JobRole;
select JobRole,count(attrition) as leftemployees from hr_employee_attrition
where attrition='yes'
group by JobRole;
select JobRole,avg(MonthlyIncome) as avg_mincome from hr_employee_attrition
group by JobRole;
select * from(select JobRole, monthlyIncome,row_number() over(partition by JobRole
order by monthlyIncome desc) as rn from hr_employee_attrition)t where rn=1;
select *,rank() over(partition by department 
order by monthlyIncome desc) as rank_salary from hr_employee_attrition;

-- gender wise analysis
select gender ,count(*) as gender_wisecount from hr_employee_attrition
group by gender;
select gender ,round(sum(case 
when attrition='yes' then 1 else 0 end)*100.0)/count(*) as gender_attritionrate from hr_employee_attrition
group by gender;
select MaritalStatus,count(*) as Martialstatuscount from hr_employee_attrition
group by maritalstatus;
select maritalstatus ,round(sum(case 
when attrition='yes' then 1 else 0 end)*100.0)/count(*) as gender_attritionrate from hr_employee_attrition
group by maritalstatus ;

-- overtime and travelanalysis
select count(*),overtime,attrition from hr_employee_attrition
group by overtime, attrition;
select BusinessTravel,count(*) as travelwisecount from hr_employee_attrition
group by BusinessTravel;
select BusinessTravel,round(sum(case 
when attrition='yes' then 1 else 0 end)*100.0)/count(*) as travelwise_attritionrate from hr_employee_attrition
group by BusinessTravel;
-- satisfaction analysis
select attrition,jobsatisfaction,count(*) as attrition_satisfactioncount from hr_employee_attrition
group by attrition,jobsatisfaction
order by jobsatisfaction;
select attrition,environmentsatisfaction,count(*) as attrition_satisfactioncount from hr_employee_attrition
group by attrition,environmentsatisfaction
order by environmentsatisfaction;
select attrition,relationshipsatisfaction,count(*) as attrition_satisfactioncount from hr_employee_attrition
group by attrition,relationshipsatisfaction
order by relationshipsatisfaction;
select attrition,Worklifebalance,count(*) as attrition_satisfactioncount from hr_employee_attrition
group by attrition,worklifebalance
order by worklifebalance;
-- salary and experience analysis
select employeenumber,jobrole ,department,age ,monthlyincome from hr_employee_attrition
order by monthlyincome desc
limit 10;
select* from hr_employee_attrition
order by totalworkingyear desc
limit 10;
select* from hr_employee_attrition
where attrition='no'
order by totalworkingyear desc
limit 10;
select* from hr_employee_attrition where monthlyincome >( select avg(monthlyincome) from hr_employee_attrition );
with cte as( select department,avg(monthlyincome) as deptwiseincome from hr_employee_attrition
group by department)
select* from cte where deptwiseincome>(select avg(monthlyincome) from hr_employee_attrition);
-- or
select department ,avg(monthlyincome) from hr_employee_attrition
group by department 
having avg(monthlyincome)>(select avg(monthlyincome) from hr_employee_attrition);
select education, count(*) from hr_employee_attrition 
group by education;
select educationfield, count(*) from hr_employee_attrition 
group by educationfield;
select educationfield,attrition,count(*)
from hr_employee_attrition 
group by educationfield, attrition;
 -- performance analysis
 select  department ,avg(performancerating) as deptwise_perfromance from hr_employee_attrition
 group by department;
 select avg(percentsalaryhike),attrition from hr_employee_attrition
 group by attrition;
 select * from hr_employee_attrition where yearssincelastpromotion=0;
 select*from hr_employee_attrition where yearsatcompany>=10;
 select *from hr_employee_attrition where overtime='yes'and worklifebalance<=2;
 select department,round(sum(case when attrition='yes' then 1 else 0 end)*100.0)/count(*) as attritionrate from hr_employee_attrition
 group by department
 order by attritionrate desc
 limit 5;
select* from hr_employee_attrition where
attrition='yes'and overtime='yes'
and worklifebalance<=2;
select* from hr_employee_attrition where
attrition='yes'and Jobsatisfaction='yes';
select* from hr_employee_attrition where
attrition='yes'and businesstravel='travel_frequently';
-- ===========================================================================================================================================
-- Project completed,Tool:Mysql
-- Total Queries: above 40
-- SQL CONCEPT USED
-- CREATE ,INSERT, SELECT, WHERE, ORDER BY, GROUP BY, HAVING
-- CASE WHEN, LIMIT,OPERATER
-- CTE, WINDOW FUNCTION, SUBQUERY
-- ================================================================================================================================================
 
