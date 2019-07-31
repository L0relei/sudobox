#!/bin/bash

# ID min et max pour les groupes d'utilisateurs réservés au système
readonly sysgidmin=$(grep ^SYS_GID_MIN /etc/login.defs | awk '{print $2}')
readonly sysgidmax=$(grep ^SYS_GID_MAX /etc/login.defs | awk '{print $2}')
# ID min et max pour les groupes d'utilisateurs normaux (créés avec groupadd)
readonly gidmin=$(grep ^GID_MIN /etc/login.defs | awk '{print $2}')
readonly gidmax=$(grep ^GID_MAX /etc/login.defs | awk '{print $2}')

# ID min et max pour les utilisateurs réservés au système
readonly sysuidmin=$(grep ^SYS_UID_MIN /etc/login.defs | awk '{print $2}')
readonly sysuidmax=$(grep ^SYS_UID_MAX /etc/login.defs | awk '{print $2}')
# ID min et max pour les utilisateurs normaux (créés avec useradd)
readonly uidmin=$(grep ^UID_MIN /etc/login.defs | awk '{print $2}')
readonly uidmax=$(grep ^UID_MAX /etc/login.defs | awk '{print $2}')