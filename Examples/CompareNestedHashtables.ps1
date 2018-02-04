Import-Module ..\PSMatcher.psd1 -Force

$h = [ordered]@{}

$h.id = (New-Guid).Guid

$h.person = @{
    name="John"
    address= @{
        City="NY"
        Zip=10001
    }
}

$h.array = echo 1 2 3


$tests = $(
    '{"id": "@guid@","person":{"name":"John","address":{"City":"NY","Zip":"10001"}}}'
    '{"id": "@guid@","person":{"name":"John","address":{"City":"NY","Zip":10001}}}'
    '{"id": "@guid@","person":{"name":"John","address":{"City":"@string@","Zip":"@int@"}}}'
    
    '{"id":"@guid@","person":{"name":"John","address":{"City":"NY","Zip":10001}},"array":[1]}'

    '{"id":"@guid@","person":{"name":"John","address":{"City":"NY","Zip":10001}},"array":[1,2,3]}'
)

$actual = ($h|ConvertTo-Json)

foreach ($test in $tests) { $actual | Test-Json -Test $test }