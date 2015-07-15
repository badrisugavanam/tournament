-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
create database tournament;
\c tournament;



CREATE SEQUENCE public.players_id_seq;

CREATE TABLE public.Players (
                Id INTEGER NOT NULL DEFAULT nextval('public.players_id_seq'),
                Name VARCHAR NOT NULL,
                CONSTRAINT pk_players PRIMARY KEY (Id)
);


ALTER SEQUENCE public.players_id_seq OWNED BY public.Players.Id;

CREATE TABLE public.Matches (
                Winner_Id INTEGER NOT NULL,
                Loser_Id INTEGER NOT NULL,
                pk_matches serial PRIMARY KEY
);


ALTER TABLE public.Matches ADD CONSTRAINT players_matches_fk
FOREIGN KEY (Winner_Id)
REFERENCES public.Players (Id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Matches ADD CONSTRAINT players_matches_fk1
FOREIGN KEY (Loser_Id)
REFERENCES public.Players (Id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

create view standing as 
select * from players inner join matches on players.Id=matches.winner_id union select * from players inner join matches on players.Id=matches.loser_id;

create view winnerstanding as select winner_id,count(winner_id) from standing group by Winner_id;
create view loserstanding as select loser_id,count(loser_id) from standing group by loser_id;

-- list as players with win count 
--select id,name,winnerstanding.count from players left join winnerstanding on winnerstanding.winner_id=players.id;