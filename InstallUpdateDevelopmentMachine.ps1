param(
    [switch]$initialInstall,
    [switch]$includeNode,
    [switch]$includeKotlin,
    [switch]$includeDocker
) 
$prevforeground = (get-host).ui.rawui.ForegroundColor
$foreground="red"
$background="yellow"

######################################################
# Install apps using Chocolatey
######################################################
if ($initialInstall) {
    Write-Host "Installing Chocolatey" -foregroundcolor $foreground -backgroundcolor $background
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    refreshenv

    Write-Host
} else {
    Write-Host "Upgrading Chocolatey" -foregroundcolor $foreground -backgroundcolor $background
    choco upgrade chocolatey -y
    Write-Host
}
Write-Host "Installing/upgrading system applications from Chocolatey" -foregroundcolor $foreground -backgroundcolor $background
choco upgrade powershell-core -y
choco upgrade dropbox -y
choco upgrade 7zip -y
choco upgrade slack -y
choco upgrade veracrypt -y
choco upgrade treesizefree -y
choco upgrade paint.net -y
choco upgrade handbrake -y
choco upgrade vlc -y
choco upgrade powertoys -y
choco upgrade FireFox -y
choco upgrade adobereader -y
choco upgrade adobereader-update -y
choco upgrade desktopok -y
choco upgrade LinkShellExtension -y
choco upgrade putty -y
choco upgrade chocolateygui -y
choco upgrade cports -y
choco upgrade gsudo -y
choco upgrade inkscape -y
Write-Host

Write-Host "Installing/upgrading system applications with winget" -foregroundcolor $foreground -backgroundcolor $background
winget install Microsoft.PowerShell
winget install JanDeDobbeleer.OhMyPosh # restart shell to reload PATH
winget install Microsoft.WindowsTerminal
winget install Ytmdesktop.Ytmdesktop

Write-Host "Installing Powershell Modules"
powershellget\install-module -Name Terminal-Icons -Repository PSGallery # need by powershell $PROFILE
powershellget\install-module z -AllowClobber # need by powershell $PROFILE

Write-Host "Installing/upgrading development tools from Chocolatey" -foregroundcolor $foreground -backgroundcolor $background
choco upgrade nuget.commandline -y
choco upgrade sysinternals -y
choco upgrade git -y
choco upgrade gitextensions -y
choco upgrade gh -y
choco upgrade poshgit -y
choco upgrade beyondcompare -y
choco upgrade sublimetext4 -y
choco upgrade postman -y
choco upgrade curl -y
choco upgrade fiddler -y
choco upgrade firacode-ttf -y
choco upgrade cascadia-code-nerd-font -y
choco upgrade roundhouse -y

Write-Host "Installing/upgrading node.js" -foregroundcolor $foreground -backgroundcolor $background
if ($includeNode)
{
    #choco upgrade nodejs  -y
    choco upgrade nodejs-lts -y
}

Write-Host "Installing/upgrading Kotlin/Gradle/OpenJDK" -foregroundcolor $foreground -backgroundcolor $background
if ($includeKotlin)
{
    choco upgrade kotlinc -y
    choco upgrade gradle -y
    choco upgrade openjdk14 -y
}

Write-Host "Installing/upgrading Docker Desktop" -foregroundcolor $foreground -backgroundcolor $background
if ($includeDocker)
{
    choco upgrade docker-desktop -y
}

Write-Host "Installing/upgrading vscode" -foregroundcolor $foreground -backgroundcolor $background
choco upgrade VisualStudioCode -y

Write-Host

Write-Host "All done!" -foregroundcolor $foreground -backgroundcolor $background

# resetting foreground color
Write-Host -foregroundcolor $prevforeground
#Set-PSReadlineOption -TokenKind Parameter -ForegroundColor $prevforeground
