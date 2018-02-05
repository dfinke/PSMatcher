$ModuleName = 'PSMatcher'
$ModulePath = 'C:\Program Files\WindowsPowerShell\Modules'

$TargetPath = Join-Path -Path $ModulePath -ChildPath $ModuleName

Remove-Item $TargetPath -Recurse -Force -ErrorAction Ignore

if (-not (Test-Path $TargetPath)) {
    New-Item -Path $TargetPath -ItemType Directory -EA Stop | Out-Null
    #Write-Verbose "$ModuleName created module folder '$TargetPath'"
}

Copy-Item .\PSMatcher.psd1 $TargetPath
Copy-Item .\PSMatcher.psm1 $TargetPath
Copy-Item .\PesterMatchJsonTemplate.ps1 $TargetPath
Copy-Item .\README.md $TargetPath
Copy-Item .\classic "$TargetPath\classic" -Recurse
Copy-Item .\dotnetcore "$TargetPath\dotnetcore" -Recurse
Copy-Item .\Examples "$TargetPath\Examples" -Recurse