/*
SUM and COUNT

World Country Profile: Aggregate functions
This tutorial is about aggregate functions such as COUNT, SUM and AVG. An aggregate function takes many values and delivers just one value. For example the function SUM would aggregate the values 2, 4 and 5 to deliver the single value 11.

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...
You might want to look at these examples first
Using SUM, Count, MAX, DISTINCT and ORDER BY.

*/

/*
Total world population
1.
Show the total population of the world.

world(name, continent, area, population, gdp)
*/
SELECT SUM(population) FROM world WHERE population > 0;


/*
List of continents
2.
List all the continents - just once each.
*/
SELECT DISTINCT(continent) FROM world;


/*
GDP of Africa
3.
Give the total GDP of Africa
*/
SELECT SUM(gdp) FROM world WHERE continent = 'Africa';


/*
Count the big countries
4.
How many countries have an area of at least 1000000
*/
SELECT COUNT(name) FROM world WHERE area >= 1000000;


/*
Baltic states population
5.
What is the total population of ('Estonia', 'Latvia', 'Lithuania')
*/
SELECT SUM(population) FROM world WHERE name in ('Estonia', 'Latvia', 'Lithuania');


/*
Using GROUP BY and HAVING
You may want to look at these examples: Using GROUP BY and HAVING.
*/

/*
Counting the countries of each continent
6.
For each continent show the continent and number of countries.
*/
SELECT continent, COUNT(name) FROM world GROUP BY continent;


/*
Counting big countries in each continent
7.
For each continent show the continent and number of countries with populations of at least 10 million.
*/
SELECT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY continent;

/*
Counting big continents
8.
List the continents that have a total population of at least 100 million.
*/
SELECT continent from (SELECT continent, SUM(population) FROM world GROUP BY continent HAVING SUM(population) >= 100000000) T;



