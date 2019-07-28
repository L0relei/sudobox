#!/bin/bash

# Fonction pour renommer un groupe d'utilisateurs
function group_rename() {

  rename_another=o

  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix (Q pour quitter) : "

  while [[ "$rename_another" == [oO] ]]; do

    # Stockage de la liste des groupes d'utilisateurs dans un tableau trié sur le GID
    liste=($(sort -t":" -k3 -n /etc/group |
      awk -F":" -v min="$gidmin" -v max="$gidmax" '{ if (($3 >= min) && ($3 <= max)) print $1 }'))

    echo "Choisissez le groupe d'utilisateurs à renommer :"

    # Affichage du menu de choix du groupe d'utilisateurs
    select item in "${liste[@]}"; do
      case $REPLY in
      [qQ])
        rename_another=n
        break
        ;;
      [0-9]*)
        if [[ "$REPLY" -le "${#liste[@]}" ]]; then
          # Saisie du nouveau nom du groupe
          new_group_name=""
          erreur=1
          while [[ -z "$new_group_name" ]] || [[ "$erreur" != 0 ]]; do
            read -p "Saisissez le nouveau nom du groupe $item : " new_group_name
            [[ -z "$new_group_name" ]] && echo "Le nouveau nom du groupe ne peut pas être vide."
            sudo groupmod -n "$new_group_name" "$item" >/dev/null 2>&1
            erreur=$?
            [[ -n "$new_group_name" ]] && [[ "$erreur" == 3 ]] && echo "$new_group_name n'est pas un nom de groupe valide."
            [[ "$erreur" == 9 ]] && echo "Le groupe $new_group_name existe déjà."
            [[ "$erreur" == 0 ]] && echo "Le groupe $item a été renommé en $new_group_name avec succès."
          done
          rename_another=x
        else
          rename_another=o
        fi
        break
        ;;
      esac
    done

    # Proposition de supprimer un autre groupe
    while [[ "$rename_another" != [oOnN] ]]; do
      read -p "Voulez-vous renommer un autre groupe ? (O/N) " rename_another
    done
    [[ "$rename_another" == [oO] ]] && clear

  done

}
