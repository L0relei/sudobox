#!/bin/bash

# Fonction pour supprimer un groupe d'utilisateurs par son nom
function group_delete () {

  group_list
  echo

  delete_another=o

  # Saisie tant que le nom du groupe n'existe pas (chaîne vide incluse) ou que l'utilisateur veut supprimer un autre groupe
  while [[ $delete_another = [oO] ]]
  do

    # Saisie du nom du groupe jusqu'à ce qu'il soit non vide et qu'il existe
    group_name=""
    while [ -z "$group_name" ] || [ -z "$(sudo cat /etc/group | cut -d":" -f1 | grep ^"$group_name"$)" ]
    do
      read -p "Saisissez le nom du groupe à supprimer : " group_name
      [ -z "$group_name" ] && echo "Le nom du groupe ne peut pas être vide."
      [ -n "$group_name" ] && [ -z "$(sudo cat /etc/group | cut -d":" -f1 | grep ^"$group_name"$)" ] && echo "Ce groupe n'existe pas."
    done

    # Suppression du groupe en redirigeant les erreurs dans le fichier err
    sudo groupdel $group_name > err 2>&1

    [ -s err ] && echo "Le groupe $group_name doit être vide pour être supprimé." || echo "Le groupe $group_name a été supprimé avec succès."

    # Proposition de supprimer un autre groupe
    delete_another=x
    while [[ $delete_another != [oOnN] ]] ; do
      read -p "Voulez-vous supprimer un autre groupe ? (O/N) " delete_another
    done
    [[ $delete_another = [oO] ]] && echo

  done

}