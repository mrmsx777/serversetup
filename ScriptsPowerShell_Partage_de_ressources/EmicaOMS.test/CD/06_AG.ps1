﻿# Importer les informations à partir d'un fichier CSV afin d'ajouter les comptes utilisateurs dans leur groupe de sécurité Global respectif

$AGS = Import-Csv C:\PS\AG.csv -Delimiter ";"
foreach ($AG in $AGS)
    {
$Members = $ag.Members
$Identity = $ag.Identity

Add-ADGroupMember -Identity "$Identity" -Members "$Members" 
    }

# On peut faire afficher la liste des comptes utilisateurs membres de chacun des goupes de sécurité "Global" avec cette commande:
<#