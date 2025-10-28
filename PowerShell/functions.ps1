function msvcvars {
    $libs = @(
        "C:\Program Files (x86)\Windows Kits\10\bin\$winVer\x64",
        "C:\Program Files (x86)\Windows Kits\10\lib\$winVer\um\x64",
        "C:\Program Files (x86)\Windows Kits\10\lib\$winVer\ucrt\x64",
        "C:\Program Files\Microsoft Visual Studio\2022\$vsEdition\VC\Tools\MSVC\$compilerVer\lib\x64"
    )

    $includes = @(
        "C:\Program Files\Microsoft Visual Studio\2022\$vsEdition\VC\Tools\MSVC\$compilerVer\include",
        "C:\Program Files (x86)\Windows Kits\10\Include\$winVer\ucrt",
        "C:\Program Files (x86)\Windows Kits\10\Include\$winVer\um"
        "C:\Program Files (x86)\Windows Kits\10\Include\$winVer\shared"
    )

    $Env:LIB = ($libs -join ';')
    $Env:INCLUDE = $includes -join ';'
}

function Delete {
    param([string]$path)

    Remove-Item -Recurse -Force $path
}

function v {
    param([string] $file=$null)

    nvim $file
}

function build {
    Write-Host -ForegroundColor Yellow "cmake -G Ninja -S . -B build/Debug"
    cmake -G 'Ninja' -S . -B build/Debug
    Write-Host -ForegroundColor Yellow 'cmake --build build/Debug'
    cmake --build build/Debug
}

