function Remove-ExistingDir {
    param([string]$path)

    if(Test-Path $path) {
        Remove-Item -Recurse -Force $path
    }
}

function Remove-ExistingFile {
    param([string]$path)

    if(Test-Path $path) {
        Remove-Item -Force $path
    }
}

$nvimDir = $env:localappdata
$pwshDir = "$HOME/Documents"
$settingsFile = "C:\Users\$env:USERNAME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Remove existing files
Remove-ExistingDir "$nvimDir/nvim"
Remove-ExistingDir "$pwshDir/PowerShell"
Remove-ExistingFile $settingsFile

# Copy new files
Copy-Item -Recurse -Force nvim -Destination $nvimDir
Copy-Item -Recurse -Force PowerShell -Destination $pwshDir
Copy-Item -Force WindowsTerminal\settings.json -Destination $settingsFile

