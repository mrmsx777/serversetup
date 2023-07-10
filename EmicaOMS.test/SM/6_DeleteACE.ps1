# Héritage désactivé
# ACL des dossiers vidée de toutes les ACE par défaut

$Dirs = Import-Csv C:\PS\Dirs.csv -Delimiter ";"
foreach ($Dir in $Dirs)
    {

$acl = Get-Acl $Dir.Path$acl.SetAccessRuleProtection($true,$false)$acl.Access | %{$acl.RemoveAccessRule($_)} | Out-Null$acl | Set-Acl $Dir.Path

    }
