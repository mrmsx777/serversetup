﻿# Si le poste client est un Windows 11, il faut ajouter le chemin complet de la source, par exemple: D:\LanguagesAndOptionalFeaturesAdd-WindowsCapability -Online -Name Rsat.ServerManager.Tools~~~~0.0.1.0 -LimitAccess -Source D:\Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -LimitAccess -Source d:\Add-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0 -LimitAccess -Source d:\Add-WindowsCapability -Online -Name Rsat.DHCP.Tools~~~~0.0.1.0 -LimitAccess -Source d:\Add-WindowsCapability -Online -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0 -LimitAccess -Source d:\Get-WindowsCapability -Online -name *rsat* | Where-Object { $_.State -eq "Installed" }