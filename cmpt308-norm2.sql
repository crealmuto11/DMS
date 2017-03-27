DROP TABLE IF EXISTS people, actors, directors, movies, movie_actors, movie_directors;
--create statements
CREATE TABLE people (
	pid INT NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	address VARCHAR(50),
	spouse_first VARCHAR(20),
	spouse_last VARCHAR(20),
	primary key(pid)
	);

CREATE TABLE actors (
	aid INT NOT NULL references people(pid),
	DOB DATE,
	haircolor VARCHAR(20),
	eyecolor VARCHAR(20),
	heightINCH INT,
	weightLBS INT,
	favecolor VARCHAR(20),
	SAGDate DATE,
	primary key(aid)
	);

CREATE TABLE directors (
	did INT PRIMARY KEY NOT NULL references people(pid),
	filmschool VARCHAR(50),
	DGADate DATE,
	favelens VARCHAR(50)
	);

CREATE TABLE movies (
	mid INT NOT NULL,
	movie_name VARCHAR(50),
	year_released INT,
	DomSalesUSD INT,
	ForSalesUSD INT,
	DVD_BlueSalesUSD INT,
	primary key(mid)
	);

CREATE TABLE movie_actors (
	aid INT references people(pid),
	mid INT references movies(mid)
	);

CREATE TABLE movie_directors (
	did INT references people(pid),
	mid INT references movies(mid)
	);
--insert statements:
INSERT INTO people(pid, first_name, last_name, address, spouse_first, spouse_last) VALUES
	(1,'Carolena','Realmuto', '18 Concord Road, NY', 'Robert', 'Downy JR'),
	(2,'Alan', 'Labouseur', 'I have no idea, NY', 'wife', 'idk'),
	(3,'Ryan', 'Reynolds', 'I wish I knew, CA', 'Blake', 'Lively'),
	(4,'Sean', 'Connery', 'Huge mansion, CA', 'Diane', 'Cilento')
;
INSERT INTO actors(aid, DOB, haircolor, eyecolor, heightINCH, weightLBS, favecolor, SAGDate) VALUES
	(1, '1995-08-23','Blonde','Blue', 61, 120, 'green', '2001-12-12'),
	(3, '1976-10-23','Brown','Beautiful', 74, 180, 'red', '2002-12-18'),
	(4, '1930-08-25', 'White', 'Brown',74, 200, 'purple', '2016-06-13')
;

INSERT INTO directors(did, filmschool, DGADate, favelens) VALUES
	(1, 'NY Film Academy', '2003-09-13', 'Birns & Sawyer'),
	(2, 'Syracuse', '2007-05-10', 'Smith Optics')
;
INSERT INTO movies(mid, movie_name, year_released, DomSalesUSD, ForSalesUSD, DVD_BlueSalesUSD) VALUES
	(1,'Goldfinger', 1964, 1000000, 2000000,150000),
	(2, 'Skyfall', 2012, 3000000, 1000000, 750000),
	(3, 'Dodgeball', 2004, 1500000, 750000,250000),
	(4,'Anchorman', 2004, 2000000, 1000000, 500000)
	;
INSERT INTO movie_actors(aid, mid) VALUES
	(1,1), (1,2), (3,3), (4,1), (4,2);
INSERT INTO movie_directors(did,mid) VALUES
	(1,3),(2,2);

--Write a query to show all the directors with whom Sean Connery has worked:
select distinct people.*
from people, movies, directors, movie_directors
where people.pid = directors.did 
and movie_directors.mid = movies.mid
and movie_directors.mid IN (SELECT distinct movies.mid
			     FROM people, movie_actors, movies, actors
			     where people.first_name = 'Sean'
			     and people.last_name = 'Connery'
			     and actors.aid = movie_actors.aid
			     );
