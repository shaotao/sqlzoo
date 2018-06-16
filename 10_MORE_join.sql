/*
More JOIN operations

This tutorial introduces the notion of a join. The database consists of three tables movie , actor and casting .

movie
id	title	yr	director	budget	gross

actor
id	name

casting
movieid	actorid	ord
*/


/*
1962 movies
1.
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title FROM movie WHERE yr = 1962;


/*
When was Citizen Kane released?
2.
Give year of 'Citizen Kane'.
*/
SELECT yr FROM movie WHERE title = 'Citizen Kane';


/*
Star Trek movies
3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/
SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%';


/*
id for actor Glenn Close
4.
What id number does the actor 'Glenn Close' have?
*/
SELECT id FROM actor WHERE name = 'Glenn Close';


/*
id for Casablanca
5.
What is the id of the film 'Casablanca'
*/
SELECT id FROM movie WHERE title = 'Casablanca';


/*
Cast list for Casablanca
6.
Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/
SELECT actor.name FROM casting JOIN movie ON casting.movieid = movie.id AND movie.title = 'Casablanca' JOIN actor ON actor.id = casting.actorid;

/*
Alien cast list
7.
Obtain the cast list for the film 'Alien'
*/
SELECT actor.name FROM casting JOIN movie ON casting.movieid = movie.id AND movie.title = 'Alien' JOIN actor ON actor.id = casting.actorid;


/*
Harrison Ford movies
8.
List the films in which 'Harrison Ford' has appeared
*/
SELECT movie.title FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id AND actor.name = 'Harrison Ford';


/*
Harrison Ford as a supporting actor
9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT movie.title FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id AND actor.name = 'Harrison Ford' AND casting.ord > 1;


/*
Lead actors in 1962 movies
10.
List the films together with the leading star for all 1962 films.
*/
SELECT title, name FROM movie JOIN casting ON movie.id = casting.movieid AND movie.yr = 1962 JOIN actor ON casting.ord = 1 AND casting.actorid = actor.id;


/*
Harder Questions

Busy years for John Travolta
11.
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr, COUNT(*) FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'John Travolta' GROUP BY yr HAVING COUNT(*) > 2;

/*
Lead actor in Julie Andrews movies
12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?
Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).

Title is not a unique field, create a table of IDs in your subquery
*/
SELECT title, name FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id WHERE movie.id in (SELECT movie.id FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid AND actor.name = 'Julie Andrews') AND casting.ord = 1;

/*
Actors with 30 leading roles
13.
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
*/
SELECT actor.name FROM actor JOIN casting ON actor.id = casting.actorid AND casting.ord = 1 GROUP BY actor.id HAVING COUNT(*) >= 30;


/*
14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/
SELECT movie.title, COUNT(*) FROM movie JOIN casting on movie.id = casting.movieid AND movie.yr = 1978 GROUP BY movie.id ORDER BY COUNT(*) DESC, movie.title;


/*
15.
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT DISTINCT(actor.name) FROM actor JOIN casting ON actor.id = casting.actorid AND casting.movieid in (SELECT casting.movieid FROM casting JOIN actor ON casting.actorid = actor.id AND actor.name = 'Art Garfunkel') AND actor.name <> 'Art Garfunkel';



