#!/bin/bash

# ID min et max pour les groupes d'utilisateurs réservés au système
sysgidmin=$(grep ^SYS_GID_MIN /etc/login.defs | awk '{print $2}')
sysgidmax=$(grep ^SYS_GID_MAX /etc/login.defs | awk '{print $2}')
# ID min et max pour les groupes d'utilisateurs normaux
gidmin=$(grep ^GID_MIN /etc/login.defs | awk '{print $2}')
gidmax=$(grep ^GID_MAX /etc/login.defs | awk '{print $2}')

# Fonction pour afficher la liste des groupes d'utilisateurs normaux
function group_list_regular () {

  blue_bold "Liste des groupes d'utilisateurs (sauf groupes réservés au système)"
  cat /etc/group | sort -t":" -k3 -n | \
  awk -F":" -v min="$gidmin" -v max="$gidmax" \
  '{ if (($3 >= min) && ($3 <= max)) print $1 "(" $3 ")"}' \
  | paste -s -d","
  
}

# Fonction pour afficher la liste des groupes d'utilisateurs système
function group_list_system () {

  blue_bold "Liste des groupes d'utilisateurs (réservés au système)"
  cat /etc/group | sort -t":" -k3 -n | \
  awk -F":" -v smin="$sysgidmin" -v smax="$sysgidmax" \
  '{ if (($3 >= smin) && ($3 <= smax)) print $1 "(" $3 ")" }' \
  | paste -s -d","
  
}

# Fonction pour afficher la liste des autres groupes d'utilisateurs (ni système ni normaux)
function group_list_other () {

  blue_bold "Liste des autres groupes d'utilisateurs"
  cat /etc/group | sort -t":" -k3 -n | \
  awk -F":" -v min="$gidmin" -v max="$gidmax" -v smin="$sysgidmin" -v smax="$sysgidmax" \
  '{ if (!((($3 >= min) && ($3 <= max))) && (!((($3 >= smin) && ($3 <= smax))))) print $1 "(" $3 ")" }' \
  | paste -s -d","
  
}

# Fonction pour afficher la liste des tous les groupes d'utilisateurs
function group_list () {

  group_list_regular
  group_list_system
  group_list_other

}