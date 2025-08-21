# Neovim
Remove-Item -Recurse -Force $Env:LOCALAPPDATA/nvim | Out-Null
Copy-Item -Recurse -Force "$PSScriptRoot/nvim" -Destination $Env:LOCALAPPDATA | Out-Null

# PowerShell
Remove-Item -Recurse -Force "$HOME/Documents/PowerShell" | Out-Null
Copy-Item -Recurse -Force "$PSScriptRoot/PowerShell" -Destination "$HOME/Documents" | Out-Null
