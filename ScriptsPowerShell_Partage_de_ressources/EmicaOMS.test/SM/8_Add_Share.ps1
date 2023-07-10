﻿# Importer un fichier CSV contenant les autorisations de partage et paramètres de chacun des dossiers:
foreach ($Share in $Shares)
    $Param = @{
    Name = $Share.Name
    Path = $Share.Path
    FullAccess = $Share.FullAccess
    ChangeAccess = $Share.ChangeAccess
    FolderEnumerationMode = $Share.FolderEnumerationMode
    CachingMode = $Share.CachingMode
    }
    New-SmbShare @Param