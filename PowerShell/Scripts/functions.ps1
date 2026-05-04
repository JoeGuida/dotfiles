function v {
    param([string] $file=$null)

    nvim $file
}

function Delete {
    param([string]$path)

    Remove-Item -Recurse -Force $path
}

function devshell {
    Import-Module "$env:ProgramFiles\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
    Enter-VsDevShell -VsInstallPath "C:\Program Files\Microsoft Visual Studio\2022\Community" -DevCmdArguments "-arch=x64" | Out-Null
}

function bb {
    param([string]$Target)

    if($Target) {
        Write-CenteredLine -ForegroundColor Yellow "Building Target: $Target"
        cmake -G 'Ninja' -S . -B build -DCMAKE_TOOLCHAIN_FILE="C:/vcpkg/scripts/buildsystems/vcpkg.cmake" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build --target $Target
    }
    else {
        Write-CenteredLine -ForegroundColor Yellow "Building All Targets"
        cmake -G 'Ninja' -S . -B build -DCMAKE_TOOLCHAIN_FILE="C:/vcpkg/scripts/buildsystems/vcpkg.cmake" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build
    }
}

function br {
    param([string]$BuildDir,
          [string]$Target)

    $project = ($(pwd).Path -Split '\\')[-1]

    if($BuildDir -and $Target) {
        Start-Process -Filepath "$BuildDir/$Target.exe"
    }
    elseif($BuildDir) {
        Start-Process -Filepath "$BuildDir/$project.exe"
    }
    else {
        Start-Process -Filepath "build/$project.exe"
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
        [string]$FillChar = '-'
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
    Write-Host -ForegroundColor Cyan $line
}


