Show-NetFirewallRule | where {$_.enabled -eq ‘true’ -AND $_.direction -eq ‘inbound’}| select displayname
Show-NetFirewallRule | where {$_.enabled -eq ‘true’ -AND $_.direction -eq ‘inbound’}| select displayname | Measure-Object
Show-NetFirewallRule | where {$_.enabled -eq ‘true’ -AND $_.direction -eq ‘inbound’}| select * | fl

New-NetFirewallRule -DisplayName "Service Accès réseau" -Enabled True -Profile Domain, Private -Direction Inbound -Action Allow