#!/bin/bash
#Fonction pour vérifier si un utilisateur est sudoers

useradm () {

#Cherche l'utilisateur actuel dans le /etc/group sur la ligne wheel
user=$(cat /etc/group | grep wheel | grep $(whoami))
#Cherche toute les persone qui ont les droit ALL=(ALL) dans le dossier /etc/sudoers
user2=$(sudo grep "ALL=(ALL)" /etc/sudoers)

if [ -n "$user" ] || [ -n "$user2" ] || [ $(id -u) == 0 ]
then return 1
else return 0
fi

}

useradm
echo $?
