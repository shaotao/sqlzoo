/*
The nobel table can be used to practice more SUM and COUNT functions.

nobel(yr, subject, winner)

Nobel Prizes: Aggregate functions
This tutorial concerns aggregate functions such as COUNT, SUM and AVG.
*/


/*
Exercises
Using SUM, COUNT, MAX, AVG, DISTINCT and ORDER BY.

1.
Show the total number of prizes awarded.
*/
SELECT COUNT(*) FROM nobel;


/*
2.
List each subject - just once
*/
SELECT DISTINCT(subject) FROM nobel;

/*
3.
Show the total number of prizes awarded for Physics.

nobel(yr, subject, winner)  
*/
SELECT COUNT(*) FROM nobel WHERE subject = 'Physics';


/*
Using GROUP BY and HAVING.

4.
For each subject show the subject and the number of prizes.

nobel(yr,subject, winner)  
*/
SELECT subject, COUNT(subject) FROM nobel GROUP BY subject;


/*
5.
For each subject show the first year that the prize was awarded.

nobel(yr, subject, winner)  
*/
SELECT subject, MIN(yr) FROM nobel GROUP BY subject;


/*
6.
For each subject show the number of prizes awarded in the year 2000.

nobel(yr, subject, winner)  
*/
SELECT subject, count(subject) FROM nobel WHERE yr = 2000 GROUP BY subject;

/*
Look into aggregates with DISTINCT.

7.
Show the number of different winners for each subject.

nobel(yr, subject, winner)  
*/
SELECT subject, COUNT(DISTINCT(winner)) FROM nobel GROUP BY subject;

/*
8.
For each subject show how many years have had prizes awarded.

nobel(yr, subject, winner)  
*/
SELECT subject, COUNT(DISTINCT yr) FROM nobel GROUP BY subject;

/*
Using HAVING.

9.
Show the years in which three prizes were given for Physics.

nobel(yr, subject, winner) 
*/
SELECT yr FROM nobel WHERE subject = 'Physics' GROUP BY yr HAVING COUNT(winner) = 3;


/*
10.
Show winners who have won more than once.

nobel(yr, subject, winner)  
*/
SELECT winner FROM nobel GROUP BY winner HAVING COUNT(winner) > 1;


/*
11.
Show winners who have won more than one subject.

nobel(yr, subject, winner)  
*/
SELECT winner FROM nobel GROUP BY winner HAVING COUNT(DISTINCT subject) > 1;


/*
GROUP BY yr, subject
12.
Show the year and subject where 3 prizes were given. Show only years 2000 onwards.

nobel(yr, subject, winner)  
*/
SELECT yr, subject FROM nobel WHERE yr >= 2000 GROUP BY yr,subject HAVING COUNT(*) = 3;

