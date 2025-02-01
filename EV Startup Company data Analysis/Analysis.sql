--  **Manufacturing Costs:** Analyze the cost of manufacturing more vehicles, including raw materials, labor, and overhead
Aggrigate Cost by category
select Vehicle_Type,
        sum(Manufacturing_Cost) as total_cost,
       avg(Manufacturing_Cost) as avg_cost
from ev_data
group by Vehicle_Type

Find trends over Time
create View  Manufacturing_Insights as 
select 
Vehicle_Type,
year(Production_Date) as Yeara_of_Production,
sum(Manufacturing_Cost) as Total_Cost,
count(Vehicle_ID) as Total_Production,
SUM(Manufacturing_Cost) / COUNT(Vehicle_ID) AS Cost_Per_Vehicle
from ev_data
group by year(Production_Date), Vehicle_Type
order by Yeara_of_Production, Vehicle_Type

select * from Manufacturing_Insights
-- 2. **Advertising and Marketing:** Estimate the costs associated with advertising and marketing campaigns to promote the new EVs.
-- Report
select YEAR(Production_Date) as Years_of_Production,
sum(Advertising_Cost) as Total_Ads_cost,
        avg(Advertising_Cost) as Avg_Ads_Cost,
        sum(Budget_Allocation) as Total_Budget,
        sum(Advertising_Cost) / sum(Budget_Allocation) * 100 as Percentage_of_Budget_Spent_on_Ads,
       LAG(SUM(Advertising_Cost)) OVER (ORDER BY YEAR(Production_Date)) AS Last_Year_Cost_Spent_on_Ads,
    ((SUM(Advertising_Cost) - LAG(SUM(Advertising_Cost)) OVER (ORDER BY YEAR(Production_Date))) / 
    LAG(SUM(Advertising_Cost)) OVER (ORDER BY YEAR(Production_Date)) * 100) AS Growth_Rate_of_Ads_Cost
from ev_data
group by YEAR(Production_Date)
  
-- 2. **Advertising and Marketing:** Estimate the costs associated with advertising and marketing campaigns to promote the new EVs.
create VIEW Advertising_Forecast AS
WITH Yearly_Cost AS (
    SELECT 
        YEAR(Production_Date) AS Year, 
        SUM(Advertising_Cost) AS Total_Advertising_Cost
    FROM ev_data
    GROUP BY YEAR(Production_Date)
),
Growth_Rate AS (
    SELECT 
        Year,
        Total_Advertising_Cost,
        LAG(Total_Advertising_Cost) OVER (ORDER BY Year) AS Prev_Year_Cost,
        ((Total_Advertising_Cost - LAG(Total_Advertising_Cost) OVER (ORDER BY Year)) / 
         LAG(Total_Advertising_Cost) OVER (ORDER BY Year)) * 100 AS Growth_Percentage
    FROM Yearly_Cost
),
Avg_Growth AS (
    SELECT AVG(Growth_Percentage) AS Avg_Growth_Rate FROM Growth_Rate WHERE Growth_Percentage IS NOT NULL
)
SELECT 
    (SELECT MAX(Year) FROM Yearly_Cost) + 1 AS Forecast_Year,
    (SELECT Total_Advertising_Cost FROM Yearly_Cost WHERE Year = (SELECT MAX(Year) FROM Yearly_Cost)) * 
    (1 + (SELECT Avg_Growth_Rate / 100 FROM Avg_Growth)) AS Forecasted_Advertising_Cost
FROM Yearly_Cost, Avg_Growth
LIMIT 1;

-- 3. **Funding and Budget Management:** Assess current funding, budget allocations, and financial planning for future expansions.









