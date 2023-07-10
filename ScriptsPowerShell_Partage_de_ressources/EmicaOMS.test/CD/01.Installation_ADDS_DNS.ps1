# Installation d'un CD Windows Server 2022 Core
# Comprend un disque dur virtuel et une carte réseau Internal Network (Lan)
# Une fois l'installation complétée, on tape: 
# sconfig / option 5 : Manual
# Ajoutez au média le fichier ISO 20348.1.210507-1500.fe_release_amd64fre_SERVER_LOF_PACKAGES_OEM.iso
# Il faut faciliter la création d'un partage réseau pour télécharger les scripts PowerShell en procédant ainsi: 

# sconfig / option 15 : Powershell "Get-WindowsCapability -Name *Servercore* -online | Add-WindowsCapability -Online -LimitAccess -Source d:\LanguagesAndOptionalFeatures"

# Cela permettra également d'installer PowerShell_Ise sur le serveur Core afin d'exécuter des scripts PowerShell par la suite.

# Faire redémarrer le serveur une fois l'installation de la "feature" complétée.

# Début des commandes sur le serveur Core afin de configurer le réseau et d'avoir accès à dossier partagé sur l'hôte et comprenant les scripts PowerShell nécessaires.
sconfig / Option 15 : Powershell

# Sinon, on peut utiliser PowerShell Direct à partir de la machine hôte et cette commande:
# Enter-PSSession -VMName <VMName> -Credential (Get-Credential)
# Cela permet d'ouvrir une session à partir de l'hôte sur une VM locale
# Une fois la commande "Enter-PSSession" exécutée, le Prompt prendra cette forme:
# [CD10] : PS C:\Users\Administrateur\Documents>

# Configurer l'adresse IP et l'adresse du DNS de l'interface Ethernet du serveur
# Renommer le poste et redémarrer le serveur
$NewNetIPAdressParam = @{
    
    InterfaceAlias = 'Ethernet'
    IPAddress = '10.10.10.10'
    PrefixLength = 24
    DefaultGateway = '10.10.10.1'
    Verbose = $true
    }

New-NetIPAddress @NewNetIPAdressParam 

$SetDNSClientServerAddressParam = @{

    InterfaceAlias = 'Ethernet'
    ServerAddresses = '10.10.10.10'
    Verbose = $true
    }

Set-DnsClientServerAddress @SetDNSClientServerAddress

Rename-Computer -NewName CD01 -Restart

# New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 10.10.10.10 -PrefixLength 24 -DefaultGateway 10.10.10.1
# Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 10.10.10.10
# Rename-Computer -NewName CD01 -Restart

# Afficher les configurations réseaux.  Le nom du serveur sera affiché dans Sconfig
Get-NetIPAddress 
Get-NetIPConfiguration

# Après avoir redémarrer le serveur. Retour à l'interface Powershell
powershell_ise

# Si deux disques, préparer le second disque afin de pouvoir déposer la base de données NTDS, les fichiers journaux et le dossier Sysvol
Get-Disk | Where-Object PartitionStyle -eq 'RAW' | Initialize-Disk -PartitionStyle GPT -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel ADDS -Confirm:$false

# Vérifier les rôles et fonctionnalités installés sur le serveur
Get-WindowsFeature

# Installer les rôles ADDS et DNS sur le serveur CD01
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature
Install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

# Facultatif: Vérifier les rôles installés sur le serveur
Get-WindowsFeature | Where-Object "InstallState" -EQ "Installed"

# Promouvoir le serveur en tant que premier contrôleur de domaine et créer la forêt
Import-Module ADDSDeployment

$InstallADDSForestParam = @{
    CreateDnsDelegation = $false
    DatabasePath = "E:\NTDS"
    NoDnsOnNetwork = $true
    DomainMode =  "WinThreshold"
    DomaiName = "emicaoms.test"
    DomainNetbiosName = "emicaoms"
    ForestMode = "WinThreshold"
    InstallDns = $true
    LogPath = "E:\NTDS"
    NoRebootOnCompletion = $false
    SysvolPath = "E:\Sysvol"
    Force = $true
    }
Install-ADDSForest @InstallADDSForestParam

# Install-ADDSForest -CreateDnsDelegation:$false -NoDnsOnNetwork:$true -DomainMode WinThreshold -DomainName emicaoms.test -DomainNetbiosName emicaoms -ForestMode WinThreshold -InstallDns:$true -NoRebootOnCompletion:$false -Force:$true

# Facultatif: Vérifier la configuration du serveur et les paramètres du serveur DNS
  
Get-DnsServer
Get-DnsServerSetting

# Ajouter une zone de recherche inversée sur le serveur et un pointeur
Add-DnsServerPrimaryZone -NetworkId "10.10.10.0/24" -ReplicationScope Forest
Add-DnsServerResourceRecordPtr -Name "10" -ZoneName "10.10.10.in-addr.arpa" -PtrDomainName "CD01.emicaoms.test"

# Configurer l'écoute du DNS uniquement sur l'adresse IP 10.10.10.10
$DNSListeningIP = Get-DnsServerSetting -All
$DNSListeningIP.ListeningIPAddress = @("10.10.10.10")
Set-DnsServerSetting -InputObject $DNSListeningIP

# Ajout de redirecteurs et suppression des redirecteurs existant si nécessaire
# Get-DnsServerForwarder | Remove-DnsServerForwarder -PassThru -Force
Add-DnsServerForwarder -IPAddress 1.1.1.1,1.0.0.1,10.28.0.6

# Activation du vieillissement et suppression du cache
Set-DnsServerScavenging -ApplyOnAllZones -ScavengingInterval 06:00:00 -ScavengingState $true
Clear-DnsServerCache -Force

# Facultatif: Vérification des paramètres du DNS au besoin
Get-DnsServerSetting
Get-DnsServerForwarder
Get-DnsServerScavenging

# Il reste à bâtir l'AGDLP: voir les prochains scripts.

