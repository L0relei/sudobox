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

<<<<<<< HEAD
}
=======
}
>>>>>>> 4d291365c1d89de753ed89cdef13c7db3e783325
