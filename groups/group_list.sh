#!/bin/bash

# Fonction pour afficher la liste des groupes d'utilisateurs
function group_list () {

  # La liste est lue dans le fichier /etc/group
  # On filtre pour n'afficher que les noms des groupes dont l'ID est supérieur ou égal à 1001
  # On affiche uniquement les noms de groupes sous forme de liste séparée par des virgules
  blue_bold "Liste des groupes (sauf groupes réservés au système)"
  cat /etc/group | egrep :[0-9]\{4,\}: | grep -v 1000 | cut -d":" -f1 | paste -s -d","
  
}