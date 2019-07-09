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
  sudo -l > err 2>&1

  # Si le fichier err contient le mot "Sorry", l'utilisateur n'a pas les privilèges administrateur
  # Dans ce cas, la fonction renvoie 0, sinon elle renvoie 1
  # Le résultat est stocké dans la variable $sudoer
  [ -n "$(cat err | grep Sorry)" ] && sudoer=false || sudoer=true

}