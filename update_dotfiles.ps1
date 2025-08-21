# Neovim
Remove-Item -Recurse -Force $Env:LOCALAPPDATA/nvim
Copy-Item -Recurse -Force "$PSScriptRoot/nvim" -Destination $Env:LOCALAPPDATA 

# PowerShell
Remove-Item -Recurse -Force "$HOME/Documents/PowerShell"
Copy-Item -Recurse -Force "$PSScriptRoot/PowerShell" -Destination "$HOME/Documents"
