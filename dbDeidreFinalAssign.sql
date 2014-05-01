/*****************Start the MASTER DATABASE ****************************************/
USE master
GO
/*****Runs only after the the Database has been run the first time******************/
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
CREATE TABLE tbItemSales
(ItemSaleID INT IDENTITY (1,1)PRIMARY KEY,
Quantity INT,
TotalSale SMALLMONEY,
SaleDate DATETIME,
ItemID INT FOREIGN KEY REFERENCES tbItem(ItemID),
ClientID INT FOREIGN KEY REFERENCES tbClients(ClientID));
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
ItemSaleID INT FOREIGN KEY REFERENCES tbItemSales(ItemSaleID),
ClientID INT FOREIGN KEY REFERENCES tbClients(ClientID),
ErrorTime DATETIME);
GO



/*************************INSERT DATA INTO TABLES***********************************
***********************************************************************************/

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
/*************************ITEM DATA************************************************/
INSERT INTO tbItem (ItemName,Price) VALUES 
('CD',5.00),('Mouse',5.00),('Desktop',300.00),
('Laptop',250.00),('Printer',99.99),('Scanner',53.99),
('Camera',75.99),('PrinterCord',23.99),('PowerBar',29.99);
GO
/*************************SALE DATA FOR TESTING,***********************************/
INSERT INTO tbItemSales(ClientID,ItemID,Quantity,TotalSale,SaleDate)VALUES
('1','1','1','5.00','01/01/2014'),
('1','2','2','10.00','01/01/2014'),
('1','3','1','300.00','01/01/2014'),
('1','4','1','250.00','01/01/2014');

GO
/*************************ERROR DATA FOR TESTING***********************************/
INSERT INTO tbError(ErrorMessage,ClientID,ItemSaleID,ErrorTime)VALUES
('This is Test 1','1','1','01/01/2014'),
('This is Test 2','1','1','01/01/2014');
GO





/*************************STORED PROCEDURES*****************************************
***********************************************************************************/


/*************************GROUP: USERS(2)*******************************************
************************************************************************************
**      File: dbDeidreFinalAssign
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




/****************************GROUP: MISC(2)*****************************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spSignIn - Signing in to Site Regular
**            spGetEmail - Gets email address from customer so they don't have to re-input it
**      Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spSignIn 
(@UserName VARCHAR(15), @Password VARCHAR(50))
AS
BEGIN TRANSACTION
	SELECT * FROM tbUsers WHERE Username = @UserName AND UserPassword = @Password

	-- INSERT ONLY IF the user/password combination is correct!
    IF @@ERROR = 0 AND @@ROWCOUNT > 0
		INSERT INTO tbLogin Values(@UserName,@Password,GETDATE());

	IF @@ERROR = 0
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
GO
/* TEST */
--spSignIn @UserName = Scott, @Password = 1234
--GO
--Select * FROM tbLogin
GO
/**********************************************************************************/
CREATE PROCEDURE spGetEmail
(
@ClientID INT = NULL
)
AS
BEGIN
SELECT Email FROM tbUsers WHERE ClientID = ISNULL(@ClientID,ClientID)
END
GO





/****************************GROUP: SALES(2)****************************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spItemSalesOrder
**			  spSalesByClient
**		Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spItemSalesOrder
(
@ItemID VARCHAR(50),
@Quantity INT,
@TotalSale SMALLMONEY,
@ClientID INT 
)

AS
BEGIN
	BEGIN TRANSACTION
	DECLARE @NewSalesID INT
		
				BEGIN
					INSERT INTO tbItemSales(ClientID,ItemID,TotalSale,SaleDate,Quantity)
					Values(@ClientID,@ItemID,@TotalSale,GETDATE(),@Quantity);
				END
					IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION	
END
GO
------/*TEST Works*/
--spSalesOrder @ClientID = 1, @ItemID = "1", @TotalSale = 5.00, @Quantity = 1
--SELECT * FROM tbSales
GO
/**********************************************************************************/
CREATE PROCEDURE spSalesByClient
(
@UserName VARCHAR(50),
@Password VARCHAR(50)
)
AS
BEGIN
		IF EXISTS(SELECT UserName FROM tbUsers WHERE UserName = @UserName AND UserPassword = @Password AND SecurityLevel = '1')
		SELECT Quantity, ItemName,CONVERT(varchar(20),TotalSale)AS TotalSale, CONVERT(varchar(20),SaleDate)AS SaleDate
		FROM tbSales 
		JOIN tbClients ON tbClients.ClientID = tbSales.ClientID
		JOIN tbUsers ON tbUsers.ClientID = tbClients.ClientID
		WHERE UserName = @UserName
		AND UserPassword = @Password
		
END
--GO
----/*TEST Works*/
--spSalesByClient @UserName = Deidre, @Password = 1234
GO







/*****************************ADMINISTRAION****************************************/
/**********************************************************************************/
GO



/****************************GROUP: ADMIN CLIENTS(4)********************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spClientUpdate - Add or Update a Client Record
**			  spClientSelect - Select all Clients with First and Last name combined
**			  spClientDelete - Deleting Client Records
**			  spClientSelectAll
**      Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
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
/**********************************************************************************/
CREATE PROCEDURE spClientSelectAll
AS
BEGIN
	SELECT * FROM tbClients
END
GO
/**********************************************************************************/
CREATE PROCEDURE spClientSelect
( 
--@UserName VARCHAR(50),
--@Password VARCHAR(50),
@ClientID INT = NULL
)
AS
BEGIN
		--IF EXISTS(SELECT UserName FROM tbUsers WHERE UserName = @UserName AND UserPassword = @Password AND SecurityLevel = '2')
		SELECT * FROM tbClients
        WHERE ClientID = ISNULL(@ClientID,ClientID)			
END

/* TEST Works*/
--spClientSelect will not work without UserName and Password
--GO
--spClientSelect @UserName = Scott, @Password = 2345
GO
/**********************************************************************************/
CREATE PROCEDURE spClientDelete
(
@ClientID INT = NULL,
@ItemSaleID INT = NULL
)
AS
BEGIN
BEGIN TRANSACTION

		 IF NOT EXISTS (SELECT * FROM tbItemSales WHERE ClientID = @ClientID)
			BEGIN
				DELETE FROM tbClients WHERE ClientID = @ClientID  
				DELETE FROM tbUsers WHERE tbUsers.ClientID = @ClientID
			END
		ELSE
		DECLARE @NewErrorID INT 
		   BEGIN
				INSERT INTO tbError(ErrorMessage,ClientID,ItemSaleID,ErrorTime)
				VALUES('ERROR, CLIENT CAN NOT BE DELETED, SALE IN PROGRESS',@ClientID,@ItemSaleID,GETDATE())
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




/****************************GROUP: ADMIN ITEM(3)***********************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spGetItem - Select all records from tbItem 
**			  spAddUpdateItem - Add/Updates a Item Record
**			  spDeleteItem - Deleting Item Records
**      Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spGetItem
AS
BEGIN
	SELECT * FROM tbItem
END
GO
/**********************************************************************************/
CREATE PROCEDURE spAddUpdateItem
(
@ItemID INT = NULL,
@ItemName VARCHAR(50) = NULL,
@Price MONEY = NULL
)
AS
BEGIN
BEGIN TRANSACTION
			IF (@ItemID IS NULL)
				BEGIN
					IF (@ItemName IS NOT NULL)
						BEGIN
						INSERT INTO tbItem(ItemName,Price)
						Values(@ItemName,@Price);
						END
					ELSE
						BEGIN
						PRINT 'ERROR, NO ITEM NAME PROVIDED!'
						END	
				END
			ELSE
				BEGIN
						UPDATE tbItem
						SET ItemName = ISNULL(@ItemName,ItemName),
							Price = ISNULL(@Price,Price)
						WHERE ItemID = @ItemID
				END

		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END
/* TEST Works*/
--spAddUpdateItem @ItemName = "CD", @Price = '5.00'
--GO
--spAddUpdateItem @ItemID = 1, @Price = '14.99'
--GO
--spGetItem
GO
/**********************************************************************************/
CREATE PROCEDURE spDeleteItem
(
@ItemID INT
)
AS
BEGIN
BEGIN TRANSACTION
		
			BEGIN
				DELETE FROM tbItem
				WHERE ItemID = @ItemID;
			END
 		
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END
/* TEST Works*/
--Select * from tbItem
--GO
--spDeleteItem @ItemID = '1' 
--GO
--Select * from tbItem
GO


/****************************GROUP:ADMIN LOGIN/ERROR(4)*****************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spLoginSelect - Select all Login
**			  spLoginDelete - Deleting Login Records
**            spErrorSelect - Views the Errors
**            spErrorDelete - Deletes record of Error
**      Auth: Deidre Steenman
**      Date: 2014
************************************************************************************/
CREATE PROCEDURE spLoginSelect
AS
BEGIN
Select * from tbLogin
END
/* TEST Works*/
--spLoginSelect
GO
/**********************************************************************************/
CREATE PROCEDURE spLoginDelete
(
@LoginID INT 
)
AS
BEGIN
BEGIN TRANSACTION
		
		BEGIN
		DELETE FROM tbLogin
        WHERE LoginID = @LoginID;
        END
 		
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END
/* TEST Works*/
--Select * from tbLogin
--GO
--spLoginDelete @LoginID = '1' 
--GO
--Select * from tbLogin
GO
/**********************************************************************************/
CREATE PROCEDURE spErrorSelect
AS
BEGIN
Select * from tbError
END
/* TEST Works*/
--spErrorSelect
GO
/**********************************************************************************/
CREATE PROCEDURE spErrorDelete
(
@ErrorID INT 
)
AS
BEGIN
BEGIN TRANSACTION
		
		BEGIN
		DELETE FROM tbError
        WHERE ErrorID = @ErrorID;
        END
 		
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END
/* TEST Works*/
--Select * from tbError
--GO
--spErrorDelete @ErrorID = '1' 
--GO
--Select * from tbError
GO



/****************************GROUP: ADMIN SALES(1)**********************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spGetSales
**		Auth: Deidre Steenman
**      Date: 2013
************************************************************************************/
CREATE PROCEDURE spGetSales		
AS
BEGIN
Select SaleID, tbSales.ClientID, FirstName, LastName, Quantity, ItemName, TotalSale, SaleDate 
FROM tbSales
JOIN tbClients
ON tbClients.ClientID = tbSales.ClientID
END
GO




/*************************GROUP: ADMIN USERS(3)*************************************
************************************************************************************
**      File: dbDeidreFinalAssign
**      Desc: spUserUpdate - Update a Users Record
**			  spUserSelect - Selects all Users
**			  spUserDelete - Deletes a User
**			  Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spUserUpdate
(@UserID INT = NULL,
@UserName VARCHAR(15)= NULL,
@UserPassword VARCHAR(8)= NULL,
@Email VARCHAR(50) = NULL,
@SecQuestion VARCHAR(50) = NULL,
@SecAnswer VARCHAR(50) = NULL,
@SecLevel VARCHAR(5)= NULL,
@ClientID INT = NULL
)
AS
BEGIN
BEGIN TRANSACTION
		BEGIN
			UPDATE tbUsers
			SET UserName = ISNULL(@UserName,UserName),
				UserPassword = ISNULL(@UserPassword,UserPassword),
				Email = ISNULL(@Email,Email),
				SecurityQuestion = ISNULL(@SecQuestion,SecurityQuestion),
				SecurityAnswer = ISNULL(@SecAnswer,SecurityAnswer),
				SecurityLevel = ISNULL(@SecLevel,SecurityLevel),
				ClientID = ISNULL(@ClientID,ClientID)
			WHERE UserID = @UserID
		END
				
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END	
--/*TEST WORKS*/
--spUserAddUpdate @UserID = 1, @ClientID = 1,@UserName = "Karol"
GO
/***********************************************************************************/
CREATE PROCEDURE spUserSelect
AS
BEGIN
	SELECT * FROM tbUsers
END
/*TEST Works*/
--spUserSelect
GO
/***********************************************************************************/
CREATE PROCEDURE spUserDelete
(
@UserID INT = UserID,
@ClientID INT = NULL
)
AS
BEGIN
BEGIN TRANSACTION
		
		 IF NOT EXISTS (SELECT * FROM tbSales WHERE ClientID = @ClientID)
			BEGIN
				DELETE FROM tbUsers WHERE UserID = @UserID 
				DELETE FROM tbClients WHERE ClientID = @ClientID
			END

		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END	
GO
Select *  from tbClients
Select *  from tbUsers
Select * from tbError