#!/bin/bash
##################
#                #
# Boîte à outils #
#                #
##################

# Inclusion des scripts
# On recherche tous les scripts .sh et on les inclut (sauf le script principal sudobox.sh)
# Exclusion temporaire du dossier files
for f in `find . -name "*.sh" -type f` ; do
  [ $f != "./sudobox.sh" ] && [[ $f != *files* ]] && source $f
done

clear
blue_bold "------------------------------------"
blue_bold "- Bienvenue dans la boîte à outils -"
blue_bold "------------------------------------"
echo

# Affichage du menu de choix du mode d'utilisation de la boîte à outils (utilisateur ou sudoer)
menu_mode
# Affichage du menu principal menus.sh
menu_main
# Sécurisation du script : déconnexion du sudo
sudo -k