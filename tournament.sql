-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament;

 \c tournament;


CREATE SEQUENCE public.players_id_seq;


CREATE TABLE public.Players ( Id INTEGER NOT NULL DEFAULT nextval('public.players_id_seq'), Name VARCHAR NOT NULL, CONSTRAINT pk_players PRIMARY KEY (Id));


ALTER SEQUENCE public.players_id_seq OWNED BY public.Players.Id;


CREATE TABLE public.Matches ( Winner_Id INTEGER NOT NULL, Loser_Id INTEGER NOT NULL, pk_matches serial PRIMARY KEY);


ALTER TABLE public.Matches ADD CONSTRAINT players_matches_fk
FOREIGN KEY (Winner_Id) REFERENCES public.Players (Id) ON
DELETE CASCADE ON
UPDATE NO ACTION NOT DEFERRABLE;


ALTER TABLE public.Matches ADD CONSTRAINT players_matches_fk1
FOREIGN KEY (Loser_Id) REFERENCES public.Players (Id) ON
DELETE CASCADE ON
UPDATE NO ACTION NOT DEFERRABLE;


CREATE VIEW players_matches AS
SELECT id,
       name,
       CASE
           WHEN winner_id IS NULL THEN 0
           ELSE winner_id
       END,
       CASE
           WHEN loser_id IS NULL THEN 0
           ELSE loser_id
       END,
       CASE
           WHEN pk_matches IS NULL THEN 0
           ELSE pk_matches
       END
FROM players
LEFT JOIN matches ON players.Id=matches.winner_id;


CREATE VIEW winners AS
SELECT winner_id,
       count(winner_id)
FROM matches
GROUP BY winner_id;


CREATE VIEW tempcount AS
SELECT *
FROM
  (SELECT id,
          Name
   FROM players) players
LEFT JOIN matches ON players.Id=matches.winner_id
OR players.Id=matches.loser_id;


CREATE VIEW winnercount AS
SELECT id,
       name,
       CASE
           WHEN winners.count IS NULL THEN 0
           ELSE winners.count
       END
FROM players
LEFT JOIN winners ON winners.winner_id=players.id;


CREATE VIEW matchcount AS
SELECT Name,
       Id AS PlayerId,
       count(pk_matches)
FROM tempcount
GROUP BY Name,
         id;

CREATE VIEW playerstanding AS
SELECT winnercount.Id AS PlayerID,
       winnercount.name,
       winnercount.count AS wincount,
       matchcount.count AS matchcount
FROM winnercount
INNER JOIN matchcount ON winnercount.id=matchcount.PlayerId
ORDER BY wincount DESC;

