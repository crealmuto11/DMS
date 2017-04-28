---SQL statements for the AGENCY database--

---Create statements---
--DROP TABLE IF EXISTS Zipcodes;
CREATE TABLE Zipcodes (
  zipcode TEXT NOT NULL,
  city TEXT NOT NULL,
  state char(2) NOT NULL,
  PRIMARY KEY(zipcode)
 );

--DROP TABLE IF EXISTS Addresses;
CREATE TABLE Addresses (
  addressID char(3) NOT NULL,
  line1_buildingnumber TEXT NOT NULL,
  line2_street TEXT NOT NULL,
  zipcode TEXT NOT NULL references Zipcodes(zipcode),
  country TEXT NOT NULL,
  PRIMARY KEY(addressID)
 );

--DROP TABLE IF EXISTS Agencies;
CREATE TABLE Agencies (
  agencyID char(3) NOT NULL,
  agency_name TEXT NOT NULL,
  addressID char(3) NOT NULL references Addresses(addressID),
  agency_phone TEXT NOT NULL,
  agency_email TEXT,
  rating TEXT,
  PRIMARY KEY(agencyID) 
  );

 --DROP TABLE IF EXISTS Contacts;
CREATE TABLE Contacts (
  contactID char(3) NOT NULL,
  agencyID char(3) NOT NULL references Agencies(agencyID),
  contact_first TEXT NOT NULL,
  contact_last TEXT NOT NULL,
  contact_phone TEXT NOT NULL,
  contact_email TEXT,
  PRIMARY KEY(contactID)
 );

--DROP TABLE IF EXISTS Head_Contact;
CREATE TABLE Head_Contact (
  contactID char(3) NOT NULL references Contacts(contactID),
  cont_position TEXT NOT NULL CHECK (cont_position='FT' or cont_position='PT'),
  cont_comments TEXT,
  lastcalled DATE NOT NULL,
  PRIMARY KEY(contactID)
);

--DROP TABLE IF EXISTS Backup_Contact;
CREATE TABLE Backup_Contact (
  contactID char(3) NOT NULL references Contacts(contactID),
  cont_position TEXT NOT NULL CHECK (cont_position='FT' or cont_position='PT'),
  cont_comments TEXT,
  lastcalled DATE NOT NULL,
  PRIMARY KEY(contactID)
);

--DROP TABLE IF EXISTS Employers;
CREATE TABLE Employers (
  clientID char(3) NOT NULL,
  addressID char(3) NOT NULL references Addresses(addressID),
  client_name TEXT,
  client_email TEXT,
  client_phone TEXT,
  PRIMARY KEY(clientID)
 );

--DROP TABLE IF EXISTS Openings;
CREATE TABLE Openings (
  openID char(3) NOT NULL,
  clientID char(3) NOT NULL references Employers(clientID),
  job_description char(200) NOT NULL,
  date_published DATE,
  date_filled DATE,
  fee_chargedUSD INT,
  fee_payedUSD INT,
  PRIMARY KEY(openID)
 );

--DROP TABLE IF EXISTS Skill_List;
CREATE TABLE Skill_List (
  skillID char(3) NOT NULL,
  skill_description char(200),
  PRIMARY KEY(skillID)
 );

--DROP TABLE IF EXISTS Openings_Skills_Req;
CREATE TABLE Openings_Skills_Req (
  openID char(3) NOT NULL references Openings(openID),
  skillID char(3) NOT NULL references Skill_List(skillID),
  PRIMARY KEY(openID, skillID)
 );

--DROP TABLE IF EXISTS Hirees;
CREATE TABLE Hirees (
  candidateID char(4) NOT NULL,
  addressID char(3) NOT NULL references Addresses(addressID),
  agencyID char(3) NOT NULL references Agencies(agencyID),
  date_registered DATE,
  candidate_first char(20),
  candidate_last char(20),
  gender TEXT CHECK (gender='M' or gender='F' or gender='O'),
  candidate_DOB DATE,
  candidate_email TEXT,
  candidate_phone TEXT,
  PRIMARY KEY(candidateID)
 );

--DROP TABLE IF EXISTS Hiree_Skills;
CREATE TABLE Hiree_Skills (
  candidateID char(4) NOT NULL references Hirees(candidateID),
  skillID char(3) NOT NULL references Skill_List(skillID), 
  PRIMARY KEY (candidateID,skillID)
);

--DROP TABLE IF EXISTS Application_Status;
CREATE TABLE Application_Status (
  AppStatusID char(2) NOT NULL,
  description char(250),
  PRIMARY KEY(AppStatusID)
 );

--DROP TABLE IF EXISTS Hirees_for_Openings;
CREATE TABLE Hirees_for_Openings (
  HFO_ID char(3) NOT NULL,
  candidateID char(4) NOT NULL,
  AppStatusID char(2) NOT NULL references Application_Status(AppStatusID),
  date_updated DATE,
  HFO_comments char(200),
  PRIMARY KEY(HFO_ID)
);


--INSERT STATEMENTS---
INSERT INTO Zipcodes( zipcode, city, state )
VALUES ('12601', 'Poughkeepsie', 'NY'),
	('11050', 'Port Washington', 'NY'),
	('10005', 'New York', 'NY'),
	('10017', 'New York' ,'NY'),
	('10013', 'New York', 'NY'),
	('10282', 'New York', 'NY'),
	('10171', 'New York', 'NY'),
	('10036', 'New York', 'NY'),
	('10022', 'New York', 'NY'),
	('10001', 'New York', 'NY'),
	('10004', 'New York', 'NY'),
	('07920', 'Bridgewater', 'NJ'),
	('12524', 'Fishkill', 'NY'),
	('00007', 'Stamford', 'CT');

INSERT INTO Addresses( addressID, line1_buildingnumber, line2_street, zipcode, country )
VALUES('001', '3399', 'North Road', '12601', 'USA'),
	('002', '18', 'Concord Road', '11050', 'USA'),
	('003', '95', 'Wall Street', '10005', 'USA'),
	('004', '60', 'Wall Street', '10005', 'USA'),
	('005', '270', 'Park Ave', '10017', 'USA'),
	('006', '390', 'Greenwich Street', '10013', 'USA'),
	('007', '200', 'West Street', '10282', 'USA'),
	('008', '299', 'Park Ave', '10171', 'USA'),
	('009', '1585', 'Broadway', '10036', 'USA'),
	('010', '488', 'Madison Ave', '10022', 'USA'),
	('011', '5', 'Pennsylvania Plaza', '10001', 'USA'),
	('012', '11', 'Broadway', '10004', 'USA'),
	('013', '4', 'New York Plaza', '10004', 'USA'),
	('014', '19', 'Daffedil Drive', '07920', 'USA'),
	('015', '121', 'Sugar Lane', '12524', 'USA'),
	('016', '007', 'Bond Street', '00007', 'USA');

INSERT INTO Agencies (agencyID, agency_name, addressID, agency_phone, agency_email, rating )
VALUES ('a01', 'GETAJOB Consultants', '013', '(212)-123-1231', 'contact@GETAJOB.com', 'A'),
	('a02', 'Creative Financial Staffing', '010', '(212)-444-3342', 'contact@CFS.com', 'AA'),
	('a03', 'Accelerate Financial Staffing', '011', '(212)-886-1363', 'hiring@AFS.com', 'BB'),
	('a04', 'Wall Street Services', '012', '(212)-299-1239', 'contact@wallstreetservices.com', 'A'),
	('a05', 'Minion Consulting', '003', '(131)-123-1837', 'minion@3NFConsulting.com', 'AA'),
	('a06', 'Forum Employment', '003', '(231-822-8189)', 'ask@forumemployment.com', 'B');

INSERT INTO Contacts ( contactID, agencyID, contact_first, contact_last, contact_phone, contact_email)
VALUES ('001', 'a04', 'Sean', 'Sullivan', '(516)-763-1231', 'seansullivan@wallstreetservices.com'),
	('002', 'a01', 'Erica', 'Rose', '(631)-624-8098', 'e.falco@GETAJOB.com'),
	('003', 'a02', 'Lauren', 'Suran', '(516)-112-1314', 'lauransuran@CFS.com'),
	('004', 'a02', 'Ronald', 'Cavaliere', '(516)-241-2342', 'ronaldcavaliere@CFS.com'),
	('005', 'a01', 'Erin', 'Murtha', '(631)-953-2941', 'e.murtha@GETAJOB.com'),
	('006', 'a03', 'Brian', 'Haughey', '(231)-524-1475', 'brianh@AFS.com'),
	('007', 'a03', 'John', 'Finnigan', '(231)-813-4812', 'johnf@AFS.com');

INSERT INTO Head_Contact ( contactID, cont_position, cont_comments, lastcalled )
VALUES ('001', 'FT', 'available from 9-5 weekdays', '2016-05-24'),
	('002', 'FT', 'available from 10-3 weekdays', '2017-01-29'),
	('003', 'FT', 'avaibale from 8-6 daily', '2017-04-08'),
	('006', 'PT', 'available MWF', '2016-12-17');
	
INSERT INTO Backup_Contact ( contactID, cont_position, cont_comments, lastcalled )
VALUES ('004', 'FT', 'available 8-5 daily', '2017-02-13'),
	('005', 'FT', 'available 9-4 daily', '2017-01-13'),
	('007', 'PT', 'available only TF', '2016-11-23');

INSERT INTO Employers (clientID, addressID, client_name, client_email, client_phone)
VALUES ('001', '004', 'Deutsche Bank', 'HR@deutschebank.com', '(231)-158-1730'),
	('002', '005', 'JP Morgan Chase', 'hire@jpm.com', '(918)-985-2000'),
	('003', '006', 'Citigroup', 'HR@citigroup.com', '(919)-718-8190'),
	('004', '007', 'Goldman Sachs', 'goldmanhire@GS.com', '(231)-912-1939'),
	('005', '008', 'UBS', 'contact@UBS.com', '(918)-429-8000'),
	('006', '009', 'Morgan Stanley', 'questions@morganstanley.com', '(231)-131-1827'),
	('007','004','Blackrock', 'hiring@blackrock.com', '(212)-810-5300');

INSERT INTO Openings (openID, clientID, job_description, date_published, date_filled, fee_chargedUSD, fee_payedUSD)
VALUES ('001', '001', 'Financial Analyst- Asset Management', '2017-01-01' , NULL, 2500, 2000),
	('002', '003', 'SVP - Legal Finance Management', '2016-08-23', '2016-12-10', 2500, 2500),
	('003', '002', 'Analyst- CIB Reporting', '2016-11-16',NULL , 1800, 1760),
	('004', '002', 'Managing Director- Corp Finance OTC', '2017-02-28', '2017-03-18', 1950, 1950),
	('005', '004', 'Executive Director- Wealth Budgeting', '2016-09-16',NULL, 1550, 1300),
	('006', '005', 'Admin - Client Banking', '2017-02-23', '2017-04-08', 1000, 1000),
	('007', '006', 'Analyst-Account Control', '2017-01-17',NULL, 890, 0),
	('008', '001', 'Analyst-Internal Auditing', '2016-10-31', '2017-02-05', 720, 720);

INSERT INTO Skill_List (skillID, skill_description)
VALUES ('001', 'Asset Management'),
	('002', 'Auditing'),
	('003', 'Secretarial expertise'),
	('004', 'Budget reporting'),
	('005', 'Management expertise'),
	('006', 'Advanced knowledge in Excel'),
	('007', 'Accounting knowledge'),
	('008', 'Degree in Business');
	
INSERT INTO Openings_Skills_Req (openID, skillID)
VALUES ('001', '001'), ('001', '006'), ('001','008'),
	('002', '006'), ('002', '004'),
	('003', '004'), ('003', '008'),
	('004', '005'), ('004', '006'), ('004', '008'),
	('005', '005'), ('005', '004'), ('005', '008'),
	('006', '003'),
	('007', '007'), ('007','006'),
	('008', '007'), ('008', '002'), ('008', '006');

INSERT INTO Hirees (candidateID, addressID, agencyID, date_registered, candidate_first, candidate_last, gender, candidate_DOB, candidate_email, candidate_phone)
VALUES ('1000','001','a01','2016-02-19', 'Alan', 'Labouseur', 'M', '1980-05-06', 'alanlabouseur@marist.edu', '(845)-575-3000'),
	('1001','002','a01','2016-05-20', 'Carolena', 'Realmuto', 'F', '1995-08-23', 'carolenarealmuto1@marist.edu', '(516)-512-1010'),
	('1002', '014','a01','2016-12-21', 'Kimberly', 'Woodward', 'F', '1996-01-18', 'kimw@gmail.com', '(741)-913-1929'),
	('1003', '015','a01','2017-03-28', 'Sam', 'Smith', 'M', '1980-11-12', 'samsmith@gmail.com','(918)-313-7192'),
	('1004', '016','a01','2017-04-03', 'James', 'Bond', 'M', '1979-06-29', 'jamesbond007@gmail.com','(007)-007-0007'),
	('1005','003','a01','2016-02-19', 'Tedd', 'Codd', 'M', '1935-06-18', 'TeddCodd@3NFconsulting.com', '(845)-575-3000'),
	('1006', '003', 'a01', '2017-04-24', 'Lisa', 'Conroy', 'F', '1961-08-08', 'LisaConroy@teleworm.us','(256)-610-3127');

INSERT INTO Hiree_Skills (candidateID, skillID)
VALUES ('1000','005'), ('1000','006'),
	('1001', '008'), ('1001','001'),
	('1002', '007'), ('1002','004'),
	('1003', '002'), ('1003', '003'),
	('1004','007'), ('1004','008'), ('1004','005');
	
INSERT INTO Application_Status (AppStatusID, description)
VALUES ('01', 'interviewing'),
	('02', 'Offer given'),
	('03', 'Offer accepted'),
	('04', 'Offer rejected');
	
INSERT INTO Hirees_for_Openings (HFO_ID, candidateID, AppStatusID, date_updated, HFO_comments)
VALUES ('003', '1002', '03', '2017-04-08', 'Balance not completely paid- email next week'),
	('006', '1003', '01', '2017-03-12', 'interview date set for April 29th'),
	('001', '1001', '04', '2017-02-28', 'Offer rejected- taking job at JP Morgan due to poor Deutshe bank performance');


--VIEWS:
--shows which employers need to pay the rest of their balance:
--DROP VIEW Account_Balances--
CREATE OR REPLACE VIEW Account_Balances AS
SELECT Employers.clientID, Employers.client_name, Openings.openID, Openings.fee_chargedUSD, Openings.fee_payedUSD
FROM Openings INNER JOIN Employers ON Openings.ClientID = Employers.clientID 
and Openings.fee_chargedUSD > Openings.fee_payedUSD;

Select *
from Account_Balances;

--shows which employeers and hirees that are in the same zipcode:
--DROP VIEW Employer_Zipcode--
CREATE OR REPLACE VIEW Employer_Zipcode AS	
select employers.client_name, addresses.zipcode
from employers inner join addresses on employers.addressID = addresses.addressID;

--DROP VIEW Agency_Zipcode--
CREATE OR REPLACE VIEW Agency_Zipcode AS
select agencies.agency_name, addresses.zipcode
from agencies inner join addresses on agencies.addressID = addresses.addressID;

--DROP VIEW Hiree_Zipcode--
CREATE OR REPLACE VIEW Hiree_Zipcode AS
select CONCAT(hirees.candidate_first,hirees.candidate_last) AS FullName, addresses.zipcode
from hirees inner join addresses on hirees.addressID = addresses.addressID;

--DROP VIEW Zipcode_Matches--
CREATE OR REPLACE VIEW Zipcode_Matches AS
select a.zipcode, client_name, agency_name, fullname
from Employer_Zipcode e inner join Agency_Zipcode a on e.zipcode = a.zipcode
                        inner join Hiree_Zipcode h on e.zipcode = h.zipcode;

--DROP VIEW Count_Zipcode--
CREATE OR REPLACE VIEW Count_Zipcode AS
select distinct zipcode, fullname
from Zipcode_Matches
union
select distinct zipcode, agency_name
from Zipcode_Matches
union
select distinct zipcode, client_name
from Zipcode_Matches;


SELECT * FROM COUNT_Zipcode;

--the following view shows the list of candidates, their ID's, and their skill description.
--DROP VIEW Hiree_Skills_Description--
CREATE OR REPLACE VIEW Hiree_Skills_Description AS
SELECT hirees.candidateID,
       hirees.candidate_first,
       hirees.candidate_last,
       skill_list.skill_description
FROM Hiree_skills inner join Hirees ON hirees.candidateID = hiree_skills.candidateID
		   inner join skill_list ON skill_list.skillid = hiree_skills.skillID
WHERE hiree_skills.skillID = '005';
     
select *
from Hiree_Skills_Description;

select *
from hirees;

--STORED PROCEDURES--
--this SP allows the user to input a zipcode and it returns all the entities with that zipcode (or similar).
create or replace function get_entities_by_zipcode(TEXT, REFCURSOR) returns REFCURSOR as
$$
declare
	zip TEXT :=$1;
	resultset REFCURSOR :=$2;
begin
	open resultset for
		select zipcode, FullName
		from Hiree_Zipcode
		where zipcode LIKE zip;
return resultset;
end;
$$
language plpgsql;

select get_entities_by_zipcode('12%','results');
Fetch all from results;

--TRIGGERS:
CREATE OR REPLACE FUNCTION balance_check() RETURNS trigger as
$$
begin
	IF new.fee_payedUSD > fee_chargedusd from Openings 
	WHERE openID = '007'
	THEN RAISE NOTICE 'fee payed cannot be higher than fee charged';
	RETURN NULL;
	END IF;
end;
$$
language plpgsql;

--drop trigger balance_check on Openings;
CREATE TRIGGER balance_check AFTER INSERT OR UPDATE ON OPENINGS
FOR EACH ROW EXECUTE PROCEDURE balance_check();

--test--
UPDATE Openings
SET fee_payedUSD = 900 --this value will trigger the error message
where openID = '007';

select *
from openings;


--REPORTS
create or replace function count_by_zipcode(TEXT, REFCURSOR) returns REFCURSOR as
$$
declare
	zip TEXT :=$1;
	resultset REFCURSOR :=$2;
begin
	open resultset for
		SELECT COUNT(zipcode)
		  FROM Count_Zipcode
		 WHERE zipcode = zip;
return resultset;
end;
$$
language plpgsql;

select count_by_zipcode('10005','results');
Fetch all from results;

--SECURITY/GRANT AND REVOKE 
   
CREATE ROLE Admin;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO Admin;

CREATE ROLE Staff;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA PUBLIC TO Staff;

CREATE ROLE Clients;
GRANT SELECT ON Hirees TO Clients;
GRANT SELECT ON Hiree_Skills TO Clients;
GRANT SELECT ON Employers TO Clients;
