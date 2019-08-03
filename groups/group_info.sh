#!/bin/bash

# Fonction pour afficher des informations sur un groupe d'utilisateurs

function group_info () {
  
  # Stockage de la liste des groupes d'utilisateurs dans un tableau trié sur le GID
  liste=( $(sort -t":" -k3 -n /etc/group | cut -d":" -f1) )
  
  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix (Q pour quitter) : "

  echo "Choisissez le groupe d'utilisateurs dont vous voulez voir les informations :"

  # Affichage du menu de choix du groupe d'utilisateurs
  select item in "${liste[@]}" ; do
    case $REPLY in
      [qQ])
        break ;;
      [0-9]*)
        if [ "$REPLY" -le "${#liste[@]}" ] ; then
          echo
          echo -e "\033[4mInformations sur le groupe $item\033[0m"
          # GID
          group_id=$(getent group "$item" | cut -d":" -f3)
          echo "ID du groupe : $group_id"
          # Groupe système
          [ "$group_id" -ge "$sysgidmin" ] && [ "$group_id" -le "$sysgidmax" ] && echo "Groupe réservé au sytème."
          # Utilisateurs dont ce groupe est le groupe principal
          main_group=$(cut -d":" -f1,4 /etc/passwd | grep -w "$group_id" | cut -d":" -f1 | paste -s -d",")
          [ -n "$main_group" ] && echo "Groupe principal de : $main_group"
          # Membres du groupe
          members=$(getent group "$item" | cut -d":" -f4)
          [ -n "$members$main_group" ] && echo "Membres du groupe : $members$main_group." || echo "Le groupe est vide."
          echo
        fi
        ;;
    esac
  done
  
}