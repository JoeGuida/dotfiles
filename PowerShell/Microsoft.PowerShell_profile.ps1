$pwsh = "$HOME/Documents/PowerShell"
$PROFILE = Join-Path $pwsh profile.ps1

Get-ChildItem -Path $pwsh/Scripts -Filter '*.ps1' | % {
    Import-Module $_.FullName -Force
}

Set-PSReadLineOption -EditMode Vi

devshell
oh-my-posh -c $posh/themes/illusi0n.omp.json init pwsh | Invoke-Expression

