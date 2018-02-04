Import-Module ..\PSMatcher.psd1 -Force

$h = [ordered]@{}
$h.a = 1
$h.b = echo 1 2

$tests = $(
    '{"a":1 }'
    '{"a":2 }'
    '{"a":1, "b": [1,2]}'
)

$actual = ($h|ConvertTo-Json)

foreach ($test in $tests) {
    $actual | Test-Json -Test $test    
}