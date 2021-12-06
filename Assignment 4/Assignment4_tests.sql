use DB_COURSE
DROP TABLE IF EXISTS ForeignKeys;
DROP TABLE IF EXISTS PrimaryKeys;

-- this table will keep the foreign keys and the table they are in.
CREATE TABLE ForeignKeys (
	id int primary key identity(1, 1),
	tblName varchar(30) not null,
	foreign_key varchar(30) not null,
);
-- this table will keep the primary keys and their corresponding table.
CREATE TABLE PrimaryKeys (
	id int primary key identity(1, 1),
	tblName varchar(30) not null,
	primary_key varchar(30) not null,
)

INSERT INTO PrimaryKeys (tblName, primary_key) values ('Tournaments', 'tournament_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Fans', 'CNP');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Map', 'map_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Tickets', 'ticket_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Arenas', 'arena_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Bonus', 'bonus_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Teams', 'team_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Items', 'item_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Inventories', 'inventory_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Weapon_Cases', 'case_id');
INSERT INTO PrimaryKeys (tblName, primary_key) values ('Players', 'player_id');

BEGIN
	DECLARE @tblName varchar(30), @keyName varchar(30)

	DECLARE ForeignKeysCursor CURSOR FOR
	-- this select will return the pairs of foreign keys and their tables.
	SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS b JOIN 
					INFORMATION_SCHEMA.KEY_COLUMN_USAGE a 
					ON a.CONSTRAINT_CATALOG = b.CONSTRAINT_CATALOG AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

	OPEN ForeignKeysCursor
	FETCH ForeignKeysCursor INTO @tblName, @keyName

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		INSERT INTO ForeignKeys (tblName, foreign_key) values (@tblName, @keyName)
		FETCH ForeignKeysCursor INTO @tblName, @keyName
	END


	CLOSE ForeignKeysCursor
	DEALLOCATE ForeignKeysCursor
END


INSERT INTO Tables (Name) values ('Teams');--1
INSERT INTO Tables (Name) values ('Fans'); --2
INSERT INTO Tables (Name) values ('Vip_Bonus');--3 
INSERT INTO Tables (Name) values ('Bonus');--4 
INSERT INTO Tables (Name) values ('Matches');--5
INSERT INTO Tables (Name) values ('Tickets');--6
INSERT INTO Tables (Name) values ('Map');--7
INSERT INTO Tables (Name) values ('Tournaments');--8
INSERT INTO Tables (Name) values ('Arenas');--9
INSERT INTO Tables (Name) values ('Players');--10
INSERT INTO Tables (Name) values ('Items');--11
INSERT INTO Tables (Name) values ('Inventories');--12
INSERT INTO Tables (Name) values ('Item_Inventory');--13
INSERT INTO Tables (Name) values ('Weapon_Cases');--14
INSERT INTO Tables (Name) values ('Drop_Case');--15
go
-- Creating the views
-- A view with a select statement that operates on only one table
-- and return all the old players.
CREATE OR ALTER VIEW Male_Fans AS
SELECT * FROM Fans F
WHERE F.CNP LIKE '1%' OR F.CNP LIKE '5%';
go
-- A view that operates on 2 tables and return all the active pro players.
CREATE OR ALTER VIEW Active_Teams AS
SELECT T.* FROM
Teams T 
WHERE T.team_id in (
	SELECT M.team_id_1
	FROM Matches M)
	OR T.team_id in (
	SELECT M.team_id_2
	FROM Matches M
	)
go
-- A view that operates on 2 tables with a group by clause that returns all the available prices that are
-- present in the data base
CREATE OR ALTER VIEW Tickets_Prices AS 
SELECT COUNT(T.price) as count, T.price
FROM Tickets T INNER JOIN Vip_Bonus VB
ON T.ticket_id = VB.ticket_id
GROUP BY T.price
go

INSERT INTO Views (Name) values ('Male_Fans');
INSERT INTO Views (Name) values ('Active_Teams');
INSERT INTO Views (Name) values ('Tickets_Prices');

-- Setting up the Tests table
INSERT INTO Tests(Name) values ('Test Male_Fans')
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (1, 2, 3, 1);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (1, 6, 30, 3);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (1, 3, 3, 2);
INSERT INTO TestViews(TestId, ViewId) VALUES (1, 1)


INSERT INTO Tests(Name) values ('Test Active Teams')
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 1, 125, 15);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 5, 5, 1);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 8, 5, 8);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 9, 5, 9);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 12, 30, 13);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 14, 5, 12);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 15, 2, 3);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 13, 10, 2);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 7, 5, 10);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 2, 5, 6);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 3, 5, 4);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 4, 5, 5);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 6, 30, 7);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 10, 50, 14);
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (2, 11, 50, 11);
INSERT INTO TestViews(TestId, ViewId) VALUES (2, 2)


INSERT INTO Tests(Name) values ('Test Tickets Prices')
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (3, 2, 10, 1)
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (3, 3, 10, 2)
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (3, 4, 10, 3)
INSERT INTO TestTables(TestId, TableId, NoOfRows, Position) values (3, 6, 50, 4)

INSERT INTO TestViews(TestId, ViewId) VALUES (3, 3)

SELECT * FROM Views
SELECT * FROM Tables
SELECT * FROM Tests
SELECT * FROM TestTables
SELECT * FROM TestViews