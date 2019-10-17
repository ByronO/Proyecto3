USE B65186_Proyecto3
GO
/****** Object:  StoredProcedure [COURSE].[spTest_GetAll]    Script Date: 9/30/2019 8:59:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		BYRON
-- Create date: 2019-09-26
-- Description:	RETURN ALL DATA
-- =============================================
----ALTER PROCEDURE [sp_GetClients_B65186]
----	@table varchar(50),
----	@date1 DATE,
----	@date2 DATE,
----	@OUTPUT_ISSUCCESSFULL INT OUTPUT,
----	@OUTPUT_STATUS VARCHAR(25) OUTPUT

----AS
----BEGIN
----	SET NOCOUNT ON;

----	SET @OUTPUT_ISSUCCESSFULL = 0
----	SET @OUTPUT_STATUS = 'ERROR'
----	BEGIN TRY 

----		IF @table = 'client'
----		BEGIN
----			SELECT
----			 [id], [name], [lastname], [date]
----			INTO TEMP 
----			FROM CLIENT WHERE EXTRACTED  = 0 AND date BETWEEN @date1 and @date2

----			UPDATE CLIENT
----			SET extracted = 1 FROM CLIENT JOIN TEMP ON CLIENT.ID = TEMP.ID

----			SELECT 
----			 C.[id], C.[name], C.[lastname], C.[date]
----			FROM CLIENT C JOIN TEMP ON C.ID = TEMP.ID

----			DROP TABLE TEMP
	
----		END 
	
----		IF @table = 'address'
----		BEGIN
----			SELECT [id], [idClient],
----			CONVERT(varchar, DecryptByKey(address)) AS address, [date]
----			INTO TEMP 
----			FROM ADDRESS WHERE extracted  = 0 AND date BETWEEN @date1 and @date2

----			UPDATE ADDRESS
----			SET extracted = 1 FROM ADDRESS JOIN TEMP ON ADDRESS.ID = TEMP.ID

----			OPEN SYMMETRIC KEY SSN_Key_01  
----			DECRYPTION BY CERTIFICATE MyCertificate1;  
----			SELECT 
----			 A.[id], A.[idClient], 
----			CONVERT(varchar, DecryptByKey(a.address)) AS address, A.[date]
----			FROM ADDRESS A JOIN TEMP ON A.ID = TEMP.ID

----			DROP TABLE TEMP
----		END

----		IF @table = 'cards'
----		BEGIN 
----			SELECT
----			 [id], [idClient], 
----			CONVERT(varchar, DecryptByKey(cardNumber)) AS cardNumber,[date]
----			INTO TEMP 
----			FROM cards WHERE EXTRACTED  = 0 AND date BETWEEN @date1 and @date2

----			UPDATE cards
----			SET extracted = 1 FROM cards JOIN TEMP ON cards.ID = TEMP.ID

----			OPEN SYMMETRIC KEY SSN_Key_01  
----			DECRYPTION BY CERTIFICATE MyCertificate1;  
----			SELECT 
----			 C.[id], C.[idClient],
----			CONVERT(varchar, DecryptByKey(C.cardNumber)) AS cardNumber, C.[date]
----			FROM cards C JOIN TEMP ON C.ID = TEMP.ID

----			DROP TABLE TEMP
----		END

----		IF @table = 'emails'
----		BEGIN
			
----			SELECT
----				[id], [idClient],
----			CONVERT(varchar, DecryptByKey(email)) AS email,[date] 
----			INTO TEMP 
----			FROM emails WHERE EXTRACTED  = 0 AND date BETWEEN @date1 and @date2

----			UPDATE emails
----			SET extracted = 1 FROM emails JOIN TEMP ON emails.ID = TEMP.ID


----			OPEN SYMMETRIC KEY SSN_Key_01  
----			DECRYPTION BY CERTIFICATE MyCertificate1;  
----			SELECT 
----			 C.[id], C.[idClient],
----			CONVERT(varchar, DecryptByKey(c.email)) AS email, C.[date]
----			FROM emails C JOIN TEMP ON C.ID = TEMP.ID

----			DROP TABLE TEMP
----		END

----		IF @table = 'phones'
----		BEGIN
			
----			SELECT
----				[id], [idClient],
----			CONVERT(varchar, DecryptByKey(phone)) AS email ,[date] 
----			INTO TEMP 
----			FROM phones WHERE EXTRACTED  = 0 AND date BETWEEN @date1 and @date2

----			UPDATE phones
----			SET extracted = 1 FROM phones JOIN TEMP ON phones.ID = TEMP.ID


----			OPEN SYMMETRIC KEY SSN_Key_01  
----			DECRYPTION BY CERTIFICATE MyCertificate1;  
----			SELECT 
----			 C.[id], C.[idClient],
----			CONVERT(varchar, DecryptByKey(c.phone)) AS phones, C.[date]
----			FROM phones C JOIN TEMP ON C.ID = TEMP.ID

----			DROP TABLE TEMP
----		END

----		IF @table = 'sales'
----		BEGIN
----			SELECT
----			 [id], [idClient], [idCard], [idAdderess], [amount], [date]
----			INTO TEMP 
----			FROM sales WHERE EXTRACTED  = 0 AND date BETWEEN @date1 and @date2

----			UPDATE sales
----			SET extracted = 1 FROM sales JOIN TEMP ON sales.ID = TEMP.ID

----			SELECT 
----			 c.[id], c.[idClient], c.[idCard], c.[idAdderess], c.[amount], c.[date]
----			FROM sales C JOIN TEMP ON C.ID = TEMP.ID

----			DROP TABLE TEMP
	
----		END 
	
	
----		SET @OUTPUT_STATUS = 'SUCCESSFUL'
----		SET @OUTPUT_ISSUCCESSFULL = 1
----	END TRY
----	BEGIN CATCH
----		SET @OUTPUT_STATUS = @OUTPUT_STATUS + ' ' + ERROR_MESSAGE() 
----		SET @OUTPUT_ISSUCCESSFULL = 1
----		RAISERROR(@OUTPUT_STATUS,16,1)

----	END CATCH

   
----END



--exec [sp_setMigrated_B65186] @table='client', @OUTPUT_ISSUCCESSFULL=0, @OUTPUT_STATUS=0

--CREATE PROCEDURE [sp_setMigrated_B65186]
--	@table varchar(50),
--	@OUTPUT_ISSUCCESSFULL INT OUTPUT,
--	@OUTPUT_STATUS VARCHAR(25) OUTPUT

--AS
--BEGIN
--	SET NOCOUNT ON;

--	SET @OUTPUT_ISSUCCESSFULL = 0
--	SET @OUTPUT_STATUS = 'ERROR'
--	BEGIN TRY 

--		IF @table = 'client'
--		BEGIN
--			UPDATE client
--			SET migrated = 1
--			WHERE extracted = 1

--		END 
	
--		IF @table = 'address'
--		BEGIN
--			UPDATE ADDRESS
--			SET migrated = 1
--			WHERE extracted = 1

			
--		END

--		IF @table = 'cards'
--		BEGIN 
			
--			UPDATE cards
--			SET migrated = 1
--			WHERE extracted = 1

--		END

--		IF @table = 'emails'
--		BEGIN
--			UPDATE emails
--			SET migrated = 1
--			WHERE extracted = 1

--		END

--		IF @table = 'phones'
--		BEGIN
			
--			UPDATE phones
--			SET migrated = 1
--			WHERE extracted = 1

--		END

--		IF @table = 'sales'
--		BEGIN
--			UPDATE sales
--			SET migrated = 1
--			WHERE extracted = 1

--		END 

--		SET @OUTPUT_STATUS = 'SUCCESSFUL'
--		SET @OUTPUT_ISSUCCESSFULL = 1
--	END TRY
--	BEGIN CATCH
--		SET @OUTPUT_STATUS = @OUTPUT_STATUS + ' ' + ERROR_MESSAGE() 
--		SET @OUTPUT_ISSUCCESSFULL = 1
--		RAISERROR(@OUTPUT_STATUS,16,1)

--	END CATCH

   
--END

--SELECT * FROM client

--CREATE PROCEDURE sp_deleteMigratedData_B65186
--AS
--BEGIN
--	BEGIN TRY
--	BEGIN TRAN
--		DELETE FROM address 
--		WHERE MIGRATED = 1

--		DELETE FROM phones 
--		WHERE MIGRATED = 1

--		DELETE FROM emails 
--		WHERE MIGRATED = 1

--		DELETE FROM cards 
--		WHERE MIGRATED = 1

--		COMMIT
--	END TRY
--	BEGIN CATCH

--		ROLLBACK
--	END CATCH

--END

--CREATE PROCEDURE sp_deleteData_B65186
--	@table varchar(50)
--AS
--BEGIN
--	BEGIN TRY
--	BEGIN TRAN
--		IF @table = 'client'
--		BEGIN
--			DELETE FROM client 
--			WHERE MIGRATED = 1

--		END 

--		IF @table = 'sales'
--		BEGIN
--			DELETE FROM sales 
--			WHERE MIGRATED = 1
--		END 

--		COMMIT
--	END TRY
--	BEGIN CATCH

--		ROLLBACK
--	END CATCH

--END