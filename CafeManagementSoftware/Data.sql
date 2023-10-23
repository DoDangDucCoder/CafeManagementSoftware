CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO

--Food
--Table
--FoodCategory
--Account
--Bill
--BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'--Trống || có người
)

GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Kter',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 --1: ADMIN && 0: STAFF
)
GO

CREATE TABLE FoodCategory 
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên', 
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa có tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL,
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULl --1: đã thanh toán && 0: chưa thanh toán
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFool INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idBill) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
			(UserName , 
			DisplayName ,
			PassWord ,
			Type
			)
VALUES (N'K9' , --UserName - nvarchar(100)
		N'RongK9' , --DisplayName - nvarchar(100)
		N'1' , --Password - nvarchar(1000)
		1 -- Type - 'int'
		)
INSERT INTO dbo.Account
			(UserName , 
			DisplayName ,
			PassWord ,
			Type
			)
VALUES (N'staff' , --UserName - nvarchar(100)
		N'staff' , --DisplayName - nvarchar(100)
		N'1' , --Password - nvarchar(1000)
		0 -- Type - 'int'
		)
GO

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS
BEGIN
	SElECT *FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'K9' --nvarchar(100)