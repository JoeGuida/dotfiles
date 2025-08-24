# -----------------------------------------------------------------------------
# Update Dotfiles and Program Settings
# -----------------------------------------------------------------------------

$Documents = "$HOME/Documents"
$PowershellDir = "$HOME/Documents/PowerShell"
$WindowsTerminalSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

Remove-Item -Force "$WindowsTerminalSettingsDir/settings.json"
Remove-Item -Recurse -Force "$Env:LOCALAPPDATA/nvim"
Remove-Item -Recurse -Force "$Documents/PowerShell" 

Copy-Item './WindowsTerminal/settings.json' $WindowsTerminalSettingsDir
Copy-Item -Recurse -Force './nvim' "$Env:LOCALAPPDATA"
Copy-Item -Recurse -Force './PowerShell' $Documents
