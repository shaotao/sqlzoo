/*
Old JOIN Tutorial

The Table Tennis Olympics Database
The table ttms shows the Olympic medal winners for Table Tennis (Men's Singles). The country of each winner is given by a three letter code. To get the actual country name you must JOIN this table to the country table.

The two tables country and ttms are ONE TO MANY. One country has many winners, each winner has only one country.

Ttms.png

ttms
games	color	who	country
1988	gold	Yoo Nam-Kyu	KOR
1988	silver	Kim Ki Taik	KOR
..	..	..	..

country
id	name
ALG	Algeria
ARG	Argentina
...	...
KOR	Korea
..	..


How to do joins
The phrase FROM ttms JOIN country ON ttms.country=country.id represents the join of the tables ttms and country. This JOIN has one row for every medal winner. In addition to the ttms fields (games, color, who and country) it includes the details of the corresponding country (id, name ).
*/

/*

Summary
1.
Show the athelete (who) and the country name for medal winners in 2000.

ttms(games,color,who,country)
country(id,name)
*/
SELECT who, name FROM ttms JOIN country ON ttms.country = country.id WHERE games = 2000;



/*
2.
Show the who and the color of the medal for the medal winners from 'Sweden'.

ttms(games,color,who,country)
country(id,name)   
*/
SELECT who, color FROM ttms JOIN country ON ttms.country = country.id WHERE country.name = 'Sweden';


/*
3.
Show the years in which 'China' won a 'gold' medal.


ttms(games,color,who,country)
country(id,name)   
*/
SELECT games FROM ttms JOIN country ON ttms.country = country.id AND ttms.color = 'Gold' AND country.name = 'China'



/*
Women's Singles Table Tennis Olympics Database
The Summer Olympic games are held every four years in a different city. The table games shows which city the games were held in. The Women's Single's winners are in the table ttws.

Ttws.png
ttws
games	color	who	country
1988	gold	Jing Chen	CHN
1988	silver	Li Hui-Fen	CHN
..	..	..	..
games
yr	city	country
1988	Seoul	KOR
1992	Barcelona	ESP
..	..	..
*/

/*
4.
Show who won medals in the 'Barcelona' games.


ttws(games,color,who,country)
games(yr,city,country)   
*/
SELECT who FROM ttws JOIN games ON ttws.games = games.yr AND games.city = 'Barcelona';



/*
5.
Show which city 'Jing Chen' won medals. Show the city and the medal color.

ttws(games,color,who,country)
games(yr,city,country)   
*/
SELECT city, color FROM ttws JOIN games ON ttws.games = games.yr AND ttws.who = 'Jing Chen';


/*
6.
Show who won the gold medal and the city.


ttws(games,color,who,country)
games(yr,city,country)   
*/
SELECT who, city FROM ttws JOIN games ON ttws.games = games.yr AND color = 'Gold';


/*
Table Tennis Mens Doubles
 The Table Tennis Mens Double teams are stored in the table team.
 Each team has an arbitrary number that is referenced from the table ttmd.
Ttmd.png
ttmd
games	color	team	country
1988	gold	1	CHN
1988	silver	2	YUG
..	..	..	..
team
id	name
1	Long-Can Chen
1	Qing-Guang Wei
2	Ilija Lupulesku
2	Zoran Primorac
..	..
*/

/*
7.
Show the games and color of the medal won by the team that includes 'Yan Sen'.

ttmd(games,color,team,country)
team(id,,name)  
*/
SELECT games, color FROM ttmd JOIN team ON ttmd.team = team.id AND team.name LIKE '%Yan Sen%'


/*
8.
Show the 'gold' medal winners in 2004.


ttmd(games,color,team,country)
team(id,,name)   
*/
SELECT name FROM ttmd JOIN team ON ttmd.team = team.id AND color = 'Gold' AND games = 2004;



/*
9.
Show the name of each medal winner country 'FRA'.


ttmd(games,color,team,country)
team(id,,name)  
*/
SELECT name FROM ttmd JOIN team ON ttmd.team = team.id AND ttmd.country = 'FRA';






