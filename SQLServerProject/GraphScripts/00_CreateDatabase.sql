USE master;

ALTER DATABASE Movies SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO 

DROP DATABASE Movies;

CREATE DATABASE Movies;

USE Movies;
GO

CREATE TABLE [dbo].[RawMovies](
	[MovieId]  int identity ,
	[color] [varchar](16) NULL,
	[director_name] [varchar](320) NULL,
	[num_critic_for_reviews] [smallint] NULL,
	[duration] [smallint] NULL,
	[director_facebook_likes] [smallint] NULL,
	[actor_3_facebook_likes] [smallint] NULL,
	[actor_2_name] [varchar](270) NULL,
	[actor_1_facebook_likes] [int] NULL,
	[gross] [int] NULL,
	[genres] [varchar](640) NULL,
	[actor_1_name] [varchar](240) NULL,
	[movie_title] [varchar](630) NULL,
	[num_voted_users] [int] NULL,
	[cast_total_facebook_likes] [int] NULL,
	[actor_3_name] [varchar](270) NULL,
	[facenumber_in_poster] [smallint] NULL,
	[plot_keywords] [varchar](1490) NULL,
	[movie_imdb_link] [varchar](520) NULL,
	[num_user_for_reviews] [smallint] NULL,
	[language] [varchar](100) NULL,
	[country] [varchar](140) NULL,
	[content_rating] [varchar](90) NULL,
	[budget] [int] NULL,
	[title_year] [smallint] NULL,
	[actor_2_facebook_likes] [int] NULL,
	[imdb_score] [real] NULL,
	[aspect_ratio] [real] NULL,
	[movie_facebook_likes] [int] NULL
) ON [PRIMARY]

GO


SELECT * FROM [dbo].[RawMovies]