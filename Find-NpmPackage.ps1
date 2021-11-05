# Kudos to marenpg@GitHub for original implementation!
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string] $PackageName,

    [ValidateScript({
        if( -Not ($_ | Test-Path -PathType Container) ){
            throw "Folder does not exist or is not a directory"
        }
        return $true
    })]    
    [System.IO.FileInfo]$Path = (Get-Location).Path
)



Write-Output "Looking for package '${PackageName}' in path '$Path'"
Get-ChildItem -Path $Path -Filter package-lock.json -Recurse -File | ForEach-Object { 
    Select-String -Path $_.FullName -pattern "`"${PackageName}`":" -Context 0,1 }

Write-Output "Looking globally"
npm ls -g $PackageName