#!/bin/sh

help()
{
  echo ""
  echo "There are three options:"
  echo "use -l to get the list of the league names and ID"
  echo "use -t to list a league's current teams"
  echo "use -i to see a teams information"
}

league()
{
  echo ""
  echo "The five most popular league's IDs:"
  echo "English Premier League  id:4328"
  echo "Spanish La Liga  id:4335"
  echo "French Ligue 1  id:4334"
  echo "German Bundes Liga  id:4331"
  echo "Italian Seria A  id:4332"
}

team()
{
  echo ""
  echo "If the ID is not correct the script will end without getting a result."
  echo "Insert the league's id here:"
  read league_id
  echo ""
  http https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=$league_id | tr ',' '\n' | grep \"strLeague\" | cut -b 13- | tr -d '\"' | uniq
  http https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=$league_id | tr ',' '\n' | grep \"strTeam\" | cut -b 12- | tr -d '\"'
}

team_info()
{
  echo ""
  echo "Insert a team name here:"
  read team_name
  team__name=$(echo "$team_name"|tr ' ' '_')
  echo ""
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"strTeam\" | cut -b 12- | tr -d '\"'
  echo ""
  echo "Here are the results of the teams"
  echo "Type your team from the list to get the informations about the team."
  echo "If there is no team please press ^C"
  read team_name
  team__name=$(echo "$team_name"|tr ' ' '_')
  echo ""
  echo "Team name:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"strTeam\" | cut -b 12- | tr -d '\"' | head -n 1
  echo ""
  echo "Alternative team name:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"strAlternate\" | cut -b 16- | tr -d '\"' | head -n 1
  echo ""
  echo "Stadium name:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"strStadium\" | cut -b 14- | tr -d '\"' | head -n 1
  echo ""
  echo "Stadium capacity:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"intStadiumCapacity\" | cut -b 22- | tr -d '\"' | head -n 1
  echo ""
  echo "League:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"strLeague\" | cut -b 13- | tr -d '\"' | head -n 1
  echo ""
  echo "Formed Year:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"intFormedYear\" | cut -b 17- | tr -d '\"' | head -n 1
  echo ""
  echo "Website:"
  http https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$team__name | tr ',' '\n' | grep \"strWebsite\" | cut -b 14- | tr -d '\"' | head -n 1
}

echo ""
echo "This script is made by AMBPZ9."
echo "The script uses thesportsdb.com's API"

while getopts ':lti' c
do
  case $c in
    l) league ;;
    t) team ;;
    i) team_info ;;
    *) help ;;
  esac
done

