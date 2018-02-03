Import-Module .\PSMatcher.psm1 -Force

$h = @{}

$h.id = (New-Guid).Guid
$h.arr = @()
$h.arr += 1
$h.arr += 2
$h.arr += 3

$test = @{"id" = "@guid@"; "arr" = echo 1 2 }

Test-Json ($h|ConvertTo-Json) ($test|ConvertTo-Json)