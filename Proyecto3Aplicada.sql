DROP DATABASE B65186_Proyecto3
CREATE DATABASE B65186_Proyecto3
USE B65186_Proyecto3

CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = '123bor!@#$789';  
--DROP MASTER KEY

CREATE CERTIFICATE MyCertificate1
   WITH SUBJECT = 'Secret info';  
GO  
--drop CERTIFICATE MyCertificate1

CREATE SYMMETRIC KEY SSN_Key_01  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE MyCertificate1;  
GO  
--drop SYMMETRIC KEY SSN_Key_01 

CREATE TABLE client
(
	id int PRIMARY KEY IDENTITY(1,1),
	name varchar (50),
	lastname varchar (50),
	migrated int,
	extracted int,
	[date] date
)



CREATE TABLE phones
(
	id int PRIMARY KEY IDENTITY(1,1),
	idClient INT FOREIGN KEY REFERENCES client (id),
	phone varbinary(150),
	migrated int,
	extracted int,
	[date] date
)

CREATE TABLE address
(
	id int PRIMARY KEY IDENTITY(1,1),
	idClient INT FOREIGN KEY REFERENCES client (id),
	address varbinary(150),
	migrated int,
	extracted int,
	[date] date
)

CREATE TABLE emails
(
	id int PRIMARY KEY IDENTITY(1,1),
	idClient INT FOREIGN KEY REFERENCES client (id),
	email varbinary(150),
	migrated int,
	extracted int,
	[date] date
)

CREATE TABLE cards
(
	id int PRIMARY KEY IDENTITY(1,1),
	idClient INT FOREIGN KEY REFERENCES client (id),
	cardNumber varbinary(150),
	migrated int,
	extracted int,
	[date] date
)

CREATE TABLE sales
(
	id int PRIMARY KEY IDENTITY(1,1),
	idClient INT FOREIGN KEY REFERENCES client (id),
	idCard INT FOREIGN KEY REFERENCES cards (id),
	idAdderess INT FOREIGN KEY REFERENCES address (id),
	amount int,
	migrated int,
	extracted int,
	[date] date

)

DECLARE @CONT int = 0

WHILE @CONT < 200 BEGIN
	--INSERT INTO client values ('Jose', 'Rodriguez Arias', 0,0, '2019-7-15')

	--OPEN SYMMETRIC KEY SSN_Key_01  
	--   DECRYPTION BY CERTIFICATE MyCertificate1;  
	--INSERT INTO phones values (1, EncryptByKey(Key_GUID('SSN_Key_01'),'84868486'), 0,0, '2019-7-15')


	--OPEN SYMMETRIC KEY SSN_Key_01  
	--   DECRYPTION BY CERTIFICATE MyCertificate1;  
	--INSERT INTO address values (1, EncryptByKey(Key_GUID('SSN_Key_01'),'El Poro'), 0,0, '2019-7-15')


	--OPEN SYMMETRIC KEY SSN_Key_01  
	--   DECRYPTION BY CERTIFICATE MyCertificate1;  
	--INSERT INTO emails values (1, EncryptByKey(Key_GUID('SSN_Key_01'),'jose@gmail.com'), 0,0, '2019-7-15')


	--OPEN SYMMETRIC KEY SSN_Key_01  
	--   DECRYPTION BY CERTIFICATE MyCertificate1;  
	--INSERT INTO cards values (1, EncryptByKey(Key_GUID('SSN_Key_01'),'212321232321'), 0,0, '2019-7-15')

	INSERT INTO sales values (250,90,45,1000000, 0,0, '2019-7-15')

	SET @CONT = @CONT + 1
END

select * from client

OPEN SYMMETRIC KEY SSN_Key_01  
   DECRYPTION BY CERTIFICATE MyCertificate1;  

SELECT 
*,
CONVERT(varchar, DecryptByKey(phone)) AS [Decrypted phone]
    FROM phones


UPDATE cards SET extracted = 0
UPDATE emails SET extracted = 0
UPDATE phones SET extracted = 0
UPDATE sales SET extracted = 0
UPDATE address SET extracted = 0
UPDATE client SET extracted = 0

UPDATE cards SET migrated = 0
UPDATE emails SET migrated = 0
UPDATE phones SET migrated = 0
UPDATE sales SET migrated = 0
UPDATE address SET migrated = 0
UPDATE client SET migrated = 0

select * from cards
select * from emails
select * from phones
select * from address
select * from sales
select * from client
