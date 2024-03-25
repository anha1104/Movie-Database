Create Database MovieDB;
GO

USE MovieDB;
GO

Create Table MEDIA_ROLE_OPTION(
	Job				varchar(10)		not null,
	JobDescription	varchar(1000)	not null

	Constraint MEDIA_ROLE_OPTION_PK PRIMARY KEY (Job),
);


Create Table GENRE(
	Genre				varchar(30)		not null,
	GenreDescription	varchar(1000)	not null

	Constraint GENRE_PK PRIMARY KEY (Genre),
)

Create Table MEDIA_TYPE_NAME(
	MediaType		varchar(11)		not null,
	TypeDescription	varchar(1000)	not null

	Constraint MEDIA_TYPE_NAME_PK PRIMARY KEY (MediaType),
)

Create Table MEDIA_TYPE(
	MediaId     Integer     NOT NULL,
	MediaType	varchar(11)	NOT NULL,
	MediaTitle	varchar(50) NOT NULL,
	ReleaseYear Integer		NOT NULL,

	Constraint		MEDIA_TYPE_PK	Primary Key (MediaId),
	Constraint		MEDIA_TYPE_FK	Foreign key (MediaType)
		references	MEDIA_TYPE_NAME (MediaType)
)

Create Table MEDIA (
	MediaType		varchar(11) NOT NULL,
	MediaTitle		varchar(50) NOT NULL,
	ReleaseYear		Integer		NOT NULL,
	ReleaseMonth	Integer		Not null,
	ReleaseDay		Integer		not null,
	AvgRating		Integer		null		Check (AvgRating >= 0		AND		AvgRating <= 100), 
	AvgCriticRating Integer		null		Check (AvgCriticRating >= 0 AND		AvgCriticRating <= 100),
	EpisodeCount	Integer		not null	Check (EpisodeCount > 0),
	BoxOffice		Integer		null		Check (BoxOffice > 0),
	Budget			Integer		not null	Check (Budget > 0),
	Runtime			varchar(5)	null,

	Constraint		Media_PK		Primary Key (MediaType, MediaTitle, ReleaseYear),
	Constraint		Runtime_Format	Check (Runtime Like '__h__' )
)


Create Table MEDIA_GENRE (
	MediaId		Integer		not null,
	Genre		varchar(30) not null,

	Constraint		MEDIA_GENRE_PK	PRIMARY KEY (MediaId, Genre),
	Constraint		MEDIA_GENRE_FK	FOREIGN KEY (MediaId)
		references	MEDIA_TYPE(MediaId),
	Constraint		MEDIA_GENRE_FK2 FOREIGN KEY (Genre)
		references	GENRE(Genre)
)



Create Table CINEMA (
	CinemaId		Int				not null,
	CinemaName		varchar(20)		not null,
	Cinema_address	varchar(100)	not null,

	Constraint CINEMA_PK PRIMARY KEY (CinemaId)
)

Create Table MOVIE_LOCATION (
	MediaId		Integer		not null,
	CinemaID	Integer		not null,

	Constraint		MOVIE_LOCATION_PK	PRIMARY KEY (MediaId, CinemaId),
	Constraint		MOVIE_LOCATION_FK	FOREIGN KEY (MediaId)
		references	MEDIA_TYPE(MediaId),
	Constraint		MOVIE_LOCATION_FK2	FOREIGN KEY (CinemaId)
		references	CINEMA(CinemaID)
)


Create Table USER_DB (
	Username			varchar(20)		not null,
	Pass				varchar(100)	not null,
	LastName			varchar(20)		not null, 
	FirstName			varchar(20)		not null,
	MInitial			char(1)			null,
	City				varchar(20)		not null,
	Country				varchar(30)		not null,
	Rating				Decimal(2,1)	not null,
	Sex					char(1)			not null,
	Age					int				not null	check (Age > 0),
	BirthMonth			int				not null, 
	BirthDay			int				not null,
	AdminPermission		bit				not null,

	Constraint	USER_DB_PK		PRIMARY KEY (Username) ,
	Constraint	SEX_CONSTRAINT	CHECK (Sex IN ('M', 'F'))

)

/**************/
Create Table USER_ENGAGEMENT (
	MediaId		Integer			not null,
	Username	varchar(20)		not null,
	Review		varchar(1000)	null,
	IsFavorite  bit				not null,

	Constraint		USER_INTERACTION_PK		PRIMARY KEY (MediaId, Username),
	Constraint		USER_INTERACTION_FK		FOREIGN KEY (MediaId)
		references	MEDIA_TYPE(MediaId),
	Constraint		USER_INTERACTION_FK2	FOREIGN KEY (Username)
		references	USER_DB(Username)
)

Create Table MEDIA_ROLE (
	MediaId		Integer		not null,
	Username	varchar(20)	not null,
	Job			varchar(10)	not null,

	Constraint		MEDIA_ROLE_PK PRIMARY KEY (MediaId, Username, Job),
	Constraint		MEDIA_ROLE_FK FOREIGN KEY (MediaId)
		references	MEDIA_TYPE(MediaId),
	Constraint		MEDIA_ROLE_FK2 FOREIGN KEY (Username)
		references	USER_DB(Username),
	Constraint		JOB_CONSTRAINT foreign key (Job)
		references	MEDIA_ROLE_OPTION (Job)
)


Create Table MEDIA_AWARD (
	MediaId		Integer		not null,
	Award		varchar(20)	not null,
	Year		Integer		not null,

	Constraint	MEDIA_AWARD_PK	PRIMARY KEY (MediaId, Award, Year)
)


Create Table STREAMING_OPTION (
	MediaId		Integer		not null,
	WebName		varchar(20)	not null,
	
	Constraint	STREAMING_OPTION_PK		PRIMARY KEY (MediaId, WebName)
)

Create Table USER_EMAIL (
	Username	varchar(20)	not null,
	Email		varchar(30)	not null,

	Constraint		USER_EMAIL_PK		PRIMARY KEY (Username, Email)
)

Create Table  STREAMING_SERVICE (
	Service_Url	varchar(50)		not null,
	WebName		varchar(20)		not null,
	MediaID		Integer			not null,
	MinSubPrice Decimal(5, 2)	not null	check(MinSubPrice >= 0),
	MaxSubPrice Decimal(5, 2)	not null,
	Clicks		int				not null,

	Constraint		STREAMING_SERVICE_PK		PRIMARY KEY (Service_Url),
	Constraint		STREAMING_SERVICE_FK		FOREIGN KEY (MediaID, WebName)
		references	STREAMING_OPTION (MediaID, WebName),
	Constraint		MAX_SUB_PRICE_CONSTRAINT	Check (MaxSubPrice >= MinSubPrice)
)

Create Table CLICK_THROUGH(
	MediaId		int			not null,
	WebName		varchar(20)	not null,
	Username	varchar(20)	not null,

	Constraint		CLICK_THROUGH_PK	PRIMARY KEY (MediaId, WebName, Username),
	Constraint		CLICK_THROUGH_FK	FOREIGN KEY (MediaID, WebName)
		references	STREAMING_OPTION (MediaID, WebName),
	Constraint		CLICK_THROUGH_FK2	FOREIGN KEY (Username)
		references	USER_DB (Username),
)

GO
USE MovieDB;

INSERT INTO MEDIA_ROLE_OPTION VALUES(
	'Producer', 'The person who produces the media');
Insert into MEDIA_ROLE_OPTION VALUES(
	'Actor', 'The person who plays an acting role in the media');
Insert into MEDIA_ROLE_OPTION VALUES(
	'Director', 'The person who has the overacrching vision of the media');

Insert into GENRE VALUES(
	'Action', 'Media that focuses on fight sequences');
Insert into GENRE VALUES(
	'Sci-fi', 'Media that contains a lot of technology that does not truly exist');
Insert into GENRE VALUES(
	'Thriller', 'Media that focuses on scaring the audience');
Insert into GENRE VALUES(
	'Romance', 'Media that focuses on the romnantic relationship between characters');
Insert into GENRE VALUES(
	'Comedy', 'Media that aims to make the audience laugh');
Insert into GENRE VALUES(
	'Drama', 'Media that focuses on character development and adversities');
Insert into GENRE VALUES(
	'Documentary', 'Media that focuses on teaching the audience facts');

Insert into MEDIA_TYPE_NAME VALUES(
	'Movie', 'A long form of media entertainment');
Insert into MEDIA_TYPE_NAME VALUES(
	'TV Show', 'An episodic form of media entertainment');
Insert into MEDIA_TYPE_NAME VALUES(
	'Documentary', 'Media that focuses on teaching the audience facts');
Insert into MEDIA_TYPE VALUES(
	1, 'Movie', 'Spider-man', 2002);
Insert into MEDIA_TYPE VALUES(
	2, 'Movie', 'Titanic', 1997 );
Insert into MEDIA_TYPE VALUES(
	3, 'Movie', 'Get Out', 2018 );
Insert into MEDIA_TYPE VALUES(
	4, 'TV Show', 'Friends', 1994 );
Insert into MEDIA_TYPE VALUES(
	5, 'TV Show', 'Suits', 2011 );
Insert into MEDIA_TYPE VALUES(
	6, 'TV Show', 'Desparate Housewives', 2004 );
Insert into MEDIA_TYPE VALUES(
	7, 'Documentary', 'The Social Dilemma', 2020 );
Insert into MEDIA_TYPE VALUES(
	8, 'Documentary', 'The Cold War', 2000 );
Insert into MEDIA_TYPE VALUES(
	9, 'Documentary', 'The Woman Who Loves Kangaroos', 2005);
Insert into MEDIA VALUES(
	 'Movie', 'Spider-man', 2002, 1, 1, 0, 0, 1, 1000, 1390, '02h15');
Insert into MEDIA VALUES(
	 'Movie', 'Titanic', 1997, 12, 30 , 0, 0, 1, 22640, 1700, '03h14');
Insert into MEDIA VALUES(
	 'Movie', 'Get Out', 2018, 6, 28, 0, 0, 1, 25546, 2000, '01h44');
Insert into MEDIA VALUES(
	 'TV Show', 'Friends', 1994, 9, 15, 0, 0, 236, null, 13600, null);
Insert into MEDIA VALUES(
	 'TV Show', 'Suits', 2011, 7, 20, 0, 0,134, null, 4200, null);
Insert into MEDIA VALUES(
	 'TV Show', 'Desparate Housewives', 2004, 5, 8, 0, 0, 180, null, 1260, null);
Insert into MEDIA VALUES(
	 'Documentary', 'The Social Dilemma', 2020, 4, 11, 0, 0, 1, 34780, 5000, '01h34');
Insert into MEDIA VALUES(
	 'Documentary', 'The Cold War', 2000, 1, 3, 0, 0,1, null, 2000, '02h10' );
Insert into MEDIA VALUES(
	 'Documentry', 'The Woman Who Loves Kangaroos', 2005, 2, 16, 0, 0, 1,null, 1000, '10h23');
Insert into MEDIA_GENRE VALUES(
	1, 'Action');
Insert into MEDIA_GENRE VALUES(
	1, 'Sci-fi');
Insert into MEDIA_GENRE VALUES(
	2, 'Romance');
Insert into MEDIA_GENRE VALUES(
	3, 'Thriller');
Insert into MEDIA_GENRE VALUES(
	4, 'Comedy');
Insert into MEDIA_GENRE VALUES(
	5, 'Drama');
Insert into MEDIA_GENRE VALUES(
	6, 'Drama');
Insert into MEDIA_GENRE VALUES(
	6, 'Comedy');
Insert into MEDIA_GENRE VALUES(
	7, 'Documentary');
Insert into MEDIA_GENRE VALUES(
	8, 'Documentary');
Insert into MEDIA_GENRE VALUES(
	9, 'Documentary');
Insert into CINEMA VALUES(
	100, 'Cinemark', 'Tacoma');
Insert into CINEMA VALUES(
	200, 'AMC', 'Federal Way');
Insert into CINEMA VALUES(
	300, 'Regal', 'Renton');
Insert into MOVIE_LOCATION VALUES(
	1,300);
Insert into MOVIE_LOCATION VALUES(
	3,300);
Insert into MOVIE_LOCATION VALUES(
	7,300);
Insert into MOVIE_LOCATION VALUES(
	1,200);
Insert into MOVIE_LOCATION VALUES(
	3,200);
Insert into MOVIE_LOCATION VALUES(
	8,200);
Insert into MOVIE_LOCATION VALUES(
	1,100);
Insert into USER_DB VALUES(
	'aha25','cupcake','Ha','An','T','Renton','USA',7.5,'F',22, 4, 11, 0);
Insert into USER_DB VALUES(
	'Xeno369','Terence','Trajano','Terence','F','Shanghai','China',7.0,'M',27, 12, 20, 0);
Insert into USER_DB VALUES(
	'admin','password','Smith','Jane',null,'Boston','USA',6.0,'F',29, 9, 21, 1);
Insert into USER_DB VALUES(
	'admin2','password2','Smith','Josh',null,'Boston','USA',8.0,'M',50, 10, 30, 1);
Insert into USER_DB VALUES(
	'Bunny','wifi','Tran','Thuy','T','Saigon','Vietnam',6.5,'F',42, 8, 20, 0);
Insert into USER_DB VALUES(
	'Sue','2024','Ha','Duong','P','Renton','USA',9.0,'F',20, 4, 28, 0);
Insert into USER_DB VALUES(
	'Sraimi','spider','Raimi','Sam',null,'Royal Oak','USA',5.0,'M',64, 1, 2, 0);
Insert into USER_DB VALUES(
	'Jcam','jacknrose','Cameron','James','F','Ontario','Canada',8.5,'M',69, 8, 16, 0);
Insert into USER_DB VALUES(
	'PSteven','Transformer','Spielberg','Steven','A','Cincinnati','USA',8.0,'M',77, 12, 18, 0);
Insert into USER_DB VALUES(
	'LeoD','girl26','DiCaprio','Leo','W','Los Angeles','USA',6.0,'M',49, 11, 11, 0);
Insert into USER_DB VALUES(
	'JAniston','funny','Aniston','Jennifer','J','Los Angeles','USA',9.3,'F',55, 2, 11, 0);
Insert into USER_ENGAGEMENT VALUES(
	1, 'aha25', 'Toby is handsome', 0);
Insert into USER_ENGAGEMENT VALUES(
	6, 'aha25', 'Great show', 1);
Insert into USER_ENGAGEMENT VALUES(
	8, 'aha25', 'Boring', 0);
Insert into USER_ENGAGEMENT VALUES(
	1, 'Xeno369', null, 1);
Insert into USER_ENGAGEMENT VALUES(
	9, 'Xeno369', null, 1);
Insert into USER_ENGAGEMENT VALUES(
	1, 'Bunny', 'Spend your time and money somewhere else', 0);
Insert into USER_ENGAGEMENT VALUES(
	2, 'Sue', 'Marvelous', 1);
Insert into USER_ENGAGEMENT VALUES(
	2, 'Bunny', 'I cannot believe someone hired Leo for a movie', 0);


Insert into MEDIA_ROLE VALUES(
	1, 'Sraimi', 'Director');
Insert into MEDIA_ROLE VALUES(
	1, 'Sraimi', 'Producer');
Insert into MEDIA_ROLE VALUES(
	1, 'PSteven', 'Producer');
Insert into MEDIA_ROLE VALUES(
	1, 'Sraimi', 'Actor');
Insert into MEDIA_ROLE VALUES(
	2, 'Jcam', 'Producer');
Insert into MEDIA_ROLE VALUES(
	2, 'Jcam', 'Director');
Insert into MEDIA_ROLE VALUES(
	2, 'LeoD', 'Actor');
Insert into MEDIA_ROLE VALUES(
	2, 'JAniston', 'Actor');


Insert into MEDIA_ROLE VALUES(
	3, 'Sraimi', 'Director');
Insert into MEDIA_ROLE VALUES(
	3, 'PSteven', 'Producer');
Insert into MEDIA_ROLE VALUES(
	3, 'LeoD', 'Actor');



Insert into MEDIA_ROLE VALUES(
	4, 'Jcam', 'Producer');
Insert into MEDIA_ROLE VALUES(
	4, 'JAniston', 'Actor');

Insert into MEDIA_ROLE VALUES(
	5, 'PSteven', 'Producer');
Insert into MEDIA_ROLE VALUES(
	5, 'Sraimi', 'Actor');
Insert into MEDIA_ROLE VALUES(
	5, 'LeoD', 'Actor');

Insert into MEDIA_ROLE VALUES(
	7, 'Jcam', 'Producer');
Insert into MEDIA_ROLE VALUES(
	7, 'Sraimi', 'Director');
Insert into MEDIA_AWARD VALUES(
	2, 'Emmy', 1997);
Insert into MEDIA_AWARD VALUES(
	2, 'Oscar', 1997);
Insert into MEDIA_AWARD VALUES(
	9, 'IDA', 2005);
Insert into STREAMING_OPTION VALUES(
	1, 'Disney Plus');
Insert into STREAMING_OPTION VALUES(
	2, 'Netflix');
Insert into STREAMING_OPTION VALUES(
	2, 'Hulu');
Insert into STREAMING_OPTION VALUES(
	3, 'Netflix');
Insert into STREAMING_OPTION VALUES(
	4, 'Hulu');
Insert into STREAMING_OPTION VALUES(
	5, 'Netflix');
Insert into STREAMING_OPTION VALUES(
	6, 'Netflix');
Insert into STREAMING_OPTION VALUES(
	7, 'Netflix');
Insert into STREAMING_OPTION VALUES(
	8, 'Netflix');
Insert into STREAMING_OPTION VALUES(
	8, 'Hulu');
Insert into STREAMING_OPTION VALUES(
	9, 'Disney Plus');
Insert into USER_EMAIL VALUES(
	'aha25', 'aha25@uw.edu');
Insert into USER_EMAIL VALUES(
	'aha25', 'aha68145@gmail.com');
Insert into USER_EMAIL VALUES(
	'Xeno369', 'ttrajano@uw.edu');
Insert into USER_EMAIL VALUES(
	'Xeno369', 'terence.f.t@hotmail.com');
Insert into STREAMING_SERVICE VALUES(
	'netflix.com', 'Netflix', 2, 0.0 , 16.50, 1000 );
Insert into STREAMING_SERVICE VALUES(
	'hulu.com', 'Hulu', 2, 5.50 , 14.50, 500 );
Insert into STREAMING_SERVICE VALUES(
	'disneyplus.com', 'Disney Plus', 1, 7.50 , 12.50, 9000 );

Insert into CLICK_THROUGH VALUES(
	 1, 'Disney Plus', 'Xeno369' );
Insert into CLICK_THROUGH VALUES(
	 2, 'Hulu', 'Xeno369' );
Insert into CLICK_THROUGH VALUES(
	 8, 'Hulu', 'Xeno369' );
Insert into CLICK_THROUGH VALUES(
	 9, 'Disney Plus', 'Xeno369' );
Insert into CLICK_THROUGH VALUES(
	 2, 'Netflix', 'aha25' );
Insert into CLICK_THROUGH VALUES(
	 8, 'Netflix', 'aha25' );
Insert into CLICK_THROUGH VALUES(
	 5, 'Netflix', 'aha25' );

GO
use MovieDB;

--Finds the reviews written by a specifed user
select USER_ENGAGEMENT.Username, MEDIA_TYPE.MediaTitle, USER_ENGAGEMENT.Review
from USER_ENGAGEMENT JOIN MEDIA_TYPE 
ON USER_ENGAGEMENT.MediaId = MEDIA_TYPE.MediaId
where Username = 'aha25'

--updates the rating of a user
Update USER_DB 
Set	   Rating = 9.0
Where   Username = 'aha25'

--Finds the list of favorites of the specified user
select USER_ENGAGEMENT.Username, MEDIA_TYPE.MediaTitle 
from USER_ENGAGEMENT JOIN MEDIA_TYPE 
ON USER_ENGAGEMENT.MediaId = MEDIA_TYPE.MediaId
where Username = 'aha25' AND IsFavorite = 1

--Finds any media that contains the search term
select MediaTitle
from	MEDIA_TYPE
where	MediaTitle 
like	'%spider%'

--finds all media of the specified genre
select MediaTitle, Genre
from MEDIA_GENRE JOIN MEDIA_TYPE ON MEDIA_GENRE.MediaId = MEDIA_TYPE.MediaId
where Genre = 'comedy' 

--recommends movies based on user's favorites
select MediaTitle
from MEDIA_TYPE join (
	select distinct MediaId
	from	MEDIA_GENRE JOIN (
	
		select Genre
		from	MEDIA_GENRE JOIN (
			select  Username, USER_ENGAGEMENT.MediaId, MEDIA_TYPE.MediaTitle
			from	USER_ENGAGEMENT  JOIN MEDIA_TYPE 
			ON		USER_ENGAGEMENT.MediaId  = MEDIA_TYPE.MediaId 
			where	IsFavorite = 1 AND Username = 'Xeno369'
		)A1
		ON		MEDIA_GENRE.MediaId = A1.MediaId
	)A2
	ON		A2.Genre = MEDIA_GENRE.Genre
)A3
on A3.MediaId = MEDIA_TYPE.MediaId
where MEDIA_TYPE.MediaId not in (
	select MediaId
	from USER_ENGAGEMENT
	where	IsFavorite = 1 AND Username = 'Xeno369'
)

--creates a new user
Insert into USER_DB VALUES(
	'panda','bamboo','Stacy','Gwen','M','Renton','USA',7.5,'F',22, 4, 11, 0);

--Finds the best media according to its rating
select Top 1 MediaTitle
from	MEDIA
ORDER BY	AvgRating DESC 

--Finds the Media with the most click through, and the streaming service they choose to watch it with.
select Top 1 MEDIA_TYPE.MediaTitle, CLICK_THROUGH.WebName
from	MEDIA_TYPE JOIN CLICK_THROUGH
ON MEDIA_TYPE.MediaId = CLICK_THROUGH.MediaID
GROUP BY MEDIA_TYPE.MediaTitle, CLICK_THROUGH.WebName
ORDER BY COUNT (*) DESC

--finds the months where certain genres perform the best
select Genre, ReleaseMonth, avg(boxoffice)AvgBoxOffice
from MEDIA_GENRE join (
	select MEDIA_TYPE.MediaId, MEDIA_TYPE.MediaTitle, Media.ReleaseMonth, Media.BoxOffice
	from	media join media_type
	on media.MediaTitle = MEDIA_TYPE.MediaTitle
	where BoxOffice > 0
)a1
on a1.MediaId = MEDIA_GENRE.MediaId
group by genre, ReleaseMonth
order by AvgBoxOffice desc

--finds the most famous media cast
select top 1 Username, sum(boxoffice) Earnings
from MEDIA_ROLE join (
	select MediaId, MEDIA_TYPE.MediaTitle, a1.BoxOffice
	from MEDIA_TYPE join (
		select *
		from media
		where BoxOffice > 0
	)a1
	on a1.MediaTitle = MEDIA_TYPE.MediaTitle
)a2
on a2.MediaId = MEDIA_ROLE.MediaId
group by username
order by Earnings desc
