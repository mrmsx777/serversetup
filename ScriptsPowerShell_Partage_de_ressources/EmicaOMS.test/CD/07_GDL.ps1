# Importer les informations à partir d'un fichier CSV afin d'ajouter les groupes de sécurité Globale dans leur groupe de sécurité Domaine local respectif

$GDLS = Import-Csv C:\PS\GDL.csv -Delimiter ";"
foreach ($GDL in $GDLS)
    {
$Identity = $gdl.Identity
$MemberOf = $gdl.MemberOf

Add-ADPrincipalGroupMembership -Identity "$Identity" -MemberOf "$MemberOf" 
    }

# On peut faire afficher la liste des groupes de sécurité "Global" membres de chacun des goupes de sécurité Domaine Local avec cette commande:
<#$GSDLS = Get-ADGroup -Filter ('Name -like "gsdl*"')foreach ($GSDL in $GSDLS){    Write-Host $GSDL    Write-Host **********************    Get-ADGroupMember -Identity $GSDL}#>