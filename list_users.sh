#!/bin/bash

list_users () {
clear
echo -e "\n\n## LISTE DES UTILISATEURS ##\n\n"

cut -d: -f1 /etc/passwd | paste -s -d ,

echo -e "\n\n"

}
