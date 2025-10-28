# -----------------------------------------------------------------------------
# Update Dotfiles and Program Settings
# -----------------------------------------------------------------------------

$Documents = "$HOME/Documents"
$PowerShellDir = "$HOME/Documents/PowerShell"
$WindowsTerminalSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$NvimDir = "$env:LOCALAPPDATA/nvim"
$NvimDataDir = "$env:LOCALAPPDATA/nvim-data"

Remove-Item -Force "$WindowsTerminalSettingsDir/settings.json"
Remove-Item -Recurse -Force $NvimDir 
Remove-Item -Recurse -Force $NvimDataDir
Remove-Item -Recurse -Force $PowerShellDir

Copy-Item './WindowsTerminal/settings.json' $WindowsTerminalSettingsDir
Copy-Item -Recurse -Force './nvim' "$env:LOCALAPPDATA"
Copy-Item -Recurse -Force './PowerShell' $Documents
