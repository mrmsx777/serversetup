# Création des dossiers de partage
# Les dossiers seront partagés dans un autre script

$Dirs = Import-Csv C:\PS\Dirs.csv -Delimiter ";"
foreach ($Dir in $Dirs)
    {
$Name = $Dir.Name
$Path = $Dir.Path
New-Item -Name "$Name" -Path "$Path" -ItemType Directory    }