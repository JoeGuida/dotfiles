$pwsh = "C:/Users/$($env:USERNAME)/OneDrive - Microsoft/Documents/PowerShell"

Get-ChildItem -Path $pwsh/Scripts -Filter '*.ps1' | % {
    Import-Module $_.FullName -Force
}

Set-PSReadLineOption -EditMode Vi

$theme = 'craver'
oh-my-posh -c "$posh/themes/$theme.omp.json" init pwsh | Invoke-Expression

