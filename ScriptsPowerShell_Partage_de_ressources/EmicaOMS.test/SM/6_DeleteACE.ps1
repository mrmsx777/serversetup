﻿# Héritage désactivé
# ACL des dossiers vidée de toutes les ACE par défaut

$Dirs = Import-Csv C:\PS\Dirs.csv -Delimiter ";"
foreach ($Dir in $Dirs)
    {

$acl = Get-Acl $Dir.Path

    }