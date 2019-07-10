#!/bin/bash
#Script blocage utilisateur
usrlock () {

echo "Quel utilisateur bloquer ?"

read usrname
result=$(grep ^"$usrname": /etc/passwd | cut -d ':' -f1)

if [ $result == $usrname ]
then sudo passwd -l "$usrname"
else echo "Utilisateur non existant"
fi

}
