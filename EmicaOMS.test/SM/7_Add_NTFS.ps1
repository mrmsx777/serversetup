# Ajouter les permissions NTFS de chacun des dossiers à partir d'un fichier CSV
# Créer un fichier CSV avec toutes les permissions NTFS appliquées à chacun des dossiers

$permissions = Import-Csv 'C:\PS\Permissions_dossiers.csv' -Delimiter ";"

foreach ($Permission in $Permissions)
{
    $ace = New-Object System.Security.AccessControl.FileSystemAccessRule($permission.User, $permission.AccessRights, "ContainerInherit, ObjectInherit", "None", $permission.AccessType)
    $acl = Get-Acl $Permission.Path
    $acl.SetAccessRule($ace)
    $acl | Set-Acl $Permission.Path
    $acl = $null # Réinitialisation de la variable $acl
}

$permissions | Export-Csv -Path 'C:\PS\Permissions_All.csv' -Delimiter ";" -NoTypeInformation
