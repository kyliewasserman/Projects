DROP TABLE IF EXISTS ScoreBoard;
DROP TABLE IF EXISTS Board;
DROP TABLE IF EXISTS LongestRoute;
DROP TABLE IF EXISTS TrainTickets;
DROP TABLE IF EXISTS TrainRoutes;
DROP TABLE IF EXISTS GamePlayers;
DROP TABLE IF EXISTS Games;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Rules;
DROP TABLE IF EXISTS Judges;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS People;

-- People --
CREATE TABLE People (
   PID         int  not null unique,
   FirstName   text not null,
   LastName    text,
   DOB         date not null,
   Email       text,
 primary key(pid)
);

-- Players --
CREATE TABLE Players (
   PlayerID             int not null references People(PID),
   TotalNumWins         int,
   TotalNumGamesPlayed  int,
 primary key(PlayerID)
);

-- Judges --
CREATE TABLE Judges (
   JudgeID              int not null references People(pid),
   TotalNumGamesJudged  int,
 primary key(JudgeID)
);

-- Rules --
CREATE TABLE Rules (
  RuleID           int     not null unique,
  CardsPerTurn     int     not null,
  TicketsInAdvance boolean not null,
CONSTRAINT CheckCards CHECK (CardsPerTurn = 2 or CardsPerTurn = 3),
 primary key(RuleID)
);

-- Address --
CREATE TABLE Address (
  AddressID  int  not null unique,
  Street     text not null,
  City       text not null,
  State      text,
  Country    text not null,
  ZIP        int,
 primary key(AddressID)
);

-- Games --
CREATE TABLE Games (
  GameID          int not null unique,
  DateOfGame      date,
  WinnerPlayer    int,
  RuleID          int,
  AddressID       int,
 primary key(GameID)
);

-- GamePlayers --
CREATE TABLE GamePlayers (
  GameID          int     not null references Games(GameID),
  PlayerID1       int     not null references Players(PlayerID),
  PlayerID2       int     not null references Players(PlayerID),
  PlayerID3       int              references Players(PlayerID),
  PlayerID4       int              references Players(PlayerID),
  PlayerID5       int              references Players(PlayerID),
  JudgeID         int     not null references Judges(JudgeID),         
 primary key(GameID)
);

-- TrainRoutes --
CREATE TABLE TrainRoutes (
  RouteID     int     not null unique,
  GameID      int     not null references Games(GameID),
  PlayerID    int     not null references Players(PlayerID),
  Color       text    not null,
  City1       text    not null,
  City2       text    not null,
  Length      int     not null,
  Points      int     not null, 
  CONSTRAINT CheckColor  Check (Color = 'red' OR Color = 'orange' OR Color = 'yellow' OR Color = 'green' OR Color = 'blue' OR Color = 'purple' OR Color = 'black' OR Color = 'white' OR Color = 'grey'),
  CONSTRAINT CheckLength Check (Length = 1 OR Length = 2 OR Length = 3 OR Length = 4 OR Length = 5 OR Length = 6),
  CONSTRAINT CheckPoints Check (Points = 1 OR Points = 2 OR Points = 4 OR Points = 7 OR Points = 10 OR Points = 15),
primary key(RouteID, GameID, PlayerID)
);

-- TrainTickets --
CREATE TABLE TrainTickets (
  TrainID      int     not null unique,
  GameID       int     not null references Games(GameID),
  PlayerID     int     not null references Players(PlayerID),
  TotalPoints  int     not null,
  City1        text    not null,
  City2        text    not null, 
primary key(TrainID, GameID, PlayerID)
);

-- LongestRoute --
CREATE TABLE LongestRoute (
  PlayerID           int     not null references Players(PlayerID),
  GameID             int     not null references Games(GameID),
  IsThisLongestRoute boolean not null,
  Points             int     not null, 
primary key(PlayerID, GameID)
);

-- Board --
CREATE TABLE Board (
  SegmentID     int     not null references TrainRoutes(RouteID),
  Used			boolean not null,
  Player        int,
primary key(SegmentID)
);

-- ScoreBoard --
CREATE TABLE ScoreBoard (
  PlayerID             int     not null references Players(PlayerID),
  GameID               int     not null references Games(GameID),
  TotalPoints          int     not null,
primary key(PlayerID, GameID)
);


-- SQL statements for loading example data

-- People --
INSERT INTO People (PID, FirstName, LastName, DOB, Email)
VALUES
 (001, 'Kylie',  'Wasserman',  '2002-05-29', 'kylie.wasserman1@marist.edu'),
 (002, 'Emily',  'Styles',     '2002-06-18', 'emily1234@aol.com'),
 (003, 'Alan',   'Labouseur',  '1990-12-12', 'alan.labouseur@marist.edu'),
 (004, 'Zoe',    'Slayer',     '1969-02-28', 'zslayer127@gmail.com'),
 (005, 'Brooke', 'Smith',      '1901-08-04', 'heyo@gmail.com'),
 (006, 'Sara',   'Cooke',      '1987-08-18', 'qwerty@yahoo.com'),
 (007, 'Lauren', 'Wasserman',  '1944-01-12', 'catsareawesome@123.com'),
 (008, 'James',  'Brown',      '1962-11-11', 'whoevenareyou@boss.com'),
 (009, 'Carl',   'McMann',     '1917-10-21', 'whowhatwherewhen@gmail.com')
;

-- Players --
INSERT INTO Players (PlayerID, TotalNumWins, TotalNumGamesPlayed)
VALUES
 (001, 99, 99),
 (005, 14, 72),
 (006, 21, 78),
 (007, 11, 62),
 (008, 07, 20),
 (009, 00, 50)
;

-- Judges --
INSERT INTO Judges (JudgeID, TotalNumGamesJudged)
VALUES
 (002, 19),
 (003, 63),
 (004, 25)
;

-- Rules --
INSERT INTO Rules (RuleID, CardsPerTurn, TicketsInAdvance)
VALUES
(1, 2, FALSE),
(2, 3, TRUE)
;

-- Address --
INSERT INTO Address(AddressID, Street, City, State, Country, ZIP)
VALUES
(001, '123 Pond Ave',     'Broken-Tail', 'NJ', 'USA',    '07612'),
(002, '76 North Rd',      'WestWater',   'CT', 'USA',    '18271'),
(011, '91 SummerSet Ave', 'London',      null, 'England', null),
(035, '812 Main St',      'Paris',       null, 'France',  null),
(036, '4567 West Ave',    'Worcester',   'MA', 'USA',     '34571'),
(047, '971 Center Rd',    'Wood-Ridge',  'NJ', 'USA',     '07075'),
(099, '21 FireFly Ln',    'Cherry Hill', 'NJ', 'USA',     '01821')
;

-- Games --
INSERT INTO Games(GameID, DateOfGame, WinnerPlayer, RuleID, AddressID)
VALUES
(001, '2016-01-12', 001, 1, 001),
(007, '2016-09-24', 008, 2, 035),
(014, '2017-05-12', 007, 1, 035),
(025, '2017-08-07', 001, 2, 036),
(031, '2017-12-12', 005, 2, 047),
(042, '2019-10-31', 006, 2, 099),
(099, '2022-05-02', 001, 2, 001)
;

-- GamePlayers --
INSERT INTO GamePlayers(GameID, PlayerID1, PlayerID2, PlayerID3, PlayerID4, PlayerID5, JudgeID)
VALUES
(001, 001, 005, 006,  007,  008,  002),
(007, 007, 008, 009,  null, null, 003),
(014, 001, 006, null, null, null, 004),
(025, 006, 007, 008,  009,  null, 004),
(031, 001, 005, 007,  009,  null, 003),
(042, 005, 006, 007,  008,  009,  002),
(099, 005, 007, 009,  null, null, 002)
;

-- TrainRoutes --
INSERT INTO TrainRoutes(RouteID, GameID, PlayerID, Color, City1, City2, Length, Points)
VALUES
(001, 001, 001, 'red',   'Oklahoma City', 'Denver',   4, 7),
(002, 007, 005, 'green', 'El Paso',       'Houston',  6, 15),
(003, 014, 006, 'blue',  'Oklahoma City', 'Santa Fe', 3, 4),
(004, 025, 006, 'grey',  'Montreal',      'Boston',   2, 2),
(005, 031, 009, 'grey',  'Montreal',      'Boston',   2, 2),
(006, 042, 001, 'green', 'Saint Louis',   'Chicago',  2, 2),
(007, 099, 008, 'white', 'Saint Louis',   'Chicago',  2, 2)
;

-- TrainTickets --
INSERT INTO TrainTickets(TrainID, GameID, PlayerID, TotalPoints, City1, City2)
VALUES
(001, 001, 001, 14, 'Oklahoma City', 'Sault St. Marie'),
(002, 007, 005, 06, 'Houston',       'Atlanta'),
(003, 014, 006, 18, 'Santa Fe',      'Toronto'),
(004, 025, 007, 22, 'New York',      'Seattle'),
(005, 031, 008, 16, 'Montreal',      'Vancouver'),
(006, 042, 008, 06, 'Chicago',       'Dallas'),
(007, 099, 001, 10, 'Chicago',       'Miami')
;

-- LongestRoute --
INSERT INTO LongestRoute(PlayerID, GameID, IsThisLongestRoute, Points)
VALUES
(001, 001, TRUE,  10),
(005, 007, TRUE,  10),
(006, 014, FALSE, 0),
(007, 025, FALSE, 0),
(008, 031, TRUE,  10),
(009, 042, FALSE, 0),
(001, 099, FALSE, 0)
;


-- Board --
INSERT INTO Board(SegmentID, Used, Player)
VALUES
(001, TRUE, 001),
(002, FALSE, 005),
(003, FALSE, 005), 
(004, TRUE, 008),
(005, FALSE, 008)
;

-- ScoreBoard --
INSERT INTO ScoreBoard(PlayerID, GameID, TotalPoints)
VALUES
(001, 001, 132),
(005, 031, 101),
(006, 007, 97),
(007, 099, 112),
(008, 042, 143)
;

-- SQL statements for displaying this example data:
select *
from People;

select *
from Players;

select *
from Judges;

select *
from Rules;

select *
from Address;

select *
from Games;

select *
from GamePlayers;

select * 
from TrainRoutes;

select *
from TrainTickets;

select *
from LongestRoute;

select *
from Board;

select *
from ScoreBoard;

--Stored Proceders--

--1. get the all of the city options given 1 city
create or replace function get_other_city(text, REFCURSOR) returns refcursor as 
$$
declare
   givencity   text      := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select city1, city2
      from   TrainRoutes
      where  city1 = givencity or city2 = givencity;
   return resultset;
end;
$$ 
language plpgsql;

select get_other_city('Chicago', 'results');
Fetch all from results;

--2. get the points of a train route given the length--
create or replace function get_points(int, REFCURSOR) returns refcursor as 
$$
declare
   givenlength int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select points
      from   TrainRoutes
       where length = givenlength;
   return resultset;
end;
$$ 
language plpgsql;

select get_points(4, 'results');
Fetch all from results;

--3. enter a gameid and playerid tells us if that player won that game by returning the winnerplayer or returning nothing
create or replace function did_i_win(int, int, REFCURSOR) returns refcursor as 
$$
declare
   player      int       := $1;
   game        int       := $2;
   resultset   REFCURSOR := $3;
begin
   open resultset for 
      select winnerplayer
      from games
      where winnerplayer = player and gameid = game;
   return resultset;
   
end;
$$ 
language plpgsql;

--not winner
select did_i_win(5, 32, 'results');
Fetch all from results;

--is winner
select did_i_win(5, 31, 'results');
Fetch all from results;

--triggers--

--1. validate people inputs
CREATE OR REPLACE FUNCTION ValidatePeople()
RETURNS TRIGGER AS
$$
BEGIN
  IF NEW.FirstName IS NULL THEN
  RAISE EXCEPTION 'FirstName may not be NULL';
  END IF;
  RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER validPeople
BEFORE INSERT OR UPDATE ON People
FOR EACH ROW
EXECUTE PROCEDURE ValidatePeople();

--testing
INSERT INTO People (PID, FirstName, LastName, DOB, Email)
             VALUES(010, NULL, NULL, '2000-01-01', 'sample@email.com');
			 
--2. not allowing a team that only have 1 player be created
CREATE OR REPLACE FUNCTION EnoughPlayers()
RETURNS TRIGGER AS
$$
BEGIN
  IF NEW.PlayerID2 IS NULL THEN
  RAISE EXCEPTION 'PlayerID2 may not be NULL, you need to have at least 2 players.';
  END IF;
  RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER EnoughPlay
BEFORE INSERT OR UPDATE ON GamePlayers
FOR EACH ROW
EXECUTE PROCEDURE EnoughPlayers();

--testing
INSERT INTO GamePlayers(GameID, PlayerID1, PlayerID2, PlayerID3, PlayerID4, PlayerID5, JudgeID)
             VALUES(002, 001, null, null, null, null, 003);

--queries--

--1. the first and last name of all judges who have were born in december
select p.firstname, p.lastname
from people p inner join judges j on p.pid = j.judgeid
where extract(month from p.DOB)='12';

--2. all games that judge 002 judged in 2016 with rule 1
select g.gameid as "Game ID"
from judges j inner join gameplayers gp on j.judgeid = gp.judgeid
              inner join games g        on gp.gameid = g.gameid
where j.judgeid = 2
  and g.ruleid = 1
  and extract(year from g.dateofgame)='2016';
  
--3. select the first and last name of the players who played games in MA(use subquieres)
select pe.firstname, pe.lastname
from people pe
where pe.pid in (select pl.playerid
				 from players pl
				 where pl.playerid in (select gp.playerid1
									   from gameplayers gp
									   where gp.gameid in (select g.gameid
														   from games g
														   where g.addressid in (select a.addressid
																				 from address a
																				 where a.state = 'MA')))
				   or pl.playerid in (select gp.playerid2
									   from gameplayers gp
									   where gp.gameid in (select g.gameid
														   from games g
														   where g.addressid in (select a.addressid
																				 from address a
																				 where a.state = 'MA')))
				 or pl.playerid in (select gp.playerid3
									   from gameplayers gp
									   where gp.gameid in (select g.gameid
														   from games g
														   where g.addressid in (select a.addressid
																				 from address a
																				 where a.state = 'MA')))
				 or pl.playerid in (select gp.playerid4
									   from gameplayers gp
									   where gp.gameid in (select g.gameid
														   from games g
														   where g.addressid in (select a.addressid
																				 from address a
																				 where a.state = 'MA')))
				 or pl.playerid in (select gp.playerid5
									   from gameplayers gp
									   where gp.gameid in (select g.gameid
														   from games g
														   where g.addressid in (select a.addressid
																				 from address a
																				 where a.state = 'MA')))
)
order by lastname ASC;
										
--views--

--1. get all of the points from all 3 tables
CREATE OR REPLACE VIEW TotalGamePlayerPoints as (
    select tr.gameid as "Game", tr.playerid as "Player", tr.points as "Train Route Points", tt.totalpoints as "Train Ticket Points", lr.points as "Longest Route Points"
	from trainroutes tr inner join traintickets tt on tr.playerid = tt.playerid
	                    inner join longestroute lr on tt.playerid = lr.playerid
	where tt.gameid = lr.gameid
	    and tt.gameid = tr.gameid
);

select *
from TotalGamePlayerPoints;

--2. all players who have won a game, and that amount
CREATE OR REPLACE VIEW WinnerPlayers as (
	select p.playerid as "Player", p.totalnumwins as "Amount of Wins"
	from players p
	where p.totalnumwins != 0
);

select *
from WinnerPlayers;

--3. all people who are both a judge and a player
CREATE OR REPLACE VIEW JudgePlayer as (
	select pe.pid
	from people pe inner join players pl on pe.pid = pl.playerid
	               inner join judges j on pl.playerid = j.judgeid
);

select *
from JudgePlayer;

--user roles / security --
CREATE ROLE ADMIN;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO ADMIN;

CREATE ROLE GameMaster;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC FROM GameMaster;
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO GameMaster;
GRANT INSERT ON People, Players, Judges, Address, Games, GamePlayers, TrainRoutes, TrainTickets, LongestRoute, Board, ScoreBoard 
TO GameMaster;
GRANT UPDATE ON People, Players, Judges, Address, Games, GamePlayers, TrainRoutes, TrainTickets, LongestRoute, Board, ScoreBoard
TO GameMaster;

CREATE ROLE GameInfoFinder;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC
FROM GameInfoFinder;
GRANT SELECT ON Rules, Games, TrainRoutes, TrainTickets, LongestRoute
TO GameInfoFinder;
GRANT INSERT ON Rules, Games, TrainRoutes, TrainTickets, LongestRoute
TO GameInfoFinder;
GRANT UPDATE ON Rules, Games, TrainRoutes, TrainTickets, LongestRoute
TO GameInfoFinder;