--1) Using COUNT, get the number of cities in the USA
SELECT COUNT(Name) FROM city WHERE CountryCode = 'USA';
--2) Find out the population and life expectancy of people in Argentina
SELECT Population, LifeExpectancy FROM country WHERE Name = 'Argentina';
--3) Using ORDER BY and LIMIT, which country has the highest life expectancy?
SELECT Name, LifeExpectancy FROM country ORDER BY LifeExpectancy DESC LIMIT 1;
--4) Using JOIN...ON, find the capital city of Spain.
SELECT ci.Name AS Capital, co.Name AS Country FROM city ci JOIN country co ON ci.ID=co.Capital WHERE co.Name = 'Spain';
--5) Using JOIN...ON, list all languages spoken in the Southeast Asia region.
SELECT l.language FROM countrylanguage l JOIN country c ON l.CountryCode=c.Code WHERE c.Region = 'Southeast Asia';
--6) Using a single query, list 25 cities around the world that start with the letter F
SELECT Name FROM city WHERE Name LIKE 'F%' LIMIT 25;
--7) Using COUNT and JOIN...ON, get the number of cities in China.
SELECT COUNT(ci.Name) FROM city ci JOIN country co ON ci.CountryCode=co.Code WHERE co.Name = 'China';
--8) Using ORDER BY and LIMIT, which country has the lowest population, discarding zero values?
SELECT Name, Population FROM country WHERE Population != 0 ORDER BY Population ASC LIMIT 1;
--9) Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(Code) FROM country;
--10) What are the top 10 largest countries by area?
SELECT Name FROM country ORDER BY SurfaceArea DESC LIMIT 10;
--11) List the five largest cities by population in Japan?
SELECT Name FROM city WHERE CountryCode = 'JPN' ORDER BY Population DESC LIMIT 5;
--12) List the names and country codes of every country with Elizabeth II as head of state. You need to fix the mistake first!
--Discovering mistake: 
SELECT HeadOfState FROM country WHERE Name = 'United Kingdom';
--Correcting mistake: 
UPDATE country SET HeadOfState = 'Elizabeth II' WHERE HeadOfState = 'Elisabeth II';
--Listing countries:
SELECT Name, Code FROM country WHERE HeadOfState = 'Elizabeth II';
--13) List the 10 countries with the smallest population-to-surface area ratio, discarding zero values.
SELECT Name, Population/SurfaceArea AS pop_to_area_ratio FROM country WHERE Population/SurfaceArea != 0 ORDER BY Population/SurfaceArea ASC LIMIT 10;
--14) List every unique world language.
SELECT DISTINCT Language FROM countrylanguage;
--15) List the names and GNP of the world's 10 richest countries.
SELECT Name, GNP FROM country ORDER BY GNP LIMIT 10;
--Alternate interpretation: richest by GDP/capita not GNP
SELECT Name, GNP/Population AS GDP_per_capita FROM country ORDER BY GNP/Population DESC LIMIT 10
--16) List the names of, and number of languages spoken by, the world's 10 most multi-lingual countries.
CREATE VIEW languagecountry AS SELECT c.Code, c.Name, l.Language, l.Percentage FROM country c JOIN countrylanguage l ON c.Code=l.CountryCode;
SELECT Name, COUNT(Language) FROM languagecountry GROUP BY Code ORDER BY COUNT(Language) DESC LIMIT 10;
--17) List every country where over 50% of the population speak German
SELECT Name, Percentage FROM languagecountry WHERE Language = 'German' AND Percentage > 050.0;
--18) Which country has the worst life expectancy, discarding zero and null values
SELECT Name FROM country WHERE LifeExpectancy = (SELECT MIN(LifeExpectancy) FROM country WHERE LifeExpectancy != 0);
--19) List the top three most common government forms.
SELECT GovernmentForm, COUNT(Code) FROM country GROUP BY GovernmentForm ORDER BY COUNT(Code) DESC LIMIT 3;
--20) How many countries have gained independence since records began?
SELECT COUNT(Code) FROM country WHERE IndepYear IS NOT NULL;
