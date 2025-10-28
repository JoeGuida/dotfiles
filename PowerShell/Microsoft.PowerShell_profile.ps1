$PWSH_DIR = "$HOME/Documents/PowerShell"

. (Join-Path $PWSH_DIR 'vars.ps1')
. (Join-Path $PWSH_DIR 'functions.ps1')

Set-PSReadLineOption -EditMode Vi
Invoke-Expression (&starship init powershell)

