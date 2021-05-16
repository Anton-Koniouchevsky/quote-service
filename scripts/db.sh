#!/bin/bash

location="/d/cdp/devOps/quote-service"
DBFile="$location/data/users.db"

help() {
  echo "Supported commands are:"
  echo "- help    -> Prints instructions how to use this script with description of all available commands"
  echo "- add     -> Adds a new line to the users.db"
  echo "- backup  -> Creates a new file, named %date%-users.db.backup which is a copy of current users.db"
  echo "- restore -> Takes last created backup file and replaces users.db with it."
  echo "- find    -> Prompts user to type a username, then prints username and role if such exists in users.db"
  echo "- list    -> Prints contents of users.db in format: N. username, role"
  echo "             Accepts an additional optional parameter inverse which allows to get result in an opposite order"
}

checkDBExistence() {
  if [[ ! -f $DBFile ]]; then
    while true
    do
      read -p "DB file doesn't exist. Would you like to create it? [y/n]: " input
      case "$input" in
        y|Y )
          mkdir -p "$(dirname "$DBFile")"
          touch $DBFile
          break ;;
        n|N )
          echo "We are unable to proceed without db file";
          exit 1 ;;
      esac
    done
  fi
}

enterLatinsOnly() {
  while true
  do
    read -p "Enter $1: " input
    if [[ $input =~ ^[A-Za-z]+ ]]; then
      break
    else
      echo "Input must contain latin letters only, please try again"
    fi
  done
}

add() {
  checkDBExistence

  enterLatinsOnly "username"
  username=$input

  enterLatinsOnly "role"
  role=$input

  echo "$username, $role" >> $DBFile
}

backup() {
  checkDBExistence

  cp $DBFile $location/data/$(date +'%d-%m-%Y')-users.db.backup
}

restore() {
  checkDBExistence

  latestBackup=$(ls -t $location/data/*.backup 2>/dev/null | head -1)
  if [[ -z $latestBackup ]]; then
    echo "No backup file found"
  else
    cp -f $latestBackup $DBFile
  fi
}

find() {
  checkDBExistence

  enterLatinsOnly "username"
  username=$input

  IFS=", "
  while read -r name role;
  do
    if [[ $name == $username ]]; then
      match="User: $name; Role: $role"
      break
    fi
  done < $DBFile

  if [[ -z $match ]]; then
    echo "User not found"
  else
    echo $match
  fi
}

list() {
  checkDBExistence

  mapfile rows < $DBFile

  if [[ "$1" == "inverse" ]]; then
    for ((i = ${#rows[@]} - 1 ; i >= 0 ; i--)); do
      echo "$(($i + 1)). ${rows[$i - 1]}"
    done
  else
    for ((i = 1 ; i <= ${#rows[@]} ; i++)); do
      echo "$i. ${rows[$(($i - 1))]}"
    done
  fi
}

case "$1" in
  add ) add ;;
  backup ) backup ;;
  restore ) restore ;;
  find ) find ;;
  list ) list $2 ;;
  "" | help ) help ;;
  * )
    echo "unknown operation $1"
    help ;;
esac