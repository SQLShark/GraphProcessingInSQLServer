-- #######################################################################################################################################
-- Lets make a recommendation engine
-- #######################################################################################################################################

-- #######################################################################################################################################
-- Find all the films Karlene Gerhart rated 10
-- #######################################################################################################################################

SELECT 
	M.Movie
	, R1.Rating
FROM dbo.[USER] U1, dbo.Movie M, dbo.Reviewed R1
WHERE MATCH (U1-(R1)->M)
AND U1.FullName = 'Karlene Gerhart'


-- #######################################################################################################################################
-- Films she rated 10
-- #######################################################################################################################################
SELECT 
	M.Movie
	, R1.Rating
FROM dbo.[USER] U1, dbo.Movie M, dbo.Reviewed R1
WHERE MATCH (U1-(R1)->M)
AND U1.FullName = 'Karlene Gerhart'
AND R1.Rating = 10

-- #######################################################################################################################################
-- Find users who also rated the same films as she did with a rating on 10
-- #######################################################################################################################################
SELECT 
	M.Movie
	, U1.FullName
	, U2.FullName
FROM dbo.[USER] U1, dbo.[USER] U2, dbo.Movie M, dbo.Reviewed R1,  dbo.Reviewed R2
WHERE MATCH (U1-(R1)->M<-(R2)-U2)
AND U1.FullName = 'Karlene Gerhart'
AND U2.FullName <> 'Karlene Gerhart'
AND M.Movie = 'The Dark Knight Rises ' 
AND R1.Rating = 10 
AND R2.Rating = 10

-- #######################################################################################################################################
-- All Moves voted 10 by someone who voted 10 on the same film as Karlene
-- #######################################################################################################################################
DECLARE @User VARCHAR(150) = 'Karlene Gerhart'
DECLARE @Movie VARCHAR(150) = 'Terminator 3: Rise of the Machines ' --'Terminator 3: Rise of the Machines ', 'Poseidon ', 'The Dark Knight Rises '

SELECT DISTINCT
	M2.Movie
FROM dbo.[USER] U1, dbo.[USER] U2, dbo.Movie M, dbo.Reviewed R1,  dbo.Reviewed R2,dbo.Reviewed R3, dbo.Movie M2
WHERE MATCH (U1-(R1)->M<-(R2)-U2-(R3)->M2)
AND U1.FullName = @User
AND U2.FullName <> @User
AND M.Movie = @Movie
AND R1.Rating = 10 
AND R2.Rating = 10 
AND R3.Rating = 10 

-- ###
SELECT M.Movie, R.Rating FROM dbo.Movie M, dbo.[User] U, dbo.Reviewed R
WHERE MATCH(U-(R)->M)
AND U.FullName = 'Karlene Gerhart' AND R.Rating = 10

-- #######################################################################################################################################
-- Just try to write that query in SQL
-- #######################################################################################################################################

BEGIN TRY
	DROP VIEW vRecomendation
END TRY
BEGIN CATCH
	PRINT 'No Need'
END CATCH;
GO

CREATE VIEW vRecomendation AS 
SELECT 
	U1.FullName fromNode
	, M2.Movie [edge]
	, U2.FullName toNode
FROM dbo.[USER] U1, dbo.[USER] U2, dbo.Movie M, dbo.Reviewed R1,  dbo.Reviewed R2,dbo.Reviewed R3, dbo.Movie M2
WHERE MATCH (U1-(R1)->M<-(R2)-U2-(R3)->M2)
AND U1.FullName = 'Karlene Gerhart'
AND U2.FullName <> 'Karlene Gerhart'
--AND M.Movie = 'The Dark Knight Rises ' 
AND R1.Rating = 10 
AND R2.Rating = 10 
AND R3.Rating = 10 

SELECT * FROM vRecomendation