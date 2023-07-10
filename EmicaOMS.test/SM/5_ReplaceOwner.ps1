# Remplacer le propriétaire des dossiers à partager par le groupe Admins du domaine

$user = New-Object System.Security.Principal.NTAccount('Admins du domaine')
$Dirs = Import-Csv C:\PS\Dirs.csv -Delimiter ";"
foreach ($Dir in $Dirs)
    {
    $acl = Get-Acl $Dir.Path    $acl.SetOwner($user)    Set-Acl -Path $Dir.path -AclObject $acl}