#!/bin/bash
###########################
#                         #
# Fonctions communes v0.1 #
#                         #
###########################

# Fonction pour mettre en forme du texte en bleu et gras
function blue_bold ()
{
  echo -e "\033[34;1m$1\033[0m"
}

# Fonction pour vérifier si l'utilisateur connecté est sudoer
function test_sudoer ()
{

  # On redirige la sortie de la commande sudo -l dans le fichier err
  timeout 2 sudo id > /dev/null 2>&1 && sudoer="true" || sudoer="false"

}