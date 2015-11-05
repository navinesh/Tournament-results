-- TABLE definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- Drop tournament database if it exists
DROP DATABASE IF EXISTS tournament;

-- Create database
CREATE DATABASE tournament;

-- Connect to the database
\c tournament

-- Create Players table
CREATE TABLE players(
  player_id serial PRIMARY KEY,
  player_name text NOT NULL
);

-- Create Matches table
CREATE TABLE matches(
  match_id serial PRIMARY KEY,
  player_id_won integer REFERENCES players(player_id) ON DELETE CASCADE,
  player_id_lost integer REFERENCES players(player_id) ON DELETE CASCADE
  CHECK (player_id_won <> player_id_lost)
);

-- Create view to count number of matches won by each players
CREATE VIEW matches_won AS
SELECT players.player_id, players.player_name,
       count(matches.player_id_won) AS wins
FROM players
LEFT JOIN matches ON players.player_id = matches.player_id_won
GROUP BY players.player_id
ORDER BY wins DESC;

-- Create view to count number of matches played by each players
CREATE VIEW matches_played AS
SELECT players.player_id,
       players.player_name,
       count(matches.match_id) AS played
FROM players
LEFT JOIN matches ON players.player_id = matches.player_id_won
                  OR players.player_id = matches.player_id_lost
GROUP BY players.player_id;

-- Create view to count number of matches played and won by each players
CREATE VIEW player_standings AS
SELECT matches_won.player_id,
       matches_won.player_name,
       matches_won.wins,
       matches_played.played
FROM matches_won
LEFT JOIN matches_played USING(player_id)
GROUP BY matches_won.player_id,
         matches_won.player_name,
         matches_won.wins,
         matches_played.played
ORDER BY matches_won.wins DESC;

-- Create view to return list of pairs of players for the
-- next round of a match
CREATE VIEW swiss_pairing AS
SELECT a.player_id AS id1, a.player_name AS name1,
       b.player_id AS id2, b.player_name AS name2
FROM player_standings AS a,
     player_standings AS b
WHERE a.played = b.played
  AND a.wins = b.wins
  AND a.player_id < b.player_id;
