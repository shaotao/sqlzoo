/*
Self join
Edinburgh Buses
Details of the database Looking at the data

stops(id, name)
route(num,company,pos, stop)
stops	route
id	num
name	company
pos
stop

*/

/*
Summary
1.
How many stops are in the database.
*/
SELECT COUNT(*) from stops;

/*
2.
Find the id value for the stop 'Craiglockhart'
*/
SELECT id FROM stops WHERE name = 'Craiglockhart';


/*
3.
Give the id and the name for the stops on the '4' 'LRT' service.
*/
SELECT stops.id, stops.name FROM stops JOIN route ON route.stop = stops.id AND route.num = 4 AND route.company = 'LRT';


/*
Routes and stops
4.
The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
*/
SELECT company, num, COUNT(*) FROM route WHERE stop=149 OR stop=53 GROUP BY company, num HAVING COUNT(*) = 2;


/*
5.
Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
*/
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) WHERE a.stop=53 AND b.stop = 149;

/*
6.
The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
*/
SELECT a.company, a.num, stopa.name, stopb.name FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id) WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';


/*
Using a self join
7.
Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
*/
SELECT DISTINCT R1.company, R1.num FROM route R1 JOIN route R2 ON R1.company = R2.company AND R1.num = R2.num AND R1.stop = 115 AND R2.stop = 137;

/*
8.
Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
*/
SELECT DISTINCT R1.company, R1.num FROM route R1 JOIN route R2 ON (R1.company = R2.company AND R1.num = R2.num) JOIN stops s1 ON R1.stop = s1.id AND s1.name = 'Craiglockhart' JOIN stops s2 ON R2.stop = s2.id AND s2.name = 'Tollcross';


/*
9.
Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
*/
SELECT s2.name, R1.company, R1.num FROM route R1 JOIN route R2 on R1.company = R2.company AND R1.num = R2.num JOIN stops s1 ON R1.stop = s1.id AND s1.name = 'Craiglockhart' JOIN stops s2 ON R2.stop = s2.id;


/*
10.
Find the routes involving two buses that can go from Craiglockhart to Sighthill.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.

Hint
Self-join twice to find buses that visit Craiglockhart and Sighthill, then join those on matching stops.
*/
SELECT T.b, T.a, S3.name, T.d, T.c FROM
  (SELECT R1.company AS a, R1.num AS b, R2.company AS c, R2.num AS d
   FROM route R1
     JOIN route R2 ON (R1.company != R2.company OR R1.num != R2.num)
     JOIN stops S1 ON (R1.stop = S1.id AND S1.name = 'Craiglockhart')
     JOIN stops S2 ON (R2.stop = S2.id AND S2.name = 'Sighthill')) T
  JOIN route R3 ON T.a = R3.company AND T.b = R3.num
  JOIN route R4 ON T.c = R4.company AND T.d = R4.num
  JOIN stops S3 ON R3.stop = S3.id
WHERE R3.stop = R4.stop

SELECT DISTINCT T.num1, T.com1, S3.name, T.num2, T.com2 FROM
  (SELECT R1.num AS num1, R1.company AS com1, R2.num AS num2, R2.company AS com2 FROM route R1
     JOIN route R2 ON (R1.company != R2.company OR R1.num != R2.num)
     JOIN stops S1 ON (R1.stop = S1.id AND S1.name = 'Craiglockhart')
     JOIN stops S2 ON (R2.stop = S2.id AND S2.name = 'Sighthill')) T
  JOIN route R3 ON T.com1 = R3.company AND T.num1 = R3.num
  JOIN route R4 ON T.com2 = R4.company AND T.num2 = R4.num
  JOIN stops S3 ON R3.stop = S3.id
WHERE R3.stop = R4.stop

