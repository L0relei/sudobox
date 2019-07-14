#!/bin/bash

# Fonction pour vérifier si l'utilisateur connecté est sudoer
function test_sudoer ()
{

  # On redirige les erreurs de la commande sudo id vers le trou noir
  sudo id > /dev/null 2>&1 && sudoer="true" || sudoer="false"

}