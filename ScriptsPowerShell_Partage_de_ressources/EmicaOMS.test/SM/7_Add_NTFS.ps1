# Ajouter les permissions NTFS de chacun des dossiers � partir d'un fichier CSV
# Cr�er un fichier CSV avec toutes les permissions NTFS appliqu�es � chacun des dossiers

$permissions = Import-Csv 'C:\PS\Permissions_dossiers.csv' -Delimiter ";"

foreach ($Permission in $Permissions)
{
    $ace = New-Object System.Security.AccessControl.FileSystemAccessRule($permission.User, $permission.AccessRights, "ContainerInherit, ObjectInherit", "None", $permission.AccessType)
    $acl = Get-Acl $Permission.Path
    $acl.SetAccessRule($ace)
    $acl | Set-Acl $Permission.Path
    $acl = $null # R�initialisation de la variable $acl
}

$permissions | Export-Csv -Path 'C:\PS\Permissions_All.csv' -Delimiter ";" -NoTypeInformation
