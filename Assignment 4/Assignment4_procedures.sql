USE DB_COURSE
GO

CREATE OR ALTER PROCEDURE INSERT_DATA (@table_name varchar(20))
AS
-- DECLARATION OF THE REQUIRED VARIABLES
	DECLARE @ColumnName varchar(30), @DataType varchar(30), @Values varchar(200), @ColumnNames varchar(200);
	DECLARE @Min INT = 1, @Max INT = 12500;
	DECLARE @DateStart VARCHAR(15) = '2001-01-01', @DateEnd VARCHAR(15) = '2022-01-01'

	SET @Values = 'insert into ' + @table_name + ' values ('
	-- DECLARATION OF THE CURSOR
	DECLARE TableCursor CURSOR FOR	
	SELECT COLUMN_NAME, DATA_TYPE
	FROM DB_COURSE.INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = @table_name
	-- OPEN THE CURSOR
	OPEN TableCursor
	-- FETCH THE FIRST DATA
	FETCH TableCursor INTO @ColumnName, @DataType

	WHILE @@FETCH_STATUS = 0
	BEGIN
	-- check if the data type was int
		IF @DataType = 'int'
		BEGIN
			-- check if it is a foreign key
			DECLARE @isForeignKey nvarchar(20) = '';

			SELECT @isForeignKey = F.tblName from ForeignKeys F WHERE F.foreign_key = @ColumnName
			
			-- if the current column is not a foreign key , we add the values
			IF @isForeignKey = ''
			BEGIN
				SET @Values = @Values + CONVERT(varchar(10), FLOOR(@Min + RAND() * (@Max - @Min)));
			END

			ELSE
			-- if the current column is a foreign key, we have to make sure that we insert valid data.
			BEGIN
				DECLARE @referencedTbl nvarchar(20) = '';
				-- we also have to make sure that we do not pick a primary key
				-- hardcode for the Matches table because we have foreign keys for the Teams table
				IF @table_name = 'Matches' AND (@ColumnName = 'team_id_1' or @ColumnName = 'team_id_2')
				BEGIN
					SET @ColumnName = 'team_id';
				END


				SELECT @referencedTbl = P.tblName from PrimaryKeys P where P.tblName != @table_name AND P.primary_key = @ColumnName
				-- if the referenced table is empty, it means that it is the primary key
				IF @referencedTbl = '' 
				BEGIN
				-- if this is a primary key, we have to make sure that it won't be duplicated.
					DECLARE @randomPrimaryKey int, @STATUS INT = 1, @checkPK nvarchar (200);
					
					SET @randomPrimaryKey = FLOOR(@Min + RAND() * (@Max - @Min));
					SET @checkPK = 'SELECT @sts=COUNT(*) FROM ' + @table_name + ' WHERE ' + @ColumnName + ' = ' + 
						CONVERT(varchar(10), @randomPrimaryKey);
					EXECUTE sp_executesql @checkPK, N'@sts INT OUTPUT', @sts=@STATUS OUTPUT;

					WHILE @STATUS != 0
					BEGIN
						SET @randomPrimaryKey = FLOOR(@Min + RAND() * (@Max - @Min));
						SET @checkPK = 'SELECT @sts=COUNT(*) FROM ' + @table_name + ' WHERE ' + @ColumnName + ' = ' + 
							CONVERT(varchar(10), @randomPrimaryKey);
						EXECUTE sp_executesql @checkPK, N'@sts INT OUTPUT', @sts=@STATUS OUTPUT;
					END

					SET @Values = @Values + CONVERT(varchar(10), @randomPrimaryKey);
				END
				-- otherwise, we pick a random value from the referenced table and add it
				ELSE 
				-- WE ALSO have to make sure that if the foreign key in a table is unique, we insert a unique one
				BEGIN
					DECLARE @randomValue int;
					DECLARE @SqlString nvarchar(200), @uniqueColumn int = 0, @uniqueSqlString nvarchar(250);
					-- check if the column has a unique value.
					SET @uniqueSqlString = 'SELECT @uniq=count(*) FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE A 
						INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS B
						ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME WHERE B.CONSTRAINT_TYPE = ' + '''' + 'UNIQUE' + '''' + 
						' AND A.COLUMN_NAME = ' + '''' + @ColumnName + '''';
					EXECUTE sp_executesql @uniqueSqlString, N'@uniq INT OUTPUT', @uniq=@uniqueColumn OUTPUT;
					SET @SqlString = 'SELECT TOP 1 @columnReq=' + @ColumnName + ' FROM ' + @referencedTbl + ' ORDER BY NEWID()'
					EXECUTE sp_executesql @SqlString, N'@columnReq int OUTPUT', @columnReq=@randomValue OUTPUT;
					
					-- IF THE column does not require a unique value we add a random value from the referenced table
					IF @uniqueColumn = 0
					BEGIN
						SET @Values = @Values + CONVERT(varchar(10), @randomValue);
					END
					-- otherwise we check using a while loop the uniqueness to ensure that valid data is inserted.
					ELSE 
					BEGIN
						DECLARE @UNIQ_STATUS INT = 1;
						SET @uniqueSqlString = 'SELECT @uniq=count(*) FROM ' + @table_name + ' WHERE ' + @ColumnName + '=' + CONVERT(varchar(10),@randomValue);
						EXECUTE sp_executesql @uniqueSqlString, N'@uniq int OUTPUT', @uniq=@UNIQ_STATUS OUTPUT;

						-- we will iterate until we get a unique value.
						WHILE @UNIQ_STATUS = 1
						BEGIN
						-- we get a new foreign key value at each step in the loop
							SET @SqlString = 'SELECT TOP 1 @columnReq=' + @ColumnName + ' FROM ' + @referencedTbl + ' ORDER BY NEWID()'
							EXECUTE sp_executesql @SqlString, N'@columnReq int OUTPUT', @columnReq=@randomValue OUTPUT;
						-- we check if the new foreign key is unique
							SET @uniqueSqlString = 'SELECT @uniq=count(*) FROM ' + @table_name + ' WHERE ' + @ColumnName + '=' + CONVERT(varchar(10),@randomValue);
							EXECUTE sp_executesql @uniqueSqlString, N'@uniq int OUTPUT', @uniq=@UNIQ_STATUS OUTPUT;
						END

						SET @Values = @Values + CONVERT(varchar(10), @randomValue);
					END
				END

			END
		END
	-- check if the data type was date 
		IF @DataType = 'date'
			BEGIN
				Declare @RandomDate DATE;
				SELECT @RandomDate = DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@DateStart,@DateEnd)),@DateStart);
				SET @Values = @Values + 'CAST(''' + CONVERT(VARCHAR(15), @RandomDate) + ''' AS DATE)';
			END
	-- check if the data type was varchar
		IF @DataType = 'varchar'
			BEGIN
				DECLARE @RandomString varchar(20);
				SET @RandomString = CONVERT(varchar(60), NEWID());
				SET @Values = @Values + '''' +  @RandomString + '''';
			END

		FETCH TableCursor INTO @ColumnName, @DataType
	-- if the last fetch did fetch us new data, it means that there are more column and we have to add a , otherwise we close the paranthesis
		IF @@FETCH_STATUS = 0
		BEGIN
			SET @Values = @Values + ', ';
		END
		ELSE 
		BEGIN
			SET @Values = @Values + ')';
		END
	END
	EXEC (@Values)

	CLOSE TableCursor
	DEALLOCATE TableCursor
GO

CREATE OR ALTER PROCEDURE DELETE_DATA (@table_name varchar(20))
AS
	DECLARE @SqlString nvarchar(100) = 'DELETE FROM ' + @table_name;
	EXEC (@SqlString)
GO

CREATE OR ALTER PROCEDURE INSERT_ALL_DATA (@test_id int, @runtest_id int)
AS
	DECLARE @tableId varchar(20), @noOfRows int;
	-- INSERTING data in all the tables that are involved in a certain test.
	DECLARE TableCursor1 CURSOR FOR 
	SELECT T.TableId, T.NoOfRows FROM TestTables T
	WHERE T.TestId = @test_id
	ORDER BY T.Position DESC
	-- opening the cursor
	OPEN TableCursor1
	FETCH TableCursor1 INTO @tableId, @noOfRows
	-- insert data in the required tables
	WHILE @@FETCH_STATUS = 0
	BEGIN
	-- get the table name
		DECLARE @tableName varchar(20);
		SELECT @tableName=Name from Tables T where TableID=@tableId;
		-- insert the required number of rows in the specified table.
		-- update the TestRunTable table with the execution time for every table's insertions;
		DECLARE @startAt datetime, @endAt datetime;
		-- create a new record for the table test
		INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt) VALUES (@runtest_id, @tableId, GETDATE(), GETDATE());
		-- get the current time
		SET @startAt = GETDATE();

		WHILE @noOfRows > 0
		BEGIN
			EXEC INSERT_DATA @tableName
			SET @noOfRows = @noOfRows - 1;
		END

		-- get the end time and update the record in the table;
		SET @endAt = GETDATE();
		UPDATE TestRunTables SET StartAt=@startAt, EndAt=@endAt WHERE TestRunID = @runtest_id AND TableID = @tableId;

		-- get the new table and the required number of rows
		FETCH TableCursor1 INTO @tableId, @noOfRows
	END

	CLOSE TableCursor1
	DEALLOCATE TableCursor1
GO

CREATE OR ALTER PROCEDURE DELETE_ALL_DATA (@test_id int)
AS
	DECLARE @tableId varchar(20);
	-- deleting all the data from the tables that are involved in a certain test.
	DECLARE TableCursor CURSOR FOR 
	SELECT T.TableId FROM TestTables T
	WHERE T.TestId = @test_id
	ORDER BY T.Position
	-- open the cursor and fetch the first table
	OPEN TableCursor
	FETCH TableCursor INTO @tableId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	-- for each table call the procedure DELETE_DATA
		DECLARE @tableName varchar(20);
		SELECT @tableName=Name from Tables where TableID=@tableId
		EXEC DELETE_DATA @tableName

		FETCH TableCursor INTO @tableId
	END

	CLOSE TableCursor
	DEALLOCATE TableCursor
GO

CREATE OR ALTER PROCEDURE RUN_VIEWTEST (@test_id int, @runtest_id int)
AS
	DECLARE @startAt datetime, @endAt datetime;
	-- GETTING THE VIEW INFO
	DECLARE @viewID int, @viewName varchar(30), @viewExecution varchar(200);
	SELECT @viewID=ViewID from TestViews where TestId=@test_id;
	SELECT @viewName=Name from Views where ViewID=@viewID;
	-- PREPARING THE SQL STRING TO EXECUTE
	SET @viewExecution = 'SELECT * FROM ' + @viewName;
	INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt) VALUES (@runtest_id, @viewID, GETDATE(), GETDATE());
	-- GET THE START TIME
	SET @startAt = GETDATE();
	EXEC (@viewExecution);
	SET @endAt = GETDATE();
	-- GET THE THE END TIME AND UPDATE THE TABLE;
	UPDATE TestRunViews SET StartAt=@startAt, EndAt=@endAt WHERE TestRunID = @runtest_id AND ViewID = @viewID;

GO

CREATE OR ALTER PROCEDURE RUN_TEST (@test_id int)
AS
	DECLARE @desc varchar(200), @runtest_id int ;
	SELECT @desc=Name from Tests where TestId=@test_id;
	-- insert into test runs a new record the a new test
	INSERT INTO TestRuns (Description, StartAt, EndAt) VALUES (@desc, GETDATE(), GETDATE());
	SELECT TOP 1 @runtest_id=TestRunID from TestRuns ORDER BY TestRunID DESC

	DECLARE @startAt datetime = GETDATE(), @endAt datetime;
	-- exec everything that a test requires.
	EXEC DELETE_ALL_DATA @test_id;
	EXEC INSERT_ALL_DATA @test_id, @runtest_id;
	EXEC RUN_VIEWTEST @test_id, @runtest_id;

	-- getting the ending time;
	SET @endAt = GETDATE();
	UPDATE TestRuns SET StartAt=@startAt, EndAt=@endAt WHERE TestRunId=@runtest_id;
GO

	
EXEC RUN_TEST 2;

SELECT * FROM Tickets;
select * from Fans;

 SELECT * FROM TestRuns;
 SELECT * FROM TestRunTables;
 SELECT * FROM TestRunViews;

 SELECT * FROM Item_Inventory
 SELECT * FROM Items
 SELECT * FROM Inventories
 SELECT * FROM Players
 SELECT * FROM Teams
 SELECT * FROM Weapon_Cases
 SELECT * FROM Map
 SELECT * FROM Drop_Case
 SELECT * FROM Fans

 select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS

DECLARE @SqlString nvarchar(200), @uniqueColumn int = 0, @uniqueSqlString nvarchar(250);
-- check if the column has a unique value.
SET @uniqueSqlString = 'SELECT @uniq=count(*) FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE A 
	INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS B
	ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME WHERE B.CONSTRAINT_TYPE = ' + '''' + 'UNIQUE' + '''' + 
	'AND A.COLUMN_NAME = ' + 'name';
print @uniqueSqlString

EXECUTE sp_executesql @uniqueSqlString, N'@uniq INT OUTPUT', @uniq=@uniqueColumn;
SELECT count(*) FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE A 
						INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS B
						ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME WHERE B.CONSTRAINT_TYPE = 'UNIQUE' AND A.COLUMN_NAME = 'player_id'