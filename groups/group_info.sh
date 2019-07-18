#!/bin/bash

# Fonction pour afficher des informations sur un groupe d'utilisateurs

function group_info () {
  
  # Appel de la fonction affichant la liste des groupes
  group_list
  echo

  view_another=o
  
  # Saisie tant que l'utilisateur veut voir des informations sur un groupe
  while [[ $view_another = [oO] ]] ; do

    # Saisie du nom du groupe jusqu'à ce qu'il soit non vide et qu'il existe
    group_name=""
    while [ -z "$group_name" ] || [ -z "$(cut -d":" -f1 /etc/group | grep ^"$group_name"$)" ] ; do
      read -p "Saisissez le nom du groupe dont vous voulez voir les informations : " group_name
      [ -z "$group_name" ] && echo "Le nom du groupe ne peut pas être vide."
      [ -n "$group_name" ] && [ -z "$(cut -d":" -f1 /etc/group | grep ^"$group_name"$)" ] && echo "Ce groupe n'existe pas."
    done

    # Affichage du numéro du groupe
    group_id=$(cut -d":" -f1,3 /etc/group | grep ^"$group_name": | cut -d":" -f2)
    echo "Numéro du groupe : $group_id"

    # On recherche si le groupe est le groupe principal d'un utilisateur
    main_group=$(cut -d":" -f1,4 /etc/passwd | grep :"$group_id"$ | cut -d":" -f1)
    [ -n "$main_group" ] && echo "Le groupe $group_name est le groupe principal de l'utilisateur $main_group."
    
    # Affichage des membres du groupe s'il y en a
    members=$(cut -d":" -f1,4 /etc/group | grep ^"$group_name": | cut -d":" -f2)
    [ -n "$members""$main_group" ] && echo "Membres du groupe : $members$main_group" || echo "Le groupe est vide."

    # Proposition de voir les informations d'un autre groupe
    view_another=x
    while [[ $view_another != [oOnN] ]] ; do
      read -p "Voulez-vous voir les informations sur un autre groupe ? (O/N) " view_another
    done
    [[ $view_another = [oO] ]] && echo

  done
    
}