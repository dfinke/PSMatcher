$PSVersion = $PSVersionTable.PSVersion.Major

switch ($PSVersion) {
    5 {$target = "classic"}
    6 {$target = "dotnetcore"}
}

$null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\$target\NMatcher.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\$target\Newtonsoft.Json.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\$target\Sprache.dll")
function Test-Json {
    param(
        $actual,
        $test
    )

    $m = New-Object NMatcher.Matcher
    $m.MatchJson($actual, $test) #.Successful
}