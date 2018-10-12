USE sqlgla; 
GO

-- #####################################################################################################################################################################
-- Films starring 50 Cent
-- #####################################################################################################################################################################

SET STATISTICS IO ON

SELECT 
	 movie_title
FROM 
	RawMovies 
WHERE 
	actor_1_name = '50 Cent'
	OR actor_2_name = '50 Cent'
	or actor_3_name = '50 Cent';


	
SELECT Movie.Movie
FROM Actor Actor1, ActedIn, Movie
WHERE MATCH (Actor1-(ActedIn)->Movie)
AND Actor1.Actor = '50 Cent' 

-- #####################################################################################################################################################################
-- Actors in a Film which starred 50 Cent
-- #####################################################################################################################################################################

SET STATISTICS IO ON 

;with fifty as 
(SELECT 
	 movie_title
FROM 
	RawMovies 
WHERE 
	actor_1_name = '50 Cent'
	OR actor_2_name = '50 Cent'
	or actor_3_name = '50 Cent')
SELECT actor_1_name FROM RawMovies rm INNER JOIN fifty f on f.movie_title = rm.movie_title where actor_1_name <> '50 Cent'
union 
SELECT actor_2_name FROM RawMovies rm INNER JOIN fifty f on f.movie_title = rm.movie_title where actor_2_name <> '50 Cent'
union 
SELECT actor_3_name FROM RawMovies rm INNER JOIN fifty f on f.movie_title = rm.movie_title where actor_3_name <> '50 Cent'

-- #####################################################################################################################################################################
-- Actors in a Film which starred 50 Cent
-- #####################################################################################################################################################################
SET STATISTICS IO ON

SELECT Actor2.Actor
FROM Actor Actor1, Actor Actor2, Starred, ActedIn, Movie
WHERE MATCH (Actor1-(ActedIn)->Movie-(Starred)->Actor2)
AND Actor1.Actor = '50 Cent' AND Actor2.Actor <> '50 Cent'

-- #####################################################################################################################################################################
-- Films which star an actor in a Film which starred 50 Cent
-- #####################################################################################################################################################################



SELECT Distinct Movie2.Movie
FROM Actor Actor1, Actor Actor2, Starred, ActedIn ActedIn1,ActedIn ActedIn2, Movie Movie1, Movie Movie2
WHERE MATCH (Actor1-(ActedIn1)->Movie1-(Starred)->Actor1-(ActedIn2)->Movie1)
AND Actor1.Actor = '50 Cent' AND Actor2.Actor <> '50 Cent'

