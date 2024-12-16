-- Change Market Value column name--
ALTER TABLE forbes_largest_companies
RENAME COLUMN `Market Value` to market_value;

-- Which companies have the highest profit margins? (Profit/Sales) --
SELECT Name, Profit
FROM forbes_largest_companies
ORDER BY 2 DESC
LIMIT 10;

-- What are the top industries by total sales?--
SELECT Industry, SUM(Sales) AS "Sales"
FROM forbes_largest_companies
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Which industries are the most profitable on average?--
SELECT Industry, AVG(Profit) AS "Average Profit"
FROM forbes_largest_companies
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Which industries have the highest average market value?--
SELECT Industry, ROUND(AVG(market_value),2) AS "Average Market Value"
FROM forbes_largest_companies
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- What is the distribution of companies by country?--
SELECT Country, COUNT(*) AS "Number of companies"
FROM forbes_largest_companies
GROUP BY 1
ORDER BY 2 DESC;

-- Top company by profit in each country --
WITH a as(
SELECT Country, Name, Profit, ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Profit DESC) as rnk
FROM forbes_largest_companies)
SELECT Name, Country, Profit
from a
WHERE rnk = 1
ORDER BY 3 desc;

-- Which countries have the highest total market value of companies?--
SELECT Country, SUM(market_value) AS "Market Value"
FROM forbes_largest_companies
GROUP BY 1
ORDER BY 2 DESC;

-- Which are the oldest companies in the dataset?--
SELECT Name, Founded
FROM forbes_largest_companies
GROUP BY 1,2
ORDER BY 2 ASC
LIMIT 10;

-- Which industries employ the most people on average?--
SELECT Industry, ROUND(AVG(Employees),2) AS "Average number of employees"
FROM forbes_largest_companies
GROUP BY 1
ORDER BY 2 DESC;

-- Which companies have the highest revenue per employee? (Sales/Employees)--
SELECT Name, Industry, Sales, Employees,(Sales / Employees) AS "Revenue Per Employee"
FROM forbes_largest_companies
WHERE employees > 0
ORDER BY 5 DESC
LIMIT 10;
