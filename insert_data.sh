#! /bin/bash

# if [[ $1 == "test" ]]
# then
#   PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
# else
#   PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
# fi

# Do not change code above this line. Use the PSQL variable above to query your database.
PSQL="psql --username=postgres --dbname=worldcup -t --no-align -c"
echo $($PSQL "TRUNCATE TABLE games, teams")

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
# insert unique team names
if [[ $WINNER != winner && $OPPONENT != opponent ]]
then
INSERT_TEAM_RESULT= $($PSQL "insert into teams(name) values('$WINNER')") 2>/dev/null

INSERT_TEAM_RESULT= $($PSQL "insert into teams(name) values('$OPPONENT')") 2>/dev/null
fi
done

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
if [[ $YEAR != 'year' && $ROUND != round && $WINNER != winner && $OPPONENT != OPPONENT && $WINNER_GOALS != winner_goals && $OPPONENT_GOALS != opponent_goals ]]
then
echo $($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $($PSQL "select team_id from teams where name = '$WINNER'"), $($PSQL "select team_id from teams where name = '$OPPONENT'"), $WINNER_GOALS,$OPPONENT_GOALS)")
 
fi

done