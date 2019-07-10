#!/bin/bash
# Fonction pour supprimer un utilisateur en saisissant son nom
function user_del ()
{

  delete_another=o

  # Saisie tant que l'utilisateur veut supprimer un utilisateur
  while [[ $delete_another = [oO] ]]
  do

    # Saisie du nom de l'utilisateur jusqu'à ce qu'il soit non vide et qu'il existe
    uid=""
    while [ -z "$uid" ] || [ -z "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$uid"$)" ]
    do
      read -p "Saisissez le nom du l'utilisateur à supprimer : " uid
      [ -z "$uid" ] && echo "Le nom de l'utilisateur ne peut pas être vide."
      [ -n "$uid" ] && [ -z "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$uid"$)" ] && echo "Cet utilisateur n'existe pas."
    done

 # Suppression du nom de l'utilisateur (home directory and mail spool)
    sudo userdel "$uid"

    echo "L'utilisateur $uid a été supprimé avec succès."

    # Proposition pour supprimer un autre utilisateur
    read -p "Voulez-vous supprimer un autre utilisateur ? (O/N) " delete_another
    [[ $delete_another = [oO] ]] && echo

  done

}


