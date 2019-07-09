#!/bin/bash
#Script blocage utilisateur
usrlock () {

echo "quel utilisateur bloqué ?"

read var1
result=$(grep $var1 /etc/passwd | cut -d ':' -f1)

if [ $result == $var1 ]
then passwd -l "$var1"
else echo "utilisateur non existant"
fi

}

usrlock