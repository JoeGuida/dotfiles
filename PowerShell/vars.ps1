# neovim
$nvim = "$Env:LOCALAPPDATA/nvim"
$ivim = "$nvim/init.lua"
$evim = "$nvim/lua/plugins/init.lua"

# repos
$repos = "$HOME/source/repos"
$raycaster = "$repos/raycaster"

# starship
$env:STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml"
$env:STARSHIP_CACHE = "$HOME/.config/starship/cache"

# msvc
if($Env:USERDOMAIN -ne 'REDMOND') {
    $winVer = '10.0.26100.0'
    $compilerVer = '14.44.35207'
    $vsEdition = 'Community'
}
else {
    $winVer = '10.0.26100.0'
    $compilerVer = '14.44.35207'
    $vsEdition = 'Enterprise'
}

