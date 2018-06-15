/*
SELECT from Nobel Tutorial


nobel
yr	subject	winner
1960	Chemistry	Willard F. Libby
1960	Literature	Saint-John Perse
1960	Medicine	Sir Frank Macfarlane Burnet
1960	Medicine	Peter Madawar
...

nobel Nobel Laureates
We continue practicing simple SQL queries on a single table.

This tutorial is concerned with a table of Nobel prize winners:

nobel(yr, subject, winner)
Using the SELECT statement.
*/

/*
Winners from 1950
1.
Change the query shown so that it displays Nobel prizes for 1950.
*/
SELECT yr, subject, winner FROM nobel WHERE yr = 1950;


/*
1962 Literature
2.
Show who won the 1962 prize for Literature.
*/
SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature';


/*
Albert Einstein
3.
Show the year and subject that won 'Albert Einstein' his prize.
*/
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';


/*
Recent Peace Prizes
4.
Give the name of the 'Peace' winners since the year 2000, including 2000.
*/
SELECT winner FROM nobel WHERE subject = 'Peace' AND yr >= 2000;


/*
Literature in the 1980's
5.
Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
*/
SELECT yr, subject, winner FROM nobel where subject = 'Literature' and yr BETWEEN 1980 AND 1989;




