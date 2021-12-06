use DB_COURSE
SELECT * FROM Versions;

GO
-- a) Alter the column type of the match_date column from the Matches table.
CREATE PROCEDURE alterColumnTable AS
BEGIN
	ALTER TABLE Matches
	ALTER COLUMN match_date nvarchar(50)
	PRINT 'The type of the match_date column has been changed to nvarchar.'
END
GO
-- The reverse operation for point a)
CREATE PROCEDURE undoAlterColumnTable AS
BEGIN
	ALTER TABLE Matches
	ALTER COLUMN match_date date
	PRINT 'The type of the match_date has been restored to date.'
END
GO

-- b) Add a new column to a table
CREATE PROCEDURE addColumn AS
BEGIN
	ALTER TABLE Players
	ADD BirthPlace nvarchar(50)
	PRINT 'Birth Place column has been added to the Players table.'
END
GO
-- The reverse operation for point b)
CREATE PROCEDURE removeColumn AS
BEGIN
	ALTER TABLE Players
	DROP COLUMN BirthPlace
	PRINT 'Birth Place column has been removed from the Players table.'
END
GO

-- c) Add a default constraint
CREATE PROCEDURE addDefaultConstraint AS
BEGIN
	ALTER TABLE Tickets
	ADD CONSTRAINT df_Price
	DEFAULT 30 FOR price
	PRINT 'A default constraint has been added on the price column of the Tickets table.'
END
GO
-- The reversed operation for point c)
CREATE PROCEDURE removeDefaultConstraint AS
BEGIN
	ALTER TABLE Tickets
	DROP CONSTRAINT df_Price
	PRINT 'The default constraint has been deleted.'
END
GO

-- d) Remove a primary key constraint 
CREATE PROCEDURE removePrimaryKey AS
BEGIN
	ALTER TABLE Fans
	DROP CONSTRAINT Pk_Fans
	print 'The primary key constraint for Fans has been removed.'
END
GO
-- The reversed operation for point d)
CREATE PROCEDURE addPrimaryKey AS
BEGIN
	ALTER TABLE Fans
	ADD CONSTRAINT Pk_Fans
	PRIMARY KEY (CNP)
	print 'The primary key constraint for Fans has been restored.'
END
GO

-- e) Remove a candidate key
CREATE PROCEDURE removeCandidateKey AS
BEGIN
	ALTER TABLE Players
	DROP CONSTRAINT UQ_nickname
	print 'The candidate key constraint for nickname in Players has been removed.'
END
GO
-- The reversed operation for e)
CREATE PROCEDURE addCandidateKey AS
BEGIN
	ALTER TABLE Players
	ADD CONSTRAINT UQ_nickname
	UNIQUE (nickname)
	print 'The candidate key constraint for nickname in Players has been restored.'
END
GO

-- f) Remove a foreign key constraint
CREATE PROCEDURE removeForeignKey AS
BEGIN
	ALTER TABLE Inventories
	DROP CONSTRAINT FK_Player
	print 'The foreign key has been deleted.'
END
GO
-- The reversed operation for f)
CREATE PROCEDURE addForeignKey AS
BEGIN
	ALTER TABLE Inventories
	ADD CONSTRAINT FK_Player
	FOREIGN KEY (player_id) references Players(player_id)
	print 'The foreign key has been added back.'
END
GO
-- g) create a table
CREATE PROCEDURE createTable AS
BEGIN
	CREATE TABLE Standings (
		team_id integer primary key,
		place integer,
		constraint Fk_team foreign key (team_id) references Teams(team_id) 
	)
	PRINT 'Standings Table has been created'
END
GO
-- The reversed operation for point g)
CREATE PROCEDURE dropTable AS
BEGIN
	DROP TABLE Standings;
	PRINT 'Standings Table has been dropped.'
END
GO

CREATE TABLE Versions(
	databaseVersion int unique not null,
	procedureName nvarchar(50) default '',
	undo_procedureName nvarchar(50) default '',
	currentVersion int default 0,
)
GO
INSERT INTO Versions (databaseVersion, currentVersion) VALUES (0, 1)
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (1, 'alterColumnTable', 'undoAlterColumnTable');
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (2, 'addColumn', 'removeColumn');
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (3, 'addDefaultConstraint', 'removeDefaultConstraint');
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (4, 'removePrimaryKey', 'addPrimaryKey');
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (5, 'removeCandidateKey', 'addCandidateKey');
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (6, 'removeForeignKey', 'addForeignKey');
INSERT INTO Versions (databaseVersion, procedureName, undo_procedureName) VALUES (7, 'createTable', 'dropTable');
GO

EXEC alterColumnTable
EXEC undoAlterColumnTable
EXEC addColumn
EXEC removeColumn
EXEC addDefaultConstraint
EXEC removeDefaultConstraint
EXEC removePrimaryKey
EXEC addPrimaryKey
EXEC removeCandidateKey
EXEC addCandidateKey
EXEC removeForeignKey
EXEC addForeignKey
EXEC createTable
EXEC dropTable
GO

-- goToVersion procedure
CREATE OR ALTER PROCEDURE main(@requiredVersion INT) AS
BEGIN
	-- IF the required version is not one of [0,1,2..., 7], throw an error. 
	IF @requiredVersion < 0 OR @requiredVersion > 7
		BEGIN
			RAISERROR ('You requested an invalid version', 10, 1)
		END
	ELSE
		BEGIN
		DECLARE @currentVersion INT
		SELECT @currentVersion=databaseVersion
		FROM Versions V
		WHERE V.currentVersion = 1

		PRINT @currentVersion
		-- if the required version is the same as the current version, send a notification.
		IF @currentVersion = @requiredVersion
			BEGIN
				RAISERROR ('The version you requested is the current version', 10, 1)
			END
		ELSE
			BEGIN
				UPDATE Versions SET currentVersion=0 WHERE databaseVersion=@currentVersion
				IF @currentVersion < @requiredVersion
					BEGIN
						WHILE @currentVersion < @requiredVersion
							BEGIN
								DECLARE @procedureName nvarchar(50)
								SET @currentVersion = @currentVersion + 1
								-- get the procedure of the current version
								SELECT @procedureName=procedureName 
								FROM Versions
								WHERE databaseVersion=@currentVersion
								-- execute the procedure
								EXEC @procedureName
							END
					END
				ELSE
					BEGIN
						WHILE @currentVersion > @requiredVersion
							BEGIN
								DECLARE @undoProcedureName nvarchar(50)
								-- get the undo procedure of the current version
								SELECT @undoProcedureName=undo_procedureName 
								FROM Versions
								WHERE databaseVersion=@currentVersion
								SET @currentVersion = @currentVersion - 1
								-- execute the procedure
								EXEC @undoProcedureName
							END
					END
				UPDATE Versions SET currentVersion=1 where databaseVersion=@requiredVersion
			END
		END
END
GO

EXEC main 0