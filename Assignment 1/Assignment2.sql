use DB_COURSE

-- INSERT STATEMENTS.
-- INSERTING IN THE WEAPON CASES
INSERT INTO Weapon_Cases(case_type) VALUES ('Riptide Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Snake Bite Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Fracture Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Prisma Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Shattered Web Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Chroma 3 Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Chroma Case');
INSERT INTO Weapon_Cases(case_type) VALUES ('Clutch Case');
-- INSERTING IN THE ITEMS TABLE
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (3, 'factory-new', 'covert', 'AK-47', 'Legion of Anubis', 200);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (1, 'battle-scared', 'mil-spec', 'M4A1-S', 'Printstream', 5);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (2, 'factory-new', 'restricted', 'AWP', 'Cobra', 100);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (5, 'well-worn', 'classified', 'USP-S', 'Printstream', 15);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (4, 'minimal-wear', 'mil-spec', 'M4A4', 'Asiimov', 27);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (7, 'field-tested', 'classified', 'Glock', 'Fade', 150);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (6, 'field-tested', 'mil-spec', 'Butterfly Knife', 'Crimson Web', 254);
INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
	VALUES (8, 'well-worn', 'covert', 'Gloves', 'Rainbow Paradise', 200);
--INSERT INTO Items(case_id, condition, rarity, weapon, skin_name, price) 
--	VALUES (10, 'well-worn', 'covert', 'Karambit Knife', 'Vanilla', 1000);
-- INSERTING INTO TEAMS
INSERT INTO Teams (team_name, total_winnings) values ('Liquid', 1500000);
INSERT INTO Teams (team_name, total_winnings) values ('Fnatic', 4320000);
INSERT INTO Teams (team_name, total_winnings) values ('Astralis', 9547000);
INSERT INTO Teams (team_name, total_winnings) values ('NiP', 2000000);
INSERT INTO Teams (team_name, total_winnings) values ('IBP', 1000000);
INSERT INTO Teams (team_name, total_winnings) values ('Natus Vincere', 5000000);
INSERT INTO Teams (team_name, total_winnings) values ('100 Thieves', 975000);
INSERT INTO Teams (team_name, total_winnings) values ('Cloud9', 1000000);
INSERT INTO Teams (team_name, total_winnings) values ('G2 eSports', 2000000);
-- INSERTING INTO PLAYERS
INSERT INTO Players (firstName, lastName, age, nickname, team_id) values ('Aleksandr', 'Kostyliev', 23, 'simple', 6);
INSERT INTO Players (firstName, lastName, age, nickname, team_id) values ('Vladimir', 'Putin', 22, 'kennyS', 9);
INSERT INTO Players (firstName, lastName, age, nickname, team_id) values ('George', 'Danicico', 19, 'r3k1Nu', 2);
INSERT INTO Players (firstName, lastName, age, nickname, team_id) values ('Olof', 'Kajbjer', 29, 'olofmeister', 5);
INSERT INTO Players (firstName, lastName, age, nickname, team_id) values ('Mihnea', 'Gucci', 31, 'xyp9x', 3);
INSERT INTO Players (firstName, lastName, age, nickname, team_id) values ('Florin', 'Fares', 20, 'device', 8);
INSERT INTO Players (firstName, lastName, age, nickname) values ('Nicolae', 'Guta', 39, 'valoare');
-- INSERTING INTO INVENTORIES
INSERT INTO Inventories (player_id) values (1);
INSERT INTO Inventories (player_id) values (2);
INSERT INTO Inventories (player_id) values (3);
INSERT INTO Inventories (player_id) values (4);
INSERT INTO Inventories (player_id) values (5);
INSERT INTO Inventories (player_id) values (6);
-- INSERTING INTO ITEM-INVENTORY
INSERT INTO Item_Inventory (item_id, inventory_id) values (2, 1);
INSERT INTO Item_Inventory (item_id, inventory_id) values (3, 1);
INSERT INTO Item_Inventory (item_id, inventory_id) values (7, 2);
INSERT INTO Item_Inventory (item_id, inventory_id) values (7, 3);
INSERT INTO Item_Inventory (item_id, inventory_id) values (1, 4);
INSERT INTO Item_Inventory (item_id, inventory_id) values (5, 4);
INSERT INTO Item_Inventory (item_id, inventory_id) values (6, 5);
INSERT INTO Item_Inventory (item_id, inventory_id) values (4, 6);
--UPDATE STATEMENTS.
UPDATE Players SET age = 20 WHERE nickname = 'r3k1Nu';
UPDATE Players SET team_id = 1 WHERE team_id BETWEEN 2 AND 3;

UPDATE Inventories SET total_items = 2 WHERE inventory_id IN (1, 4)
UPDATE Inventories SET total_items = 1 WHERE inventory_id IN (2, 3, 5, 6)

UPDATE Items SET price = price + 15 WHERE (case_id = 8 AND rarity = 'covert') 
	OR (weapon = 'AK-47');

DELETE FROM Players WHERE team_id is NULL;

DELETE FROM Items WHERE skin_name LIKE '%P%' AND price > 150;

SELECT * FROM Players;
SELECT * FROM Items;
SELECT * FROM Inventories;
SELECT * FROM Item_Inventory;