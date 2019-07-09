#!/bin/bash
#######################
#                     #
# Boîte à outils v0.2 #
#                     #
#######################

# Inclusion des scripts
. common.sh
. menus.sh
. users.sh
. groups.sh
. usradd.sh
. list_users.sh
. usrlock.sh

clear
blue_bold "------------------------------------"
blue_bold "- Bienvenue dans la boîte à outils -"
blue_bold "------------------------------------"
echo

test_sudoer
menu_main