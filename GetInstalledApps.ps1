# Payton Nix 12/12/2024

$hostname = $env:COMPUTERNAME
$dateTxt = Get-Date -Format "MM-dd-yy_HH.mm.ss" | ForEach-Object { $_ + ".txt" }
$logDir = "C:\Temp"

#Find if log dir exists
If (Test-Path $logDir) {
    Write-Host "$($hostname) directory already created"
} Else {
    Write-Host "Creating $($hostname) directory"
    New-Item -ItemType Directory -Path $logDir
}

# Get a list of installed programs from the 32-bit registry hive
$32BitPrograms = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object { $_.DisplayName -ne $null }

# Get a list of installed programs from the 64-bit registry hive
$64BitPrograms = Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object { $_.DisplayName -ne $null }

$32BitPrograms + $64BitPrograms | Out-File -FilePath "$($logDir)\InstalledApps_$($dateTxt)"