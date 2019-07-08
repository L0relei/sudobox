#!/bin/bash
##############
#            #
# Menus v0.1 #
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
  "Gestion des utilisateurs (U)" \
  "Gestion des groupes d'utilisateurs (G)" \
  "Gestion des fichiers et dossiers (F)" \
  "Gestion des droits (P)" \
  "Quitter (Q)" )                      

  # Modification du message de prompt de la commande select
  PS3="Tapez la lettre correspondant à votre choix : "
  
  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_main_opt[@]}"
  do
    case $REPLY in
      # Touche "U" : menu de gestion des utilisateurs
      [uU]) echo ; menu_users ; break ;;
      # Touche "G" : menu de gestion des groupes
      [gG]) echo ; menu_groups ; break ;;
      # Touche "F" : menu des gestion des fichiers et dossiers
      [fF]) echo "Fonctionnalité à venir" ;;
      # Touche "P" : menu des gestion des permissions
      [pP]) echo "Fonctionnalité à venir" ;;
      # Touche "Q" : quitter
      [qQ]) echo ; blue_bold "Merci d'avoir utilisé la boîte à outils !" ; echo ; break ;;
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
  "Créer un utilisateur (C)" \
  "Supprimer un utilisateur (D)" \
  "Renommer un utilisateur (R)" \
  "Bloquer un utilisateur (B)" \
  "Afficher la liste des utilisateurs (L)" \
  "Revenir au menu principal (Q)" )

  # Options du menu (non sudoer)
  # - Afficher la liste des utilisateurs
  # - Revenir au menu principal
  [ "$sudoer" = false ] && menu_users_opt=( "${menu_users_opt[4]}" "${menu_users_opt[5]}" )

  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_users_opt[@]}"
  do
    case $REPLY in
      # Touche "C" : créer un utilisateur
      [cC]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo option1 ;;
      # Touche "D" : supprimer un utilisateur
      [dD]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo option2 ;;
      # Touche "R" : renommer un utilisateur
      [rR]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo ; user_rename ; echo ; break ;;
      # Touche "B" : bloquer un utilisateur
      [bB]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo option4 ;;
      # Touche "L" : afficher la liste des utilisateurs
      [lL]) echo option5 ;;
      # Touche "Q" : revenir au menu principal
      [qQ]) echo ; break ;;
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
  "Créer un groupe (C)" \
  "Supprimer un groupe (D)" \
  "Afficher la liste des groupes (L)" \
  "Revenir au menu principal (Q)" )

  # Options du menu (non sudoer)
  # - Revenir au menu principal
  [ "$sudoer" = false ] && menu_groups_opt=( "${menu_groups_opt[3]}" )

  # Exécution des commandes en fonction de la saisie de l'utilisateur
  select item in "${menu_groups_opt[@]}"
  do
    case $REPLY in
      # Touche "C" : créer un groupe
      [cC]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo ; group_create ; echo ; break ;;
      # Touche "D" : supprimer un groupe
      [dD]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo ; group_delete ; echo ; break ;;
      # Touche "L" : afficher la liste des groupes
      [lL]) [ "$sudoer" = false ] && echo "Choix incorrect" || echo ; group_list ; echo ; break ;;
      # Touche "Q" : revenir au menu principal
      [qQ]) echo ; break ;;
      # Autres touches : nouvelle saisie
      *) echo "Choix incorrect" ;;
    esac
  done

  # Retour au menu principal
  menu_main

}