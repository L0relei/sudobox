#!/bin/bash

# Fonction pour mettre en forme du texte en bleu et gras
function blue_bold ()
{
  echo -e "\033[34;1m$1\033[0m"
}