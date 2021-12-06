use DB_COURSE

-- INSERT STATEMENTS.
-- INSERT INTO MAPS
INSERT INTO Map (map_id, map_name) values (1,'de_dust2');
INSERT INTO Map (map_id, map_name) values (2,'de_mirage');
INSERT INTO Map (map_id, map_name) values (3,'de_nuke');
INSERT INTO Map (map_id, map_name) values (4,'de_vertigo');
INSERT INTO Map (map_id, map_name) values (5,'de_inferno');
-- INSERTING IN THE WEAPON CASES
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (1,'Riptide Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (2,'Snake Bite Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (3,'Fracture Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (4,'Prisma Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (5,'Shattered Web Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (6,'Chroma 3 Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (7,'Chroma Case');
INSERT INTO Weapon_Cases(case_id, case_type) VALUES (8,'Clutch Case');
INSERT INTO Weapon_Cases(case_id, case_type) values (9,'Break Out Case');
-- INSERT INTO DROP
INSERT INTO Drop_Case (case_id, map_id) values (1, 1);
INSERT INTO Drop_Case (case_id, map_id) values (2, 2);
INSERT INTO Drop_Case (case_id, map_id) values (3, 2);
INSERT INTO Drop_Case (case_id, map_id) values (4, 3);
INSERT INTO Drop_Case (case_id, map_id) values (5, 2);
INSERT INTO Drop_Case (case_id, map_id) values (6, 2);
INSERT INTO Drop_Case (case_id, map_id) values (7, 4);
INSERT INTO Drop_Case (case_id, map_id) values (8, 4);
INSERT INTO Drop_Case (case_id, map_id) values (9, 3);
-- INSERTING IN THE ITEMS TABLE
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (1,3, 'factory-new', 'covert', 'AK-47', 'Legion of Anubis', 200);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (2,1, 'battle-scared', 'mil-spec', 'M4A1-S', 'Printstream', 5);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (3,2, 'factory-new', 'restricted', 'AWP', 'Cobra', 100);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (4,5, 'well-worn', 'classified', 'USP-S', 'Printstream', 15);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (5,4, 'minimal-wear', 'mil-spec', 'M4A4', 'Asiimov', 27);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (6,7, 'field-tested', 'classified', 'Glock', 'Fade', 150);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (7,6, 'field-tested', 'mil-spec', 'Butterfly Knife', 'Crimson Web', 100);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (8,8, 'well-worn', 'covert', 'Gloves', 'Rainbow Paradise', 200);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (9,1, 'factory-new', 'covert', 'P90', 'Asiimov', 100);
INSERT INTO Items(item_id, case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (10,8, 'battle-scared', 'covert', 'P250', 'Asiimov', 70);
--INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
--	VALUES (10, 'well-worn', 'covert', 'Karambit Knife', 'Vanilla', 1000);
-- INSERTING INTO TEAMS
INSERT INTO Teams (team_id, team_name, total_winnings) values (1,'Liquid', 1500000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (2,'Fnatic', 4320000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (3,'Astralis', 9547000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (4,'NiP', 2000000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (5,'IBP', 1000000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (6,'Natus Vincere', 5000000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (7,'100 Thieves', 975000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (8,'Cloud9', 1000000);
INSERT INTO Teams (team_id, team_name, total_winnings) values (9,'G2 eSports', 2000000);
-- INSERTING INTO PLAYERS
INSERT INTO Players (player_id, firstName, lastName, age, nickname, team_id) values (1,'Aleksandr', 'Kostyliev', 23, 'simple', 6);
INSERT INTO Players (player_id, firstName, lastName, age, nickname, team_id) values (2,'Vladimir', 'Putin', 22, 'kennyS', 9);
INSERT INTO Players (player_id, firstName, lastName, age, nickname, team_id) values (3,'George', 'Danicico', 19, 'r3k1Nu', 2);
INSERT INTO Players (player_id, firstName, lastName, age, nickname, team_id) values (4,'Olof', 'Kajbjer', 29, 'olofmeister', 5);
INSERT INTO Players (player_id, firstName, lastName, age, nickname, team_id) values (5,'Mihnea', 'Gucci', 31, 'xyp9x', 3);
INSERT INTO Players (player_id, firstName, lastName, age, nickname, team_id) values (6,'Florin', 'Fares', 20, 'device', 8);
INSERT INTO Players (player_id, firstName, lastName, age, nickname) values (7,'Nicolae', 'Guta', 39, 'valoare');
INSERT INTO Players (player_id, firstName, lastName, age, nickname) values (8,'Anton', 'Pann', 17, 't3rminator');
-- INSERTING INTO INVENTORIES
INSERT INTO Inventories (inventory_id, player_id) values (1, 1);
INSERT INTO Inventories (inventory_id, player_id) values (2, 2);
INSERT INTO Inventories (inventory_id, player_id) values (3, 3);
INSERT INTO Inventories (inventory_id, player_id) values (4, 4);
INSERT INTO Inventories (inventory_id, player_id) values (5, 5);
INSERT INTO Inventories (inventory_id, player_id) values (6, 6);
-- INSERTING INTO ITEM-INVENTORY
INSERT INTO Item_Inventory (item_id, inventory_id) values (2, 1);
INSERT INTO Item_Inventory (item_id, inventory_id) values (3, 1);
INSERT INTO Item_Inventory (item_id, inventory_id) values (7, 2);
INSERT INTO Item_Inventory (item_id, inventory_id) values (8, 3);
INSERT INTO Item_Inventory (item_id, inventory_id) values (1, 4);
INSERT INTO Item_Inventory (item_id, inventory_id) values (5, 4);
INSERT INTO Item_Inventory (item_id, inventory_id) values (6, 5);
INSERT INTO Item_Inventory (item_id, inventory_id) values (4, 6);
-- INSERT INTO ARENAS
INSERT INTO Arenas (arena_id, capacity, city, street, arena_name) values (1,15000, 'Cluj Napoca', 'Parcul Central', 'Sala Polivalenta');
INSERT INTO Arenas (arena_id, capacity, city, street, arena_name) values (2, 5000, 'Carei', 'Zamfirescu 2', 'Sala Gheorghe Tadici');
INSERT INTO Arenas (arena_id, capacity, city, street, arena_name) values (3,15000, 'Arad', 'Cuza Voda 1', 'Sala Mare');
INSERT INTO Arenas (arena_id, capacity, city, street, arena_name) values (4,20000, 'Cluj Napoca', 'Bogdan Petriceiu Hasdeu 92', 'Sala Horia Demian');
INSERT INTO Arenas (arena_id, capacity, city, street, arena_name) values (5,2500, 'Satu Mare', 'Balcescu 65', 'Sala Sporturilor');
-- INSERT INTO BONUS
INSERT INTO Bonus (bonus_id, bonus_description) values (1,'Free Food');
INSERT INTO Bonus (bonus_id, bonus_description) values (2,'VIP seats');
INSERT INTO Bonus (bonus_id, bonus_description) values (3,'Free Signatures');
INSERT INTO Bonus (bonus_id, bonus_description) values (4,'Monster Energy Bonus Pack');
INSERT INTO Bonus (bonus_id, bonus_description) values (5,'Blackjack 1 entry');
-- INSERT INTO TICKETS
INSERT INTO Tickets (ticket_id, arena_id, price) values (1, 1, 150);
INSERT INTO Tickets (ticket_id, arena_id, price) values (2, 1, 100);
INSERT INTO Tickets (ticket_id, arena_id, price) values (3, 1, 250);
INSERT INTO Tickets (ticket_id, arena_id, price) values (4, 2, 50);
INSERT INTO Tickets (ticket_id, arena_id, price) values (5, 3, 25);
INSERT INTO Tickets (ticket_id, arena_id, price) values (6, 4, 100);
INSERT INTO Tickets (ticket_id, arena_id, price) values (7, 4, 300);
INSERT INTO Tickets (ticket_id, arena_id, price) values (8, 4, 500);
INSERT INTO Tickets (ticket_id, arena_id, price) values (12,3,100);
-- INSERT INTO VIP_BONUSES
INSERT INTO Vip_Bonus (ticket_id, bonus_id) values (1, 1);
INSERT INTO Vip_Bonus (ticket_id, bonus_id) values (1, 2);
INSERT INTO Vip_Bonus (ticket_id, bonus_id) values (2, 3);
INSERT INTO Vip_Bonus (ticket_id, bonus_id) values (7, 5);
INSERT INTO Vip_Bonus (ticket_id, bonus_id) values (8, 4);
-- INSERT INTO FANS
INSERT INTO Fans (CNP, ticket_id, firstName, lastName) values (112, 1, 'Andrei', 'Vasile');
INSERT INTO Fans (CNP, ticket_id, firstName, lastName) values (113, 2, 'Guru', 'Vasile');
INSERT INTO Fans (CNP, ticket_id, firstName, lastName) values (114, 3, 'Eupsihie', 'Coca');
INSERT INTO Fans (CNP, ticket_id, firstName, lastName) values (115, 4, 'George', 'Bucur');
-- INSERT INTO CASTERS
INSERT INTO Casters (firstName, lastName, nickname, age) values ('George', 'Danicico', 'trafic', 28);
INSERT INTO Casters (firstName, lastName, nickname, age) values ('Cornel', 'Pintea', 'geometr13', 60);
INSERT INTO Casters (firstName, lastName, nickname, age) values ('Horia', 'Pop', 'einstein', 61);
-- INSERT INTO TOURNAMENTS
INSERT INTO Tournaments (tournament_id, prize, teamsCount, arena_id) values (1, 1000000, 4, 1);
-- INSERT INTO Matches
INSERT INTO Matches (match_date, team_id_1, team_id_2, tournament_id, order_number, map_id) values (GETDATE(), 1, 2, 1, 1, 1);
INSERT INTO Matches (match_date, team_id_1, team_id_2, tournament_id, order_number, map_id) values (GETDATE(), 3, 4, 1, 2, 2);

--UPDATE STATEMENTS.

--UPDATE the age of the player that has the nickname r3k1Nu
UPDATE Players SET age = 20 WHERE nickname = 'r3k1Nu';
--Move all the players from both team 2 and team 3 to team 1
UPDATE Players SET team_id = 1 WHERE team_id BETWEEN 2 AND 3;

-- Add 2 items in the invetories with the id's in (1, 4)
UPDATE Inventories SET total_items = 2 WHERE inventory_id IN (1, 4)
-- Add 1 item in the invetories with the id's in (2, 3, 5, 6)
UPDATE Inventories SET total_items = 1 WHERE inventory_id IN (2, 3, 5, 6)

-- change the price for the items that were either opened from the case with the id = 8 and has a covert rarity, or skins for an AK-47.
UPDATE Items SET price = price + 15 WHERE (case_id = 8 AND rarity = 'covert') 
	OR (weapon = 'AK-47');

-- delete all the professional players that do not have a team and are older than 35 years old.
DELETE FROM Players WHERE team_id is NULL and age > 35;
-- delete all the items from the Printstream collection that have a higher price than 150 euros.
DELETE FROM Items WHERE skin_name LIKE '%Printstream%' AND price > 150;

-- a. 2 queries with the union operation; use UNION [ALL] and OR;
-- get the names of all the fans and players.
SELECT DISTINCT firstName, lastName FROM Players
WHERE age > 30 or team_id is null
UNION
SELECT firstName, lastName FROM Fans;

-- all the teams that have total winnigs between 0-3000000 and 4000000 - 
SELECT team_name from Teams T1 
WHERE T1.total_winnings > 4000000 or T1.total_winnings < 3000000

-- b. 2 queries with the intersection operation; use INTERSECT and IN;
-- Select all the players that are members of one of the first 3 teams.
SELECT nickname FROM Players P1
INTERSECT
SELECT nickname from Players P2 
WHERE P2.team_id in (1, 2, 3);

-- Select all the arenas from the cities Cluj Napoca and Satu Mare
SELECT DISTINCT arena_name from Arenas A2
WHERE A2.city in ('Cluj Napoca', 'Satu Mare')

-- c. 2 queries with the difference operation; use EXCEPT and NOT IN;
-- Select all the arenas that are in Arad or Carei
SELECT DISTINCT A1.arena_name from Arenas A1 
EXCEPT
SELECT A2.arena_name from Arenas A2
WHERE A2.city not in ('Arad', 'Carei')

SELECT P1.nickname FROM Players P1
WHERE P1.team_id not in (1, 2, 3);

-- d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one
-- query per operator); one query will join at least 3 tables, while another
-- one will join at least two many-to-many relationships;
-- Select all the players that aren't members of any of the first 3 teams
-- Select all the fans that have a vip bonus
SELECT F.CNP, F.firstName, F.lastName, B.bonus_id
FROM (Fans F INNER JOIN Tickets T 
	ON F.ticket_id = T.ticket_id 
	INNER JOIN Vip_Bonus B on F.ticket_id=B.ticket_id
)
-- Select all the players that belong to a team.
SELECT P.firstName, P.lastName, T.team_name
FROM (Players P LEFT JOIN Teams T
	ON P.team_id = T.team_id)

-- Select all items and their coresponding cases.
SELECT W.case_type, I.skin_name
FROM (Items I FULL JOIN Weapon_Cases W
	ON W.case_id=I.case_id)

-- Select all the skins that were opened by cases that were dropped on a map.
SELECT I.skin_name, C.case_type, M.map_name
FROM Inventories Inv RIGHT JOIN Item_Inventory Iv ON Inv.inventory_id = Iv.inventory_id
	RIGHT JOIN Items I ON Iv.item_id = I.item_id
	RIGHT JOIN Weapon_Cases C ON I.case_id = C.case_id
	RIGHT JOIN Drop_Case D ON C.case_id = D.case_id
	RIGHT JOIN Map M ON D.map_id = M.map_id

-- e.  2 queries with the IN operator and a subquery in the WHERE clause;
-- in at least one case, the subquery should include a subquery in its own
-- WHERE clause;
-- Select all the ticket_ids that were bought by Fans and have a vip bonus.
SELECT T.ticket_id 
FROM Tickets T
WHERE T.ticket_id IN  (
	SELECT V.ticket_id 
	FROM Vip_Bonus V
	WHERE V.ticket_id IN (
		SELECT F.ticket_id
		FROM Fans F)
)

-- Select all the teams that have players older than 30 years
SELECT T.team_name
FROM Teams T
WHERE T.team_id in (
	SELECT P.team_id
	FROM Players P
	WHERE P.age > 30
)

-- f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;
-- Select all the teams that have at least one player
SELECT T.team_name
FROM Teams T
WHERE EXISTS (
	SELECT *
	FROM Players P
	WHERE T.team_id = P.team_id
)

-- Select all the tickets that were bought by the fans.
SELECT T.ticket_id, T.price
FROM Tickets T
WHERE EXISTS (
	SELECT *
	FROM Fans F
	WHERE T.ticket_id = F.ticket_id
)

-- g. 2 queries with a subquery in the FROM clause;
-- Select all the players that are part of a team and are between 18 up to 30 years old.
SELECT * 
FROM (
	SELECT P.firstName, P.lastName, P.nickname, P.age
	FROM Players P INNER JOIN Teams T ON P.team_id = T.team_id) t
WHERE t.age BETWEEN 18 AND 30

-- Select all the items that are either a covert or classified rarity and a price higher or equal to 15 and were opened 
-- by the cases 8 7 or 5.
SELECT * 
FROM (
	SELECT *
	FROM Items I
	WHERE (I.rarity = 'covert' or I.rarity = 'classified') and I.price >= 15 and I.condition not in ('battle-scared')
) t
WHERE t.case_id in (8, 7, 5)


-- h. 4 queries with the GROUP BY clause, 3 of which also contain the
-- HAVING clause; 2 of the latter will also have a subquery in the HAVING
-- clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

--Select the top 3 arenas with the highest price
SELECT TOP 3 A.arena_name, MAX(T.price) + MAX(T.price)/10 as MaxPrice
FROM (Arenas A INNER JOIN Tickets T
	ON A.arena_id = T.arena_id)
GROUP BY A.arena_name
ORDER BY MAX(T.price) DESC

-- Select the 2 arenas with the lowest price for a ticket 
SELECT TOP 2 A.arena_name, MIN(T.price) as MinPrice
FROM (Arenas A INNER JOIN Tickets T
	ON A.arena_id = T.arena_id)
GROUP BY A.arena_name
HAVING MIN(T.price) > 40
ORDER BY MIN(T.price) DESC

-- Select all the cases that have at least unboxed 2 items.
SELECT W.case_id
FROM Items I INNER JOIN Weapon_Cases W
	ON I.case_id = W.case_id
GROUP BY W.case_id
HAVING 2 <= (SELECT COUNT(*)
			FROM Items I2
			WHERE I2.case_id = W.case_id)

-- Select all the skins whose average price is greater than the price of all items that have a mil spec rarity
SELECT I.skin_name, AVG(I.price) as AveragePrice
FROM Items I
WHERE I.rarity not in ('mil-spec')
GROUP BY I.skin_name
HAVING AVG(I.price) > (
	SELECT SUM(I2.price)
	FROM Items I2 
	WHERE I2.rarity = 'mil-spec' and 
		(I2.condition = 'field-tested' or I2.condition = 'battle-scared' or I2.condition = 'minimal-wear')
		and I2.skin_name not in ('P90', 'Negev')
)

-- i. 4 queries using ANY and ALL to introduce a subquery in the WHERE
-- clause (2 queries per operator); rewrite 2 of them with aggregation
-- operators, and the other 2 with IN / [NOT] IN.

SELECT I.skin_name, I.weapon, I.case_id
FROM Items I
WHERE I.condition = 'factory-new' and I.price > ALL (
	SELECT I2.price
	FROM Items I2 
	WHERE I2.condition = 'battle-scared' 
)

SELECT I.skin_name, I.weapon, I.case_id
FROM Items I 
WHERE I.condition = 'factory-new' and I.price > (
	SELECT MAX(I2.price)
	FROM Items I2 
	WHERE I2.condition = 'battle-scared' 
)

SELECT P.firstName, P.lastName, P.nickname
FROM Players P
WHERE P.age > ANY (
	SELECT C.age
	FROM Casters C
)

SELECT P.firstName, P.lastName, P.nickname
FROM Players P
WHERE P.age > (
	SELECT MIN(C.age)
	FROM Casters C
)

SELECT A.arena_name
FROM Arenas A
WHERE A.capacity != ALL (
	SELECT A2.capacity
	FROM Arenas A2
	WHERE A.arena_id != A2.arena_id
)

SELECT A.arena_name
FROM Arenas A
WHERE A.capacity not in (
	SELECT A2.capacity
	FROM Arenas A2
	WHERE A.arena_id != A2.arena_id
)

SELECT T.price + T.price / 10 as TicketFullPrice, A.arena_name
FROM Tickets T INNER JOIN Arenas A on T.arena_id = A.arena_id
WHERE T.price = ANY (
	SELECT t2.price
	FROM Tickets t2
	WHERE T.arena_id != t2.arena_id
)

SELECT T.price + T.price / 10 as TicketFullPrice, A.arena_name
FROM Tickets T INNER JOIN Arenas A on T.arena_id = A.arena_id
WHERE T.price in (
	SELECT t2.price
	FROM Tickets t2
	WHERE T.arena_id != t2.arena_id
)