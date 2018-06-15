/*
SELECT within SELECT Tutorial
Language:	English  • 日本語 • 中文
This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries.

world(name, continent, area, population, gdp)

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...
*/

/*
1.
List each country name where the population is larger than that of 'Russia'.
*/
SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name = 'Russia');


/*
Richer than UK
2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

Per Capita GDP
The per capita GDP is the gdp/population
*/
SELECT name FROM world WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');


/*
Neighbours of Argentina and Australia
3.

List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/
SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name in ('Argentina', 'Australia')) ORDER BY name;


/*
Between Canada and Poland
4.
Which country has a population that is more than Canada but less than Poland? Show the name and the population.
*/
SELECT name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');


/*
Percentages of Germany
5.
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

Decimal places
You can use the function ROUND to remove the decimal places.
Percent symbol %
You can use the function CONCAT to add the percentage symbol.
*/
SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')), '%') FROM world WHERE continent = 'Europe';


/*
To gain an absurdly detailed view of one insignificant feature of the language, read on.

We can use the word ALL to allow >= or > or < or <=to act over a list. For example, you can find the largest country in the world, by population with this query:

SELECT name
  FROM world
 WHERE population >= ALL(SELECT population
                           FROM world
                          WHERE population>0)
You need the condition population>0 in the sub-query as some countries have null for population
*/


/*
Bigger than every country in Europe
6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/
SELECT name FROM world WHERE gdp > 0 AND gdp > ALL (SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0);


/*
We can refer to values in the outer SELECT within the inner SELECT. We can name the tables so that we can tell the difference between the inner and outer versions.
*/

/*
Largest in each continent
7.
Find the largest country (by area) in each continent, show the continent, the name and the area:
*/
SELECT continent, name, area FROM world t1 WHERE area > ALL (SELECT area FROM world t2 WHERE t2.name != t1.name AND t2.continent = t1.continent AND t2.area > 0);

/*
The above example is known as a correlated or synchronized sub-query.

Using correlated subqueries
A correlated subquery works like a nested loop: the subquery only has access to rows related to a single record at a time in the outer query. The technique relies on table aliases to identify two different uses of the same table, one in the outer query and the other in the subquery.

One way to interpret the line in the WHERE clause that references the two table is “… where the correlated values are the same”.

In the example provided, you would say “select the country details from world where the population is greater than or equal to the population of all countries where the continent is the same”.
*/

/*
First country of each continent (alphabetically)
8.
List each continent and the name of the country that comes first alphabetically.
*/
SELECT continent, name FROM world t1 WHERE name <= ALL (SELECT name FROM world t2 WHERE t2.continent = t1.continent);


/*
Difficult Questions That Utilize Techniques Not Covered In Prior Sections
9.
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
*/
SELECT name, continent, population FROM world t1 WHERE continent IN (SELECT DISTINCT(continent) FROM world t2 WHERE 25000000 >= ALL (SELECT population FROM world t3 WHERE t3.continent = t2.continent));

/*
10.
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
*/
SELECT name, continent FROM world t1 WHERE population > ALL (SELECT 3*population FROM world t2 WHERE t2.continent = t1.continent AND t2.name <> t1.name);



