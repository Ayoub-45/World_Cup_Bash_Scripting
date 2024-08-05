#!/bin/bash

PSQL="sudo -i -u postgres psql --username=postgres --dbname=world_cup -t --no-align -c"
echo -e "\nTotal number of goals in all games from winning teams:"
echo $($PSQL "SELECT SUM(winner_goals) FROM games")
echo -e "\nTotal number of goals in all games from both teams combined:"
echo $($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games")
echo -e "\nAverage number of goals in all games from the winning teams:"
echo $($PSQL "SELECT AVG(winner_goals) FROM games")
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo $($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")
echo -e "\nAverage number of goals in all games from both teams:"
echo $($PSQL "SELECT AVG(winner_goals+opponent_goals) FROM games")
echo -e "\nMost goals scored in a single game by one team:"
echo $($PSQL "SELECT MAX(winner_goals) as most_goals FROM games")
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo $($PSQL "SELECT COUNT(*) AS number_of_games FROM games WHERE winner_goals > 2")
echo -e "\nWinner of the 2018 tournament team name:"
echo $($PSQL "SELECT name FROM teams AS t left join games AS g ON t.team_id=g.winner_id WHERE g.year=2018 and g.round='Final'")
echo -e "\nList of unique winning team names in the whole data set:"
echo $($PSQL "SELECT DISTINCT (name) FROM teams as t LEFT JOIN games as g ON t.team_id=g.winner_id ORDER BY t.name")
echo -e "\nYear and team name of all the champions:"
echo $($PSQL "SELECT g.year, t.name FROM games g LEFT JOIN teams t ON g.winner_id=t.team_id WHERE round='Final' ORDER BY g.year")
echo -e "\nList of teams that start with 'Co':"
#echo $($PSQL "SELECT DISTINCT(name) FROM teams t RIGHT JOIN games g ON (t.team_id=g.winner_id OR t.team_id=g.opponent_id) WHERE t.name LIKE 'Co%'")
echo $($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")
