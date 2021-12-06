use DB_COURSE

DROP TABLE IF EXISTS Tournament_Casters;
DROP TABLE IF EXISTS Casters;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Item_Inventory;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Inventories;
DROP TABLE IF EXISTS Tournaments;
DROP TABLE IF EXISTS Fans;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Teams;
DROP TABLE IF EXISTS Weapon_Cases;
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS Arenas;


create table Weapon_Cases (
	case_id integer primary key identity(1, 1),
	case_type varchar(50) not null,
);

create table Teams (
	team_id integer primary key identity(1, 1),
	team_name varchar(30) not null,
	total_winnings integer,
);

create table Arenas(
	arena_id integer primary key,
	capacity integer,
	city varchar(30) not null,
	street varchar(30) not null,
);

create table Tickets (
	ticket_id integer primary key,
	price integer,
	arena_id integer,
	foreign key (arena_id) references Arenas(arena_id),
);

create table Fans (
	CNP varchar(20) primary key,
	firstName varchar(30) not null,
	lastName varchar(30) not null,
	ticket_id integer unique,
	foreign key (ticket_id) references Tickets(ticket_id),
);

create table Players (
	player_id integer primary key identity(1, 1),
	firstName varchar(20) not null,
	lastName varchar(20) not null,
	age tinyint,
	nickname varchar(30) not null,
	team_id integer,
	foreign key (team_id) references Teams(team_id),
);

create table Inventories (
	inventory_id integer primary key identity(1, 1),
	total_items integer default 0,
	player_id integer unique not null,
	foreign key (player_id) references Players(player_id),
);


create table Items (
	item_id integer primary key identity(1, 1),
	case_id integer,
	condition varchar(30) not null,
	rarity varchar(30) not null,
	weapon varchar(20) not null,
	skin_name varchar(30) not null,
	price integer not null,
	foreign key (case_id) references Weapon_Cases(case_id),
	constraint check_rarity check 
		(rarity in ('mil-spec', 'restricted', 'classified', 'covert')),
	constraint check_condition check
		(condition in ('battle-scared', 'well-worn', 'field-tested', 'minimal-wear', 'factory-new'))

);

create table Item_Inventory (
	item_id integer,
	inventory_id integer,
	foreign key (item_id) references Items(item_id),
	foreign key (inventory_id) references Inventories(inventory_id),
	primary key (item_id, inventory_id),
);

create table Tournaments (
	tournament_id integer primary key identity(1, 1),
	prize integer,
	teamsCount integer,
	arena_id integer,
	foreign key (arena_id) references Arenas(arena_id),
);

create table Matches (
	match_date datetime not null,
	team_id_1 integer not null,
	team_id_2 integer not null,
	tournament_id integer not null,
	order_number integer not null,
	foreign key (team_id_1) references Teams(team_id),
	foreign key (team_id_2) references Teams(team_id),
	foreign key (tournament_id) references Tournaments(tournament_id),
	primary key (tournament_id, order_number),

	constraint check_teams_id check 
		(team_id_1 != team_id_2)
);

create table Casters (
	caster_id integer primary key identity(1, 1),
	firstName varchar(20) not null,
	lastName varchar(20) not null,
	nickname varchar(20) not null unique,
	age tinyint not null,
);

create table Tournament_Casters (
	caster_id integer not null,
	tournament_id integer not null,
	foreign key (caster_id) references Casters(caster_id),
	foreign key (tournament_id) references Tournaments(tournament_id),
	primary key (caster_id, tournament_id),
);
