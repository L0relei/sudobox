#!/bin/bash

# ID min et max pour les groupes d'utilisateurs réservés au système
sysgidmin=$(grep ^SYS_GID_MIN /etc/login.defs | awk '{print $2}')
sysgidmax=$(grep ^SYS_GID_MAX /etc/login.defs | awk '{print $2}')
# ID min et max pour les groupes d'utilisateurs normaux
gidmin=$(grep ^GID_MIN /etc/login.defs | awk '{print $2}')
gidmax=$(grep ^GID_MAX /etc/login.defs | awk '{print $2}')