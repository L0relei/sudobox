#!/bin/bash

# Fonction pour créer un groupe d'utilisateurs
function group_create () {

  group_list
  echo

  create_another=o
  
  # Saisie tant que l'utilisateur veut créer un nouveau groupe
  while [[ $create_another = [oO] ]] ; do

    # Saisie du nom du groupe jusqu'à ce qu'il soit non vide et qu'il n'existe pas déjà
    group_name=root
    while [ -z "$group_name" ] || [ "$(getent group "$group_name")" ] ; do
      read -p "Saisissez le nom du groupe à créer : " group_name
      [ -z "$group_name" ] && echo "Le nom du groupe ne peut pas être vide."
      [ -n "$group_name" ] && [ "$(getent group "$group_name")" ] && echo "Ce groupe existe déjà."
    done

    # Création du groupe avec redirection des erreurs
    sudo groupadd "$group_name" > /dev/null 2>&1
    erreur=$?
    [ "$erreur" = 0 ] && echo "Le groupe $group_name a été créé avec succès."
    [ "$erreur" = 3 ] && echo "$group_name n'est pas un nom de groupe valide."

    # Proposition de créer un autre groupe
    create_another=x
    while [[ $create_another != [oOnN] ]] ; do
      read -p "Voulez-vous créer un autre groupe ? (O/N) " create_another
    done
    [[ $create_another = [oO] ]] && echo

  done

}