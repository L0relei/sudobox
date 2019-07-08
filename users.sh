#!/bin/bash
#################################
#                               #
# Gestion des utilisateurs v0.1 #
#                               #
#################################

# Fonction pour renommer un utilisateur en saisissant son nom
function user_rename ()
{
  
  rename_another=o

  # Saisie tant que l'utilisateur veut renommer un utilisateur
  while [[ $rename_another = [oO] ]]
  do

    # Saisie du nom de l'utilisateur jusqu'à ce qu'il soit non vide et qu'il existe
    user_name=""
    while [ -z "$user_name" ] || [ -z "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$user_name"$)" ]
    do
      read -p "Saisissez le nom du l'utilisateur à renommer : " user_name
      [ -z "$user_name" ] && echo "Le nom de l'utilisateur ne peut pas être vide."
      [ -n "$user_name" ] && [ -z "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$user_name"$)" ] && echo "Cet utilisateur n'existe pas." 
    done
        
    # Saisie du nouveau nom de l'utilisateur jusqu'à ce qu'il soit non vide et qu'il n'existe pas déjà
    new_user_name=""
    while [ -z "$new_user_name" ] || [ -n "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$new_user_name"$)" ]
    do
      read -p "Saisissez le nouveau nom de l'utilisateur $user_name : " new_user_name
      [ -z "$new_user_name" ] && echo "Le nouveau nom de l'utilisateur ne peut pas être vide."
      [ -n "$new_user_name" ] && [ -n "$(sudo cat /etc/passwd | cut -d":" -f1 | grep ^"$new_user_name"$)" ] && echo "Ce nom d'utilisateur existe déjà."
    done
    
    # Modification du nom de l'utilisateur
    sudo usermod -l "$new_user_name" "$user_name"
    # Modification du répertoire home
    sudo usermod -d /home/"$new_user_name" "$new_user_name"
    
    echo "L'utilisateur $user_name a été renommé en $new_user_name avec succès."

    # Proposition de renommer un autre utilisateur
    read -p "Voulez-vous renommer un autre utilisateur ? (O/N) " rename_another
    [[ $rename_another = [oO] ]] && echo

  done
  
}

# Fonction pour modifier le répertoire home d'un utilisateur
function user_change_home ()
{

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
    read -p "Voulez-vous modifier le répertoire home d'un autre utilisateur ? (O/N) " change_another
    [[ $change_another = [oO] ]] && echo

  done

}