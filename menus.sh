#!/bin/bash
##############
#            #
# Menus v0.2 #
#            #
##############

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
  PS3="Tapez la lettre correspondant à votre choix : "
  
  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_main_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : menu de gestion des utilisateurs
      1) echo ; menu_users ; break ;;
      # Touche "2" : menu de gestion des groupes
      2) echo ; menu_groups ; break ;;
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
  PS3="Tapez la lettre correspondant à votre choix : "

  # Options du menu (sudoer)
  menu_users_opt=( \
  "Créer un utilisateur" \
  "Supprimer un utilisateur" \
  "Renommer un utilisateur" \
  "Changer le répertoire home d'un utilisateur"
  "Bloquer un utilisateur" \
  "Afficher la liste des utilisateurs" \
  "Revenir au menu principal (Q)" )

  # Options du menu (non sudoer)
  # - Afficher la liste des utilisateurs
  # - Revenir au menu principal
  [ "$sudoer" = false ] && menu_users_opt=( "${menu_users_opt[5]}" "${menu_users_opt[6]}" )

  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_users_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : créer un utilisateur
      1) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; add_user ; echo ; break
         fi ;;
      # Touche "2" : supprimer un utilisateur
      2) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; user_del ; echo ; break
         fi ;;
      # Touche "3" : renommer un utilisateur
      3) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; user_rename ; echo ; break
         fi ;;
      # Touche "4" : changer le répertoire home d'un utilisateur
      4) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; user_change_home ; echo ; break
         fi ;;
      # Touche "5" : bloquer un utilisateur
      5) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; usrlock ; echo ; break
         fi ;;
      # Touche "6" : afficher la liste des utilisateurs
      6) echo ; list_users ; echo ; break ;;
      # Touche "7" ou "Q" : revenir au menu principal
      [7qQ]) echo ; break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

  # Retour au menu principal
  menu_main

}

# Menu de gestion des groupes
function menu_groups ()
{

  blue_bold "--------------------------------------"
  blue_bold "- Gestion des groupes d'utilisateurs -"
  blue_bold "--------------------------------------"

  # Modification du message de prompt de la commande select
  PS3="Tapez la lettre correspondant à votre choix : "

  # Options du menu (sudoer)
  menu_groups_opt=( \
  "Créer un groupe" \
  "Supprimer un groupe" \
  "Afficher la liste des groupes" \
  "Revenir au menu principal (Q)" )

  # Options du menu (non sudoer)
  # - Afficher la liste des groupes
  # - Revenir au menu principal
  [ "$sudoer" = false ] && menu_groups_opt=( " ${menu_groups_opt[2]} ${menu_groups_opt[3]}" )

  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_groups_opt[@]}"
  do
    case $REPLY in
      # Touche "1" : créer un groupe
      1) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; group_create ; echo ; break
         fi ;;
      # Touche "2" : supprimer un groupe
      2) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; group_delete ; echo ; break
         fi ;;
      # Touche "3" : afficher la liste des groupes
      3) if [ "$sudoer" = false ] ; then echo "Choix incorrect"
         else echo ; group_list ; echo ; break
         fi ;;
      # Touche "4" ou "Q" : revenir au menu principal
      [4qQ]) echo ; break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

  # Retour au menu principal
  menu_main

}