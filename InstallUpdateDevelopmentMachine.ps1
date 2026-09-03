param(
    [switch]$initialInstall,
    [switch]$includeNode,
    [switch]$includeKotlin,
    [switch]$includeDocker
) 
$prevforeground = (get-host).ui.rawui.ForegroundColor
$foreground="red"
$background="yellow"


function Install-OrUpdate-Winget {
    param (
        [string]$PackageId
    )

    $installed = winget list --id $PackageId --exact 2>&1
    if ($installed -match $PackageId) {
        Write-Host "Updating $PackageId..."
        winget upgrade --id $PackageId --exact --silent --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host "Installing $PackageId..."
        winget install --id $PackageId --exact --silent --accept-package-agreements --accept-source-agreements
    }
}

######################################################
# Install apps using Chocolatey and Winget
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
Write-Host "Installing/upgrading system applications with Chocolatey and winget" -foregroundcolor $foreground -backgroundcolor $background
Install-OrUpdate-Winget Microsoft.PowerShell
Install-OrUpdate-Winget JanDeDobbeleer.OhMyPosh # restart shell to reload PATH
Install-OrUpdate-Winget Microsoft.WindowsTerminal
Install-OrUpdate-Winget Ytmdesktop.Ytmdesktop
choco upgrade dropbox -y
choco upgrade 7zip -y
choco upgrade slack -y
choco upgrade veracrypt -y
choco upgrade treesizefree -y
choco upgrade paint.net -y
choco upgrade handbrake -y
choco upgrade vlc -y
choco upgrade MKVtoolnix -y
choco upgrade powertoys -y
choco upgrade vivaldi -y
choco upgrade adobereader -y
choco upgrade adobereader-update -y
choco upgrade desktopok -y
choco upgrade LinkShellExtension -y
choco upgrade putty -y
choco upgrade chocolateygui -y
choco upgrade cports -y
choco upgrade gsudo -y
choco upgrade inkscape -y
choco upgrade openssl -y
Write-Host

Write-Host "Installing Powershell Modules" -foregroundcolor $foreground -backgroundcolor $background
powershellget\install-module -Name Terminal-Icons -AllowClobber -Repository PSGallery # need by powershell $PROFILE
powershellget\install-module z -AllowClobber # need by powershell $PROFILE
Write-Host

Write-Host "Installing/upgrading development tools with Chocolatey and winget" -foregroundcolor $foreground -backgroundcolor $background
choco upgrade nuget.commandline -y
choco upgrade sysinternals -y
choco upgrade git -y
choco upgrade git-sizer -y
choco install gitextensions --ignore-dependencies -y
winget upgrade GitHub.cli
choco upgrade poshgit -y
#choco upgrade beyondcompare -y
choco upgrade sublimetext4 -y
choco upgrade postman -y
choco upgrade curl -y
choco upgrade fiddler -y
choco upgrade firacode-ttf -y
choco upgrade cascadia-code-nerd-font -y
choco upgrade roundhouse -y
choco upgrade kubernetes-cli -y
choco upgrade k9s -y
choco upgrade azure-cli -y
Install-OrUpdate-Winget GitHub.Copilot
Install-OrUpdate-Winget Anthropic.ClaudeCode
Install-OrUpdate-Winget Microsoft.WinDbg

Write-Host "Installing/upgrading node.js" -foregroundcolor $foreground -backgroundcolor $background
if ($includeNode)
{
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

