#!/bin/bash

clear
echo -e "\n\n## CREER UN FICHIER ## \n\n"


check_filename(){

check=0
invalid_characters=("?" "%" "*" ":" "|" "<" ">" "." " " "#" )
for c in "${invalid_characters[@]}"
  do
    if [[ "$1" == *"$c"* ]]
      then
      echo -e "\033[31mValeur incorrecte : $c \033[0m"
      check=1
    fi
done

if [ -z "$1" ]
  then
    check=1
    echo -e "\033[31mValeur incorrecte \033[0m"
fi
}

check="1"
filename=""
until [ $check == "0" ]
  do
    read -p "Nom du fichier : " filename
    check_filename $filename
done

current_dir=$(pwd)
user=$(whoami)
home_dir=$(getent passwd $user | cut -d: -f6)
echo "Choisir l'emplacement du fichier : "
echo -e "\n"
echo -e "\033[34m  1.\033[0m Repertoire actuel ($current_dir) "
echo -e "\033[34m  2.\033[0m Repertoire utilisateur ($home_dir)"
echo -e "\033[34m  3.\033[0m Definir un repertoire "
echo -e "\n"


path_option=""
until [ "$path_option" == "1" ] || [ "$path_option" == "2" ] || [ "$path_option" == "3" ]
  do
    read -p "Selection : " path_option
    if [ -z "$path_option" ]
    then
    echo "empty"
    elif [ "$path_option" != "1" ] && [ "$path_option" != "2" ] && [ "$path_option" != "3" ]
      then
      echo -e "\033[31mValeur incorrecte \033[0m"
    fi
done


if [ "$path_option" == "1" ]
  then
    touch $filename
fi

if [ "$path_option" == "2" ]
  then
    touch "$home_dir/$filename"
    echo $home_path/$filename
fi


if [ "$path_option" == "3" ]
  then
    filepath="-1"
    until [ -d "$filepath" ]
    do
      read -p "Entrez l'emplacement du fichier : " filepath
      if [ -d "$filepath" ]
        then
          touch "$filepath/$filename"
      fi

      if [ ! -d "$filepath" ]
        then
        echo -e "\033[31mValeur incorrecte \033[0m"
      fi
    done
fi


