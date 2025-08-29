$POSH_DIR = "$Env:LOCALAPPDATA/Programs/oh-my-posh"
$evim = "$Env:LOCALAPPDATA/nvim/lua/plugins/init.lua"
$nvim = "$Env:LOCALAPPDATA/nvim"
$repos = "$HOME/source/repos"

function Delete {
    param([string]$path)

    Remove-Item -Recurse -Force $path
}

function gpom {
    git pull origin master
}

function gpo {
    param([string] $branch)

    git pull origin $branch
}

function gp {
    param([string] $remote,
          [string] $branch)

    git pull $remote $branch
}

function gs {
    git status
}

function v {
    param([string] $file=$null)

    nvim $file
}

function Watch-File {
    param([string]$file)

    while($true) {
        Clear-Host
        Get-Content $file
        Start-Sleep -Seconds 2
    }
}

Set-PSReadLineOption -EditMode Vi

oh-my-posh init pwsh --config "$POSH_DIR/themes/multiverse-neon.omp.json"| Invoke-Expression
