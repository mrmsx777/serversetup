# Importer les groupes de sécurité Global à partir d'un fichier CSV et les ajouter dans leur OU respective de l'annuaire
$GSGS = Import-Csv C:\PS\GSG.csv -Delimiter ";"
foreach ($GSG in $GSGS)
    {
$Name = $gsg.Name
$GroupCategory = $GSG.GroupCategory
$GroupScope = $GSG.GroupScope
$Path = $GSG.Path
New-ADGroup -Name "$Name" -GroupCategory "$GroupCategory" -GroupScope "$GroupScope"  -Path "$Path"
    }

# On peut faire afficher la liste de tous les groupes d'étendue globale de l'annuaire avec cette commande: Get-ADGroup -Filter 'GroupScope -eq "Global"'
# On peut supprimer les groupes GSG avec cette commande: Get-ADGroup -Filter 'GroupCategory -eq "Security" -and GroupScope -eq "Global" -and Name -like "GSG*"' | Remove-ADGroup