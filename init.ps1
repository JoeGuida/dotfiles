# -----------------------------------------------------------------------------
# Winget
# -----------------------------------------------------------------------------

Write-Host -ForegroundColor Cyan 'Updating Winget...'
winget upgrade --id Microsoft.Winget.Source --source winget

$RequiredPackages = @(
    'Microsoft.PowerShell',
    'Microsoft.WindowsTerminal',
    'Neovim.Neovim',
    'JanDeDobbeleer.OhMyPosh'
)

$InstalledPackages = winget list | ForEach-Object { $_.Id }
foreach($Package in $RequiredPackages) {
    if(-Not ($InstalledPackages -contains $Package)) {
        Write-Host -ForegroundColor Yellow "Installing Package $Package..."
        winget install --id $Package -e
    }
    else {
        Write-Host -ForegroundColor Green "Package $Package is already installed"
    }
}

# -----------------------------------------------------------------------------
# Fonts 
# -----------------------------------------------------------------------------

Write-Host -ForegroundColor Cyan 'Downloading Font...'
$FontUri = 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip'
$FontFolder = "$env:LOCALAPPDATA/Microsoft/Windows/Fonts/CascadiaCode"
$Destination = "$HOME/Downloads/CascadiaCode.zip"
Invoke-WebRequest -Uri $FontUri -OutFile $Destination
Expand-Archive $Destination -Destination "$HOME/Downloads/CascadiaCode"

New-Item -ItemType Directory -Path $FontFolder -Force | Out-Null
Get-ChildItem "$HOME/Downloads/CascadiaCode" -Filter '*.ttf' | ForEach-Object {
    Write-Host -ForegroundColor Yellow "Installing $($_.Name)"
    Copy-Item $_.FullName -Destination $FontFolder -Force | Out-Null
}

Remove-Item -Path $Destination -Force
Remove-Item -Path "$HOME/Downloads/CascadiaCode" -Recurse -Force

# -----------------------------------------------------------------------------
# Dotfiles and Program Settings
# -----------------------------------------------------------------------------

# Dotfiles and Program Settings
$WindowsTerminalSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
Write-Host -ForegroundColor Green 'Updating Windows Terminal Settings...'
New-Item -ItemType Directory -Path $WindowsTerminalSettingsDir -Force | Out-Null
$WindowsTerminalSettings = Get-Content -Path 'WindowsTerminal/settings.json' -Raw
Set-Content -Content $WindowsTerminalSettings -Path "$WindowsTerminalSettingsDir/settings.json"

Write-Host -ForegroundColor Cyan 'Updating dotfiles...'
. './update_dotfiles.ps1'

Write-Host -ForegroundColor Green '✅ Dev environment setup complete!'
Read-Host 'Press any key to continue...'

exit
