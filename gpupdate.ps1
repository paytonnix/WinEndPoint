# Payton Nix 10/17/2023

# Check if the Registry.pol file exists. If so, delete it.
$regPoolDir = "C:\Windows\System32\GroupPolicy\Machine\Registry.pol"
if (Test-Path $regPoolDir) {
    Write-Host "Removing $($regPoolDir)"
    Remove-Item -Path $regPoolDir -Force
} else {
    Write-Host "$($regPoolDir) not found."
}

# Check if the Datastore dir exists. If so, delete it (gpupdate will recreate the entire dir)
$dataStoreDir = "C:\Windows\System32\GroupPolicy\DataStore"
if (Test-Path $dataStoreDir) {
    Write-Host "Removing $($dataStoreDir)"
    Remove-Item -Path $dataStoreDir -Recurse -Force
} else {
    Write-Host "$($dataStoreDir) not found."
}

$userDir = "C:\Windows\System32\GroupPolicy\User"
$userDirItems = "C:\Windows\System32\GroupPolicy\User\*"
$items = Get-ChildItem $userDir

# Check if there are files in Users dir. If so, delete them (gpupdate does not recreate the users dir if you outright delete it).
if (Test-Path $userDirItems) {
    Write-Host "Removing files within the $($userDir) directory"
    foreach ($item in $items) {
        Remove-Item -Path $item.FullName -Recurse -Force
    }
} else {
    Write-Host "No files within the $($userDir) directory"
}

Write-Host "Running GP Update"
gpupdate /force
Write-Host "Script completed."