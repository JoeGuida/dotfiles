Get-ChildItem -Path "$HOME/Documents/PowerShell/Scripts" -Filter '*.ps1' | ForEach-Object {
    Import-Module $_.FullName -Force
}

Set-PSReadLineOption -EditMode Vi

oh-my-posh -c "$posh/themes/$theme.omp.json" init pwsh | Invoke-Expression

