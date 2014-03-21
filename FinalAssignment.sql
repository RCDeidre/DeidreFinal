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
CREATE TABLE tbItem
(ItemID INT IDENTITY(1,1) PRIMARY KEY,
ItemName VARCHAR(50),
Price VARCHAR(50)
)
GO
CREATE TABLE tbSales
(SaleID INT IDENTITY (1,1)PRIMARY KEY,
Quantity INT,
TotalSale SMALLMONEY,
SaleDate DATETIME,
ClientID INT FOREIGN KEY REFERENCES tbClients(ClientID),
ItemName VARCHAR(50));
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
SaleID INT FOREIGN KEY REFERENCES tbSales(SaleID),
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
/*************************ITEM DATA**********************************************/
INSERT INTO tbItem (ItemName,Price) VALUES 
('CD',5.00),('Mouse',5.00),('Desktop',300.00),
('Laptop',250.00),('Printer',99.99),('Scanner',53.99),
('Camera',75.99),('PrinterCord',23.99),('PowerBar',29.99);
GO
/*************************SALE DATA FOR TESTING,******************************/
INSERT INTO tbSales(ClientID,ItemName,Quantity,TotalSale,SaleDate)VALUES
('1','CD','1','5.00','01/01/2014'),
('1','Mouse','2','10.00','01/01/2014'),
('1','Desktop','1','300.00','01/01/2014'),
('1','Laptop','1','250.00','01/01/2014');

GO
/*************************ERROR DATA FOR TESTING***********************************/
INSERT INTO tbError(ErrorMessage,ClientID,SaleID,ErrorTime)VALUES
('This is Test 1','1','1','01/01/2013'),
('This is Test 2','1','1','01/01/2013');
GO







/*************************GROUP: USERS(2)******************************************
**      File: dbFinal Assignment
**      Desc: spUserPasswordUpdate - Updating User Password
**			  spRegisterClientUser - Inserting Clients into tbClients and tbUsers from the Client Registration form
**      Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spUserPasswordUpdate
(
@UserName VARCHAR(15),
@UserPassword VARCHAR(8),
@NewPassword VARCHAR(8)
)
AS
BEGIN
BEGIN TRANSACTION
		IF EXISTS(SELECT * FROM tbUsers WHERE UserName = @UserName AND UserPassword = @UserPassword)
		BEGIN
		UPDATE tbUsers
		SET UserPassword = @NewPassword
		WHERE UserName = @UserName
		AND UserPassword = @UserPassword
		END
				
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
		
END	
--/*TEST Works*/
--spUserPasswordUpdate @UserName = Scott, @UserPassword = 1234, @NewPassword = 9876
--GO
--Select * from tbUsers
GO
/**********************************************************************************/
CREATE PROCEDURE spRegisterClientUser
(
@fName VARCHAR(50)= FirstName,
@lName VARCHAR(50) = LastName,
@Address VARCHAR(50)= Address,
@City VARCHAR(50) = City,
@PostCode VARCHAR(7) = PostCode,
@Province VARCHAR(2) = Province,
@Phone VARCHAR(12) = Phone,
@UserName VARCHAR(15)= UserName,
@UserPassword VARCHAR(8)= UserPassword,
@Email VARCHAR(50) = Email,
@SecQuest VARCHAR(50) = SecurityQuestion,
@SecAns VARCHAR(50) = SecurityAnswer,
@SecLevel VARCHAR(2) = '1'
)
AS
BEGIN
BEGIN TRANSACTION
		
		DECLARE @NewClientID INT 
		BEGIN
		INSERT INTO tbClients(FirstName,LastName,Address,City,PostCode,Province,Phone)
		Values(@fName,@lName,@Address,@City,@PostCode,@Province,@Phone);
		END
		
		SET @NewClientID = SCOPE_IDENTITY()
		 
		DECLARE @NewUserID INT
		INSERT INTO tbUsers(UserName,ClientID,UserPassword,Email,SecurityQuestion,SecurityAnswer,SecurityLevel)
		Values(@UserName,@NewClientID,@UserPassword,@Email,@SecQuest,@SecAns,@SecLevel);
		
		IF @@ERROR = 0
		BEGIN
			SET @NewClientID = @@IDENTITY
			SET @NewUserID = @@IDENTITY
		END
				
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END
/*TEST Works*/
/*Not sure how to test this but it works on the web site*/
GO




/*****************************ADMINISTRAION*****************************************/
GO
/****************************GROUP: ADMIN CLIENTS(3)********************************
**      File: dbFinal Assignment
**      Desc: spClientUpdate - Add or Update a Client Record
**			  spClientSelect - Select all Clients with First and Last name combined
**			  spClientDelete - Deleting Client Records
**      Auth: Deidre Steenman
**      Date: 2014
************************************************************************************/
CREATE PROCEDURE spClientUpdate
(
@ClientID INT = NULL,
@fName VARCHAR(50) = NULL,
@lName VARCHAR(50) = NULL,
@Address VARCHAR(50) = NULL,
@City VARCHAR(50) = NULL,
@Province VARCHAR(3) = NULL,
@PostCode VARCHAR(7) = NULL,
@Phone VARCHAR(50) = NULL
)
AS
BEGIN
BEGIN TRANSACTION
				BEGIN
						UPDATE tbClients
						SET FirstName = ISNULL(@fName,FirstName),
							LastName= ISNULL(@lName,LastName),
							Address = ISNULL(@Address,Address),
							City = ISNULL(@City,City),
							PostCode = ISNULL(@PostCode,PostCode),
							Province = ISNULL(@Province,Province),
							Phone = ISNULL(@Phone,Phone)		
						WHERE ClientID = @ClientID
				END
								
			IF @@ERROR = 0
			COMMIT TRANSACTION
		    ELSE
			ROLLBACK TRANSACTION
END
/* TEST Works*/
--Select * from tbClients
--GO
--spClientAddUpdate @ClientID = 4, 
--				  @lName = 'Weird', 
--				  @Phone = '306-123-1234'
GO
/***********************************************************************************/
CREATE PROCEDURE spClientSelect
( 
@UserName VARCHAR(50),
@Password VARCHAR(50),
@ClientID INT = NULL
)
AS
BEGIN
		IF EXISTS(SELECT UserName FROM tbUsers WHERE UserName = @UserName AND UserPassword = @Password AND SecurityLevel = '2')
		SELECT * FROM tbClients
        WHERE ClientID = ISNULL(@ClientID,ClientID)			
END

/* TEST Works*/
--spClientSelect will not work without UserName and Password
--GO
--spClientSelect @UserName = Scott, @Password = 2345
GO
/***********************************************************************************/
CREATE PROCEDURE spClientDelete
(
@ClientID INT = NULL,
@SaleID INT = NULL
)
AS
BEGIN
BEGIN TRANSACTION

		 IF NOT EXISTS (SELECT * FROM tbSales WHERE ClientID = @ClientID)
			BEGIN
				DELETE FROM tbClients WHERE ClientID = @ClientID  
				DELETE FROM tbUsers WHERE tbUsers.ClientID = @ClientID
			END
		ELSE
		DECLARE @NewErrorID INT 
		   BEGIN
				INSERT INTO tbError(ErrorMessage,ClientID,SaleID,ErrorTime)
				VALUES('ERROR, CLIENT CAN NOT BE DELETED, SALE IN PROGRESS',@ClientID,@SaleID,GETDATE())
		   END		

		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END	
/* TEST Works*/
--spClientDelete @ClientID = 11 
--GO
--Select * from tbClients
--GO
--Select * from tbError
GO
