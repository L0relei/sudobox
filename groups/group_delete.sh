#!/bin/bash

# Fonction pour supprimer un groupe d'utilisateurs
function group_delete () {

  delete_another=o

  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix (Q pour quitter) : "

  while [[ $delete_another = [oO] ]] ; do

    # Stockage de la liste des groupes d'utilisateurs dans un tableau trié sur le GID
    liste=( $(sort -t":" -k3 -n /etc/group | cut -d":" -f1) )
    
    echo "Choisissez le groupe d'utilisateurs à supprimer :"

    # Affichage du menu de choix du groupe d'utilisateurs
    select item in "${liste[@]}"
    do
      case $REPLY in
        [qQ])
          delete_another=n
          break ;;
        [0-9]*)
          if [ "$REPLY" -le "${#liste[@]}" ] ; then
            sudo groupdel "$item" > /dev/null 2>&1
            erreur=$?
            [ "$erreur" = 8 ] && echo "Le groupe $item doit être vide pour être supprimé." || echo "Le groupe $item a été supprimé avec succès."
            delete_another=x
          else
            delete_another=o
          fi
          break ;;
      esac
    done

    # Proposition de supprimer un autre groupe
    while [[ $delete_another != [oOnN] ]] ; do
      read -p "Voulez-vous supprimer un autre groupe ? (O/N) " delete_another
    done
    [[ $delete_another = [oO] ]] && clear

  done

}