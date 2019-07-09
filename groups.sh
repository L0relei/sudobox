#!/bin/bash
###########################################
#                                         #
# Gestion des groupes d'utilisateurs v0.2 #
#                                         #
###########################################

# TODO récupérer la valeur de GID_MIN depuis le fichier /etc/login.defs
# TODO supprimer un groupe en choisissant dans une liste

# Fonction pour créer un groupe
function group_create ()
{

  group_list
  echo

  create_another=o

  # Saisie tant que l'utilisateur veut créer un nouveau groupe
  while [[ $create_another = [oO] ]]
  do

    # Saisie du nom du groupe jusqu'à ce qu'il soit non vide et qu'il n'existe pas déjà
    group_name=root
    while [ -z "$group_name" ] || [ "$group_name" = "$(sudo cat /etc/group | cut -d":" -f1 | grep ^"$group_name"$)" ]
    do
      read -p "Saisissez le nom du groupe à créer : " group_name
      [ -z "$group_name" ] && echo "Le nom du groupe ne peut pas être vide."
      [ -n "$group_name" ] && [ "$group_name" = "$(sudo cat /etc/group | cut -d":" -f1 | grep ^"$group_name"$)" ] && echo "Ce groupe existe déjà."
    done

    # Création du groupe
    sudo groupadd $group_name

    echo "Le groupe $group_name a été créé avec succès."

    # Proposition de créer un autre groupe
    read -p "Voulez-vous créer un autre groupe ? (O/N) " create_another
    [[ $create_another = [oO] ]] && echo

  done

}

# Fonction pour supprimer un groupe par son nom
function group_delete ()
{

  group_list
  echo

  delete_another=o

  # Saisie tant que le nom du groupe n'existe pas (chaîne vide incluse) ou que l'utilisateur veut supprimer un autre groupe
  while [[ $delete_another = [oO] ]]
  do

    # Saisie du nom du groupe jusqu'à ce qu'il soit non vide et qu'il existe
    group_name=""
    while [ -z "$group_name" ] || [ -z "$(sudo cat /etc/group | cut -d":" -f1 | grep ^"$group_name"$)" ]
    do
      read -p "Saisissez le nom du groupe à supprimer : " group_name
      [ -z "$group_name" ] && echo "Le nom du groupe ne peut pas être vide."
      [ -n "$group_name" ] && [ -z "$(sudo cat /etc/group | cut -d":" -f1 | grep ^"$group_name"$)" ] && echo "Ce groupe n'existe pas."
    done

    # Suppression du groupe en redirigeant les erreurs dans le fichier err
    sudo groupdel $group_name > err 2>&1

    [ -s err ] && echo "Le groupe $group_name doit être vide pour être supprimé." || echo "Le groupe $group_name a été supprimé avec succès."

    # Proposition de supprimer un autre groupe
    read -p "Voulez-vous supprimer un autre groupe ? (O/N) " delete_another
    [[ $delete_another = [oO] ]] && echo

  done

}

# Fonction pour afficher la liste des groupes
function group_list ()
{

  # La liste est lue dans le fichier /etc/group
  # On filtre pour n'afficher que les noms des groupes dont l'ID est supérieur ou égal à 1001
  # On affiche uniquement les noms de groupes sous forme de liste séparée par des virgules
  blue_bold "Liste des groupes"
  cat /etc/group | egrep :[0-9]\{4,\}: | grep -v 1000 | cut -d":" -f1 | paste -s -d","
  
}