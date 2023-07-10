# Importer un fichier CSV contenant les autorisations de partage et paramètres de chacun des dossiers:# Accorder les autorisations de partage et les paramètres selon les besoins$Shares = Import-Csv C:\PS\Shares.csv -Delimiter ";"
foreach ($Share in $Shares)    {
    $Param = @{
    Name = $Share.Name
    Path = $Share.Path
    FullAccess = $Share.FullAccess
    ChangeAccess = $Share.ChangeAccess
    FolderEnumerationMode = $Share.FolderEnumerationMode
    CachingMode = $Share.CachingMode
    }
    New-SmbShare @Param    }