#!/bin/bash



######################################################################################
#                                                                                    #
#  Boîte à outils                                                                    #
#  Script principal permettant l'affichage des menus pour l'exécution des commandes  #
#                                                                                    #
######################################################################################



# Définition du dossier contenant les scripts
DIR_SCRIPTS=/home/projet


# Modification du message de prompt de la commande select
PS3="Tapez votre choix : "



# Définition du menu principal 

function main_menu() {

echo -e "\033[34;1m------------------\033[0m"
echo -e "\033[34;1m- Menu principal -\033[0m"
echo -e "\033[34;1m------------------\033[0m"

main_menu_opt=( \
"Gestion des utilisateurs et des groupes" \
"Gestion des fichiers et dossiers" \
"Gestion des droits" \
"Quitter" )

select item in "${main_menu_opt[@]}"
do
  case $REPLY in
    1) menu_usr ; break ;;
    2) echo "Fonctionnalité à venir" ;;
    3) echo "Fonctionnalité à venir" ;;
    4) echo -e "\033[34;1mMerci d'avoir utilisé la boîte à outils !\033[0m" ; break ;;
    *) echo "Choix incorrect" ;;
  esac
done

}



# Définition du menu de gestion des utilisateurs et des groupes

function menu_usr() {

echo -e "\033[34;1m---------------------------------------\033[0m"
echo -e "\033[34;1m- Gestion des groupes et utilisateurs -\033[0m"
echo -e "\033[34;1m---------------------------------------\033[0m"

menu_usr_opt=( \
"Créer un utilisateur" \
"Supprimer un utilisateur" \
"Revenir au menu principal" )

select item in "${menu_usr_opt[@]}"
do
  case $REPLY in
    1) echo option1 ;;
    2) echo option2 ;;
    3) break ;; 
    *) echo "Choix incorrect" ;;
  esac
done

main_menu

}



clear
echo -e "\033[34;1m------------------------------------\033[0m"
echo -e "\033[34;1m- Bienvenue dans la boîte à outils -\033[0m"
echo -e "\033[34;1m------------------------------------\033[0m"
echo
main_menu
