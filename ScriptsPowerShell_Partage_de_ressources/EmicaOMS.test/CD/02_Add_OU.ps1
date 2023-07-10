# Importer les OU dans l'annuaire à partir d'un fichier CSV

$ADOU = Import-Csv C:\PS\OU.csv -Delimiter ";"
foreach ($ou in $ADOU)
    {
$Name = $ou.Name
$Path = $ou.Path
New-ADOrganizationalUnit -Name "$Name" -Path "$Path"
    }

# On peut faire afficher la liste de tous les OU du domaine avec cette commande: Get-ADOrganizationalUnit -Filter *
# On peut supprimer les OU protégées à l'aide de cette commande: Get-ADOrganizationalUnit -Filter 'Name -like "OU*"' | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru | Remove-ADOrganizationalUnit -Confirm:$false