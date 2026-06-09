function v {
    param([string] $file=$null)

    nvim $file
}

function Delete {
    param([string]$path)

    Remove-Item -Recurse -Force $path
}

function devshell {
    $path = Get-Location # Enter-VSDevShell will change the directory, so we need to cache the path

    Import-Module "$env:ProgramFiles\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
    Enter-VsDevShell -VsInstallPath "C:\Program Files\Microsoft Visual Studio\2022\Community" -DevCmdArguments "-arch=x64" | Out-Null
    $Global:DevShellLoaded = $true

    cd $path
}

function Symlink-CompileCommands {
    param([string]$Dir)

    $file = 'compile_commands.json'
    $link = Join-Path (Get-Location) $file

    if(Test-Path $link) {
        Remove-Item $link -Force
    }

    $target = (Join-Path $Dir $file)
    if(-Not (Test-Path $target)) {
        throw("$file not found at $target")
    }

    New-Item -ItemType SymbolicLink -Path $link -Target $target -Force | Out-Null
}

function build {
    param([string]$Target,
          [switch]$Debug)

    if(-Not($Global:DevShellLoaded)) {
        devshell
    }

    $buildType = $Debug ? 'Debug' : 'Release'
    $buildDir = (Join-Path 'build' $buildType)

    Write-CenteredLine -ForegroundColor Yellow "CMake Generate : $buildType"
    cmake `
    -G 'Ninja' `
    -S . `
    -B $buildDir `
    -DCMAKE_TOOLCHAIN_FILE="C:/vcpkg/scripts/buildsystems/vcpkg.cmake" `
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

    Write-Host
    if($Target) {
        Write-CenteredLine -ForegroundColor Yellow "Building $Target : $buildType"
        cmake --build $buildDir --target $Target
    }
    else {
        Write-CenteredLine -ForegroundColor Yellow "Building All Targets : $buildType"
        cmake --build $buildDir
    }

    Symlink-CompileCommands -Dir $buildDir
}

function run {
    param([string]$Dir,
          [string]$Target,
          [switch]$Debug)


    $dirName = ($(pwd).Path -Split '\\')[-1] # assumes target name is directory name by default
    $path = ''

    $buildType = $Debug ? 'Debug' : 'Release'
    $targetName = ($Target.Length -ne 0) ? $Target : $dirName

    if($Dir) {
        Start-Process -Filepath (Join-Path 'build' $buildType $Dir "$targetName.exe")
    }
    else {
        Start-Process -Filepath (Join-Path 'build' $buildType "$targetName.exe")
    }
}

function Log {
    param([string]$match = '',
          [string]$file = 'log/log.log')

    $content = ''
    if($match) {
        $content = Get-Content $file | Select-String $match
    }
    else {
        $content = Get-Content $file
    }

    $content | % {
        if($_ -match "ERROR") {
            Write-Host $_ -ForegroundColor Red
        }
        elseif($_ -match "WARN") {
            Write-Host $_ -ForegroundColor Yellow
        }
        elseif($_ -match "INFO") {
            Write-Host $_ -ForegroundColor Cyan
        }
        else {
            Write-Host $_
        }
    }
}

function Write-CenteredLine {
    param(
        [string]$Text,
        [string]$FillChar = '-',
        [System.ConsoleColor]$ForegroundColor = [System.ConsoleColor]::Cyan
    )

    $width = $Host.UI.RawUI.WindowSize.Width / 2

    $content = " [ $Text ] "
    $contentLength = $content.Length

    if ($contentLength -ge $width) {
        Write-Host $content
        return
    }

    $remaining = $width - $contentLength
    $left = [int][math]::Floor($remaining / 2)
    $right = [int]($remaining - $left)

    $line = ($FillChar * $left) + $content + ($FillChar * $right)
    Write-Host -ForegroundColor $ForegroundColor $line
}

