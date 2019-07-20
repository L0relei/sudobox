#!/bin/bash

# Fonction pour afficher des informations sur un utilisateur passé en paramètre
function user_info () {

    # Affichage de l'ID de l'utilisateur
    echo "ID de l'utilisateur : "`id -u "$1"`

    # Affichage des groupes
    echo "Groupes : "`id "$1" | cut -d"=" -f4`

    # Affichage du groupe principal
    echo "Groupe principal : "`id -g "$1"`"("`id -ng "$1"`")"

    # Emplacement du répertoire home
    echo "Répertoire home : "`grep ^"$1": /etc/passwd | cut -d":" -f6`
}

# Fonction pour afficher des informations sur un utilisateur avec saisie du nom
function user_info_menu () {

  # Appel de la fonction affichant la liste des utilisateurs
  list_users
  echo

  view_another=o

  # Saisie tant que l'utilisateur veut voir des informations sur un utilisateur
  while [[ $view_another = [oO] ]] ; do

    # Saisie du nom de l'utilisateur jusqu'à ce qu'il soit non vide et qu'il existe
    user_name=""
    while [ -z "$user_name" ] || [ -z "$(cut -d":" -f1 /etc/passwd | grep ^"$user_name"$)" ] ; do
      read -p "Saisissez le nom de l'utilisateur dont vous voulez voir les informations : " user_name
      [ -z "$user_name" ] && echo "Le nom de l'utilisateur ne peut pas être vide."
      [ -n "$user_name" ] && [ -z "$(cut -d":" -f1 /etc/passwd | grep ^"$user_name"$)" ] && echo "Cet utilisateur n'existe pas."
    done

    # Affichage des informatiopns
    user_info "$user_name"

    # Proposition de voir les informations d'un autre utilisateur
    view_another=x
    while [[ $view_another != [oOnN] ]] ; do
      read -p "Voulez-vous voir les informations sur un autre utilisateur ? (O/N) " view_another
    done
    [[ $view_another = [oO] ]] && echo

  done

}