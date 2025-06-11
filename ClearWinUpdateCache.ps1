# Payton Nix 12/30/2024

$dateTxt = Get-Date -Format "MM-dd-yy_HH.mm.ss"

Stop-Service -Name Wuauserv
Stop-Service -Name cryptsvc
Stop-Service -Name bits

Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.$($dateTxt)"
Rename-Item -Path "C:\Windows\System32\catroot2" -NewName "catroot2.$($dateTxt)"

Start-Service -Name cryptsvc
Start-Service -Name Wuauserv
Start-Service -Name bits