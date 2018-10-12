-- ################################################################################################################################################################################
-- Load the tables. 
-- ################################################################################################################################################################################
use Movies;
GO

-- ###### Movies
DROP VIEW IF EXISTS vMovie;
GO

CREATE VIEW vMovie as 
SELECT MovieId, replace(movie_title, 'Â', '') as MovieTitle FROM RawMovies;
GO

TRUNCATE TABLE Movie;
GO

INSERT INTO Movie SELECT * FROM vMovie;
GO

--SELECT * FROM Movie

-- ###### Genres
DROP VIEW IF EXISTS vGenre;
GO

CREATE VIEW vGenre as 
with genres as 
(SELECT distinct Value as Genre FROM RawMovies
CROSS APPLY STRING_SPLIT(genres, '|'))
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as GenreId, Genre FROM genres;
GO

TRUNCATE TABLE Genre;
GO

INSERT INTO Genre SELECT * FROM vGenre;
GO

--SELECT * FROM Genre; 


-- ###### Directors
DROP VIEW IF EXISTS vDirector;
GO

CREATE VIEW vDirector as 
with directors as 
(SELECT distinct director_name FROM RawMovies
)
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) DirectorId, coalesce(director_name,'Unknown') Director FROM directors;
GO

TRUNCATE TABLE Director;
GO

INSERT INTO Director SELECT * FROM vDirector;
GO

--SELECT * FROM Director;
GO

--### Actors 
DROP VIEW IF EXISTS vActor; 
GO

CREATE VIEW vActor as 
with actors as 
(
SELECT actor_1_name as actor from RawMovies
union 
SELECT actor_2_name from RawMovies
union 
SELECT actor_3_name from RawMovies
)
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) ActorId, coalesce(actor,'Unknown') Actor from actors;
GO

TRUNCATE TABLE Actor;
GO

INSERT INTO Actor SELECT * FROM vActor



-- ################################################################################################################################################################################
-- Populate the edges
-- ################################################################################################################################################################################

TRUNCATE TABLE ActedIn;

INSERT INTO ActedIn
SELECT 
	a.$node_id
	, m.$node_id
FROM	
	RawMovies rm
	INNER JOIN vActor va on rm.actor_1_name = va.Actor
	INNER JOIN Movie m on rm.MovieId = m.MovieId
	INNER JOIN Actor a on va.ActorId = a.ActorId
union all
SELECT 
	a.$node_id
	, m.$node_id
FROM	
	RawMovies rm
	INNER JOIN vActor va on rm.actor_2_name = va.Actor
	INNER JOIN Movie m on rm.MovieId = m.MovieId
	INNER JOIN Actor a on va.ActorId = a.ActorId
union all
SELECT 
	a.$node_id
	, m.$node_id
FROM	
	RawMovies rm
	INNER JOIN vActor va on rm.actor_3_name = va.Actor
	INNER JOIN Movie m on rm.MovieId = m.MovieId
	INNER JOIN Actor a on va.ActorId = a.ActorId

--SELECT * FROM ActedIn

-- ############


TRUNCATE TABLE Starred;

INSERT INTO Starred
SELECT 
	m.$node_id
	, a.$node_id
FROM	
	RawMovies rm
	INNER JOIN vActor va on rm.actor_1_name = va.Actor
	INNER JOIN Movie m on rm.MovieId = m.MovieId
	INNER JOIN Actor a on va.ActorId = a.ActorId
union all
SELECT 
	m.$node_id
	, a.$node_id
FROM	
	RawMovies rm
	INNER JOIN vActor va on rm.actor_2_name = va.Actor
	INNER JOIN Movie m on rm.MovieId = m.MovieId
	INNER JOIN Actor a on va.ActorId = a.ActorId
union all
SELECT 
	m.$node_id
	, a.$node_id
FROM	
	RawMovies rm
	INNER JOIN vActor va on rm.actor_3_name = va.Actor
	INNER JOIN Movie m on rm.MovieId = m.MovieId
	INNER JOIN Actor a on va.ActorId = a.ActorId
