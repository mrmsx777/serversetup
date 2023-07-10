# Importer les comptes utilisateur à partir d'un fichier CSV et les ajouter dans leur OU respective de l'annuaire

Import-Csv C:\PS\Users.csv -Delimiter ";" | ForEach-Object { 
$Params = @{
    DisplayName = $_.DisplayName
    Name = $_.Name
    GivenName = $_.GivenName
    Surname = $_.Surname
    PasswordNeverExpires = [bool]$_.PasswordNeverExpires
    AccountPassword = $_.AccountPassword | ConvertTo-SecureString -AsPlainText -Force
    Enabled = [bool]$_.Enabled
    Path = $_.Path
    SamAccountName = $_.SamAccountName
    Type = $_.Type
    UserPrincipalName = $_.UserPrincipalName
    Server = $_.Server
        }
                                                            
New-ADUser @Params
}


# On peut faire afficher la liste de tous les utilisateur du domaine avec cette commande: Get-ADUser -Filter *
# Pour supprimer les users, on peut utiliser ces commandes: 
# Get-ADUser -Filter * -SearchBase "OU=OU_Users,OU=OU_Ameriques,DC=emicaoms,DC=test" | Remove-ADUser
# Get-ADUser -Filter * -SearchBase "OU=OU_Users,OU=OU_Afrique,DC=emicaoms,DC=test" | Remove-ADUser -Verbose
# Get-ADUser -Filter * -SearchBase "OU=OU_Users,OU=OU_Asie,DC=emicaoms,DC=test" | Remove-ADUser -Verbose
# Get-ADUser -Filter * -SearchBase "OU=OU_Users,OU=OU_Europe,DC=emicaoms,DC=test" | Remove-ADUser -Verbose
# Get-ADUser -Filter * -SearchBase "OU=OU_Users,OU=OU_Oceanie,DC=emicaoms,DC=test" | Remove-ADUser -Verbose
# Get-ADUser -Filter * -SearchBase "OU=OU_Users,OU=OU_Presidence,DC=emicaoms,DC=test" | Remove-ADUser -Verbose
