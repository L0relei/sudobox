#!/bin/bash

# ID min et max pour les groupes d'utilisateurs réservés au système
sysgidmin=$(grep ^SYS_GID_MIN /etc/login.defs | awk '{print $2}')
sysgidmax=$(grep ^SYS_GID_MAX /etc/login.defs | awk '{print $2}')
# ID min et max pour les groupes d'utilisateurs normaux (créés avec groupadd)
gidmin=$(grep ^GID_MIN /etc/login.defs | awk '{print $2}')
gidmax=$(grep ^GID_MAX /etc/login.defs | awk '{print $2}')

# ID min et max pour les utilisateurs réservés au système
sysuidmin=$(grep ^SYS_UID_MIN /etc/login.defs | awk '{print $2}')
sysuidmax=$(grep ^SYS_UID_MAX /etc/login.defs | awk '{print $2}')
# ID min et max pour les utilisateurs normaux (créés avec useradd)
uidmin=$(grep ^UID_MIN /etc/login.defs | awk '{print $2}')
uidmax=$(grep ^UID_MAX /etc/login.defs | awk '{print $2}')