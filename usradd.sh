#!/bin/bash
#Fonction création utilisateur et mot de passe

add_user () {

# Condition de sortie de la boucle est la saisie obligatoire (caractères spéciaux, chiffres inclus.

username=""
until [ -n "$username" ]
  do
    read -p "Veuillez saisir un nom d'utilisateur: " username
done

# création d'un utilisateur et de son mot de passe (pas d'obligation longeur mdp) 

adduser $username
passwd $username
}