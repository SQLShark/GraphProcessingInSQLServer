use Movies;
GO

BEGIN TRY
	DROP TABLE dbo.Users
END TRY
BEGIN CATCH
	PRINT 'No Need'
END CATCH;
GO

CREATE TABLE dbo.Users
(
	UserId INT IDENTITY
	, FullName VARCHAR(150)
	, Gender VARCHAR(15)
	, Age INT
)

INSERT INTO dbo.Users
(
    FullName,
    Gender,
    Age
)
VALUES
('Zelda Dugal','Female',58)
,('Kenna Papazian','Female',58)
,('Kanisha Reineck','Female',30)
,('Jackelyn York','Female',75)
,('Sofia Hanford','Female',61)
,('Micki Guill','Female',20)
,('Lida Covelli','Female',62)
,('Junie Allred','Female',52)
,('Walker Hemphill','Male',69)
,('Roselee Palermo','Female',17)
,('Althea Voorhies','Female',45)
,('Yulanda Malm','Female',38)
,('Alec Kujawski','Male',31)
,('Donette Blane','Female',26)
,('Brigid Hadaway','Female',27)
,('Carina Routon','Female',67)
,('Jeanice Hannum','Female',38)
,('Shela Marceau','Female',73)
,('Angele Burbage','Female',54)
,('Avelina Cryan','Female',50)
,('Joslyn Truman','Female',29)
,('Gema Izquierdo','Female',60)
,('Aracelis Caine','Female',29)
,('Aletha Berk','Female',61)
,('Mistie Viger','Female',59)
,('Corene Ceniceros','Female',61)
,('Karlene Gerhart','Female',44)
,('Leisha Holtsclaw','Female',33)
,('Malvina Ontiveros','Female',47)
,('Yang Dame','Female',25)
,('Tess Etheridge','Female',39)
,('Tiffani Sutherlin','Female',32)
,('Mai Kiger','Female',48)
,('Darwin Rosel','Male',32)
,('Adrianne Pujol','Female',38)
,('Edythe Hartness','Female',35)
,('Klara Swigert','Female',39)
,('Ray Marcial','Male',71)
,('Kathaleen Lippold','Female',63)
,('Dotty Woo','Female',44)
,('Celina Yamanaka','Female',52)
,('Lula Fairclough','Female',63)
,('Many Blakes','Female',69)
,('Hosea Trimpe','Male',40)
,('Ivan Skyles','Male',22)
,('Belle Ewald','Female',30)
,('Lenard Westlund','Male',17)
,('Jong Culberson','Female',43)
,('Lura Roseboro','Female',70)
,('Jenifer Lanahan','Female',44)

-- #######################################################################################################################################
-- Create the Graph Tables
-- #######################################################################################################################################

BEGIN TRY
	DROP TABLE dbo.[User]
END TRY
BEGIN CATCH
	PRINT 'No Need'
END CATCH;
GO

-- User
CREATE TABLE dbo.[User]
(
	UserId INT 
	, FullName VARCHAR(150)
	, Gender VARCHAR(15)
	, Age INT
) AS NODE

BEGIN TRY
	DROP TABLE dbo.Reviewed
END TRY
BEGIN CATCH
	PRINT 'No Need'
END CATCH;
GO

-- Reviewed
CREATE TABLE dbo.Reviewed 
(
	Rating INT 
)
AS EDGE

-- Populate 
INSERT INTO dbo.[User]
(
    UserId,
    FullName,
    Gender,
    Age
)
SELECT * FROM dbo.Users

-- Poipulate
INSERT INTO dbo.Reviewed
SELECT u.$NODE_ID, m.$node_id, (ABS(CHECKSUM(NewId())) % 10)+1 AS rating  FROM dbo.Movie m, dbo.[User] u;
GO

SELECT * FROM dbo.Reviewed

