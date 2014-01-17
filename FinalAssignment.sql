/*****************Start the MASTER DATABASE ***************************************/
USE master
GO
/*****Runs only after the the Database has been run the first time*****************/
DROP DATABASE dbDeidreFinalAssign
USE master
GO

/*Starts at the MASTER DATABASE, creates a new database different than the Master***/
CREATE DATABASE dbDeidreFinalAssign
GO

/**********Uses the database just created, not any other database*******************/
USE dbDeidreFinalAssign 
GO


/***********************************************************************************/
/*************************CREATE TABLES*********************************************/
CREATE TABLE tbClients
(ClientID INT IDENTITY (1,1) PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Address VARCHAR (50),
City VARCHAR (50),
Province VARCHAR(10),
PostCode VARCHAR(7),
Phone VARCHAR(12));
GO
CREATE TABLE tbUsers
(UserID INT IDENTITY (1,1) PRIMARY KEY,
ClientID INT FOREIGN KEY REFERENCES tbClients(ClientID),
UserName VARCHAR (15),
UserPassword VARCHAR(8),
Email VARCHAR(50),
SecurityQuestion VARCHAR(50),
SecurityAnswer VARCHAR(50),
SecurityLevel VARCHAR(5));
GO
CREATE TABLE tbLogin
(LoginID INT IDENTITY (1,1) PRIMARY KEY,
UserName VARCHAR(15),
UserPassword VARCHAR(8),
LoginTime DATETIME);
GO
CREATE TABLE tbError
(ErrorID INT IDENTITY (1,1) PRIMARY KEY,
ErrorMessage VARCHAR(255),
ClientID INT FOREIGN KEY REFERENCES tbClients(ClientID),
ErrorTime DATETIME);
GO

/**********************************************************************************/
/*************************INSERT DATA INTO TABLES**********************************/

/*************************CLIENT DATA**********************************************/
INSERT INTO tbClients(FirstName,LastName,Address,City,Province,PostCode,Phone)Values
('Carol','Cousins','123 Mile Rd.','Southy','SK','S0S-3F4','306-246-7654'),
('Fred','Collins','123 Mile Rd.','Yorkton','SK','S0B-0N0','306-246-9080'),
('Barry','Friday','322 Doggy Rd.','Regina','SK','S0R-1J3','306-456-5432'),
('Terry','Pike','343 Tony St.','Canora','SK','S0G-1J3','306-246-7989'),
('Mary','May','1765 Camel Way.','Kamsak','SK','S0A-1J3','306-987-7766'),
('Angie','June','2334 Second Rd.','Saskatoon','SK','S0D-1J3','306-655-7456'),
('Pat','Parkin','2334 First St.','Regina','SK','S0R-3J0','306-221-9966'),
('Larry','Flint','123 Green Rd.','Canora','SK','S0C-3J0','306-243-8890'),
('Hazel','Piper','9876 Carry St.','Canora','SK','S0A-2J0','306-265-9436'),
('Barney','Rubble','123 Main St.','Rama','SK','S0A-0J1','306-908-4435'),
('Paul','Pine','42 1st St.','Buchanan','SK','S0A-0J0','306-343-3456'),
('Scott','Wachal','123 Robertson Way','Winnipeg','MB','M0A-0J0','205-343-3456'),
('Deidre','Steenman','Box 539','Buchanan','SK','S0A-0J0','123-343-3456');
GO
/*************************USER DATA************************************************/
INSERT INTO tbUsers(ClientID,UserName,UserPassword,Email,SecurityQuestion,SecurityAnswer,SecurityLevel)VALUES
('1','Carol','1234','carolcousins@notmail.com','What was the name of your first pet?','Spot','1'),
('2','Fred','1234','fredcollins@notmail.com','What was the name of your first pet?','Daisy','1'),
('3','Barry','1234','barryfriday@notmail.com','What was the name of your first pet?','Ralph','1'),
('4','Terry','1234','terrypike@notmail.com','What was the name of your first pet?','Boss','1'),
('5','Mary','1234','marymay@notmail.com','What was the name of your first pet?','Hampton','1'),
('6','Angie','1234','angiejune@notmail.com','What was the name of your first pet?','Carmin','1'),
('7','Pat','1234','patparkin@notmail.com','What was the name of your first pet?','Rover','1'),
('8','Larry','1234','larryfint@notmail.com','What was the name of your first pet?','Patsy','1'),
('9','Hazel','1234','hpiper@notmail.com','What was the name of your first pet?','Stitch','1'),
('10','Barney','1234','barneyrubble@notmail.com','What was the name of your first pet?','Mimi','1'),
('11','Paul','1234','paulpine@notmail.com','What was the name of your first pet?','Puffball','1'),
('12','Scott','1234','scott.wachal@robertsoncollege.net','What was the name of your first pet?','Bobo','1'),
('12','Scott','2345','scott.wachal@robertsoncollege.net','What was the name of your first pet?','Bobo','2'),
('13','Deidre','1234','deidre.steenman@robertsoncollege.net','What was the name of your first pet?','Skippy','1');
GO