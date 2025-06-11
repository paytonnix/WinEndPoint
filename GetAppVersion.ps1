# Payton Nix 2/21/2025

$LogFilePath = "log.txt"
Start-Transcript -Path $LogFilePath
New-PSDrive HKLM Registry HKEY_LOCAL_MACHINE -ErrorAction SilentlyContinue
New-PSDrive HKU Registry HKEY_USERS -ErrorAction SilentlyContinue

function Get-AppVersion {
    
    param (
        $Name
    )

    # Get a list of installed programs from the 32-bit registry hive
    $32BitPrograms = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object { $_.DisplayName -ne $null }

    # Get a list of installed programs from the 64-bit registry hive
    $64BitPrograms = Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object { $_.DisplayName -ne $null }

    # Combine both lists to get all installed programs
    $allPrograms = $32BitPrograms + $64BitPrograms

    # Get a list of installed programs using Get-WmiObject
    $appFound = $allPrograms | Where-Object { $_.DisplayName -like "*$($Name)*" }

    return $appfound.Version
}

Remove-PSDrive HKLM
Remove-PSDrive HKU
Stop-Transcript