#!/bin/bash
PSQL="sudo -i -u postgres psql --username=postgres --dbname=world_cup -t --no-align -c"

if [[ $1 == "test" ]]; then
    echo $($PSQL "TRUNCATE games, teams")
    echo -e "\n ******** INSERT DATA INTO Teams and games ********"
    cat games.csv | while IFS=',' read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS; do
        if [[ $YEAR != "year" && $ROUND != "round" && $WINNER != "winner" && $OPPONENT != "opponent" && $WINNER_GOALS != "winner_goals" && $OPPONENT_GOALS != "opponent_goals" ]]; then
            # Select winner_id
            WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
            if [[ -z $WINNER_ID ]]; then
                # Insert winner
                INSERT_WINNER=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")
                if [[ $INSERT_WINNER == "INSERT 0 1" ]]; then
                    echo -e "\nInserted Winner: $WINNER into teams table"
                fi
                # Get new team_id
                WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
                WINNER_TEAM=$($PSQL "SELECT name FROM teams WHERE team_id=$WINNER_ID")
                echo -e "\nWinner: $WINNER_TEAM"
            fi

            # Insert opponent
            OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
            if [[ -z $OPPONENT_ID ]]; then
                INSERT_OPPONENT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT')")
                if [[ $INSERT_OPPONENT == "INSERT 0 1" ]]; then
                    echo "Inserted Opponent: $OPPONENT into teams table"
                fi
                # Get new team_id
                OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
                OPPONENT_TEAM=$($PSQL "SELECT name FROM teams WHERE team_id=$OPPONENT_ID")
                echo -e "\nOpponent: $OPPONENT_TEAM"
            fi

            # Insert game
            INSERT_GAMES=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
            if [[ $INSERT_GAMES == "INSERT 0 1" ]]; then
                echo -e "\nInserted game: $YEAR $ROUND $WINNER vs $OPPONENT"
            fi
        fi
    done
fi
