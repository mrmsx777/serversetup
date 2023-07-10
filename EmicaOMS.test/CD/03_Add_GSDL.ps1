# Importer les groupes de sécurité Domaine local à partir d'un fichier CSV et les ajouter dans l'OU "OU_GSDL"

$GSDLS = Import-Csv C:\PS\GSDL.csv -Delimiter ";"
foreach ($GSDL in $GSDLS)
    {
$Name = $gsdl.Name
$GroupCategory = $gsdl.GroupCategory
$GroupScope = $gsdl.GroupScope
$Path = $gsdl.Path
New-ADGroup -Name "$Name" -GroupCategory "$GroupCategory" -GroupScope "$GroupScope"  -Path "$Path"
    }

# On peut faire afficher la liste de tous les groupes d'étendue Domaine Local de l'annuaire avec cette commande: Get-ADGroup -Filter 'GroupScope -eq "DomainLocal"'
# On peut supprimer les groupes GSDL avec cette commande: Get-ADGroup -Filter 'GroupCategory -eq "Security" -and GroupScope -eq "DomainLocal" -and Name -like "GSDL*"' | Remove-ADGroup