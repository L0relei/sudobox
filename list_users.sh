#!/bin/bash

list_users () {
clear
echo -e "\n\n## LISTE DES UTILISATEURS ##\n\n"

cut -d: -f1 /etc/passwd

echo -e "\n\n"

}
