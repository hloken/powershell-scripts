param(
    [switch]$Recurse,
    [ValidateScript({
        if( -Not ($_ | Test-Path -PathType Container) ){
            throw "Folder does not exist or is not a directory"
        }
        return $true
    })]
    [System.IO.FileInfo]$Path
)

function TurnOffCodeAnalysis {

    param (
        $ProjectFilePath
    )

    Write-Output "Turning off Code-Analysis for $ProjectFilePath"

    $xml = New-Object XML
    $xml.Load($ProjectFilePath)
    Write-Output "Loaded xml-file $ProjectFilePath"
    $ns = new-object Xml.XmlNamespaceManager $xml.NameTable
    $ns.AddNamespace("msb", "http://schemas.microsoft.com/developer/msbuild/2003")

    $elements = $xml.SelectNodes("//msb:RunCodeAnalysis", $ns)
    foreach($element in $elements)
    {
        $element.InnerText = "false"
    }

    $xml.Save($ProjectFilePath)
    Write-Output "Saved changes to $ProjectFilePath"
}

if($Recurse) {
    $filePaths = Get-ChildItem -Path $Path -Filter *.csproj -Recurse -File
} else {
    $filePaths = Get-ChildItem -Path $Path -Filter *.csproj -File
}

$filePaths | ForEach-Object {
    TurnOffCodeAnalysis $_.FullName
}

# example usage: .\TurnOff-CodeAnalys.ps1 -Recurse -Path C:\Projects\GitHub\TheSuperProject\source\

# Performance
# Full rebuild with code-analysis on: 14:01:16 - 14:05:04 + (2nd build because 1st does not complete successfully) 14:05:38 - 14:05:58 = 3m48s + 20s = 4m08s
# Full rebuild without code-analsys:  14:31:10 - 14:33:27    = 2m 17s

# Related Tips:
# reg-exp to remove csproj-files from Git Extensions Commit-dialog: ^((?!csproj).)*$