#!/bin/bash

# Fonction pour modifier le répertoire home d'un utilisateur
function user_change_home () {

  change_another=o

  # Saisie tant que l'utilisateur veut changer un répertoire home
  while [[ $change_another = [oO] ]]
  do

    # Saisie du nom de l'utilisateur jusqu'à ce qu'il soit non vide et qu'il existe
    user_name=""
    while [ -z "$user_name" ] || [ -z "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$user_name"$)" ]
    do
      read -p "Saisissez le nom du l'utilisateur dont vous voulez changer le répertoire home : " user_name
      [ -z "$user_name" ] && echo "Le nom de l'utilisateur ne peut pas être vide."
      [ -n "$user_name" ] && [ -z "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$user_name"$)" ] && echo "Cet utilisateur n'existe pas." 
    done
    
    # Affichage du répertoire home actuel
    echo "Répetoire home actuel : "$(sudo cat /etc/passwd | cut -d":" -f1,6 | grep ^"$user_name": | cut -d":" -f2 )

    # Saisie du nouveau répertoire home de l'utilisateur jusqu'à ce qu'il soit non vide et qu'il n'existe pas déjà
    new_user_home=""
    while [ -z "$new_user_home" ] || [ -n "$(sudo cat /etc/passwd | cut -d":" -f6 | grep ^/home/"$new_user_home"$)" ]
    do
      read -p "Saisissez le nouveau répertoire de l'utilisateur $user_name : " new_user_home
      [ -z "$new_user_home" ] && echo "Le nouveau répertoire home de l'utilisateur ne peut pas être vide."
      [ -n "$new_user_home" ] && [ -n "$(sudo cat /etc/passwd | cut -d":" -f6 | grep ^/home/"$new_user_home"$)" ] && echo "Ce répertoire home existe déjà."
    done
    
    # Modification du répertoire home
    sudo usermod -d /home/"$new_user_home" "$user_name"
    
    echo "Le répertoire home de l'utilisateur $user_name a été déplacé vers /home/$new_user_home avec succès."

    # Proposition de modifie le répertoire home d'un autre utilisateur
    change_another=x
    while [[ $change_another != [oOnN] ]] ; do
      read -p "Voulez-vous modifier le répertoire home d'un autre utilisateur ? (O/N) " change_another
    done
    [[ $change_another = [oO] ]] && echo

  done

}