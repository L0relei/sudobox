#!/bin/bash
#########
#       #
# Menus #
#       #
#########

# Menu de choix du mode d'utilisation de la boîte à outils
function menu_mode () {

  echo "Comment souhaitez-vous utiliser la boîte à outils ?"

  # Options du menu
  menu_mode_opt=( "En mode utilisateur" "En mode sudoer" )

  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix : "  

  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_mode_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : utilisation sans les droits sudo
      1) sudoer="false" ; break ;;
      # Touche "2" : utilisation avec les droits sudo
      2) test_sudoer ;
         [ "$sudoer" = "false" ] && echo -e "Echec de saisie du mot du passe.\nLa boîte à outils est lancée en mode utilisateur." ;
         echo ;
         break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

}

# Menu principal 
function menu_main ()
{

  blue_bold "------------------"
  blue_bold "- Menu principal -"
  blue_bold "------------------"

  # Options du menu
  menu_main_opt=( \
  "Gestion des utilisateurs" \
  "Gestion des groupes d'utilisateurs" \
  # "Gestion des fichiers et dossiers" \
  # "Gestion des droits" \
  "Quitter (Q)" )                      

  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix : "
  
  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_main_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : menu de gestion des utilisateurs
      1) clear ; menu_users ; break ;;
      # Touche "2" : menu de gestion des groupes
      2) clear ; menu_groups ; break ;;
      # Touche "3" : menu des gestion des fichiers et dossiers
      # 3) echo "Fonctionnalité à venir" ;;
      # Touche "4" : menu des gestion des permissions
      # 4) echo "Fonctionnalité à venir" ;;
      # Touche "3" ou "Q" : quitter
      [3qQ]) echo ; blue_bold "Merci d'avoir utilisé la boîte à outils !" ; echo ; break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

}

# Menu de gestion des utilisateurs
function menu_users ()
{

  blue_bold "----------------------------"
  blue_bold "- Gestion des utilisateurs -"
  blue_bold "----------------------------"

  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix : "

  # Options du menu (sudoer)
  [ "$sudoer" = "true" ] && menu_users_opt=( \
  "Créer un utilisateur" \
  "Supprimer un utilisateur" \
  "Renommer un utilisateur" \
  "Changer le répertoire home d'un utilisateur"
  "Bloquer un utilisateur" \
  "Afficher la liste des utilisateurs" \
  "Revenir au menu principal (Q)" )

  # Options du menu (utilisateur)
  [ "$sudoer" = "false" ] && menu_users_opt=( \
  "Créer un utilisateur (*)" \
  "Supprimer un utilisateur (*)" \
  "Renommer un utilisateur (*)" \
  "Changer le répertoire home d'un utilisateur (*)"
  "Bloquer un utilisateur (*)" \
  "Afficher la liste des utilisateurs" \
  "Revenir au menu principal (Q)" )

  # Exécution des commandes en fonction de la saisie de l'utilisateur et du mode
  [ "$sudoer" = "false" ] && echo "Les options marquées d'une (*) ne sont pas disponibles en mode utilisateur."
  select item in "${menu_users_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : créer un utilisateur
      1) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; add_user ; break
         fi ;;
      # Touche "2" : supprimer un utilisateur
      2) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; user_del ; break
         fi ;;
      # Touche "3" : renommer un utilisateur
      3) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; user_rename ; break
         fi ;;
      # Touche "4" : changer le répertoire home d'un utilisateur
      4) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; user_change_home ; break
         fi ;;
      # Touche "5" : bloquer un utilisateur
      5) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; usrlock ; break
         fi ;;
      # Touche "6" : afficher la liste des utilisateurs
      6) clear ; list_users ; read -p "Appuyez sur une touche pour continuer" -n 1 suite ; break ;;
      # Touche "7" ou "Q" : revenir au menu principal
      [7qQ]) break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

  # Retour au menu de gestion des utilisateurs
  clear
  [[ $REPLY = [7qQ] ]] && menu_main || menu_users

}

# Menu de gestion des groupes
function menu_groups ()
{

  blue_bold "--------------------------------------"
  blue_bold "- Gestion des groupes d'utilisateurs -"
  blue_bold "--------------------------------------"

  # Modification du message de prompt de la commande select
  PS3="Tapez votre choix : "

  # Options du menu (sudoer)
  [ "$sudoer" = "true" ] && menu_groups_opt=( \
  "Créer un groupe" \
  "Supprimer un groupe" \
  "Afficher la liste des groupes" \
  "Revenir au menu principal (Q)" )

  # Options du menu (utilisateur)
  [ "$sudoer" = "false" ] && menu_groups_opt=( \
  "Créer un groupe (*)" \
  "Supprimer un groupe (*)" \
  "Afficher la liste des groupes" \
  "Revenir au menu principal (Q)" )

  # Exécution des commandes en fonction de la saisie de l'utilisateur et du mode
  [ "$sudoer" = "false" ] && echo "Les options marquées d'une (*) ne sont pas disponibles en mode utilisateur."
  select item in "${menu_groups_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : créer un groupe
      1) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; group_create ; break
         fi ;;
      # Touche "2" : supprimer un groupe
      2) if [ "$sudoer" = "false" ] ; then echo "Choix incorrect"
         else clear ; group_delete ; break
         fi ;;
      # Touche "3" : afficher la liste des groupes
      3) clear ; group_list ; echo ; read -p "Appuyez sur une touche pour continuer" -n 1 suite ; break ;;
      # Touche "4" ou "Q" : revenir au menu principal
      [4qQ]) break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

  # Retour au menu de gestion des groupes d'utilisateurs
  clear
  [[ $REPLY = [4qQ] ]] && menu_main || menu_groups

}