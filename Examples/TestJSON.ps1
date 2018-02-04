Import-Module -Name "$PSScriptRoot\..\PSMatcher.psd1" -Force

$actual = @"
{
    "id" : "5a645a20-5225-431b-8c62-031b87f58b73",
    "subnode" : {
        "city" : "NY",
        "zipCode" : "80-000",
        "meta" : {
            "name" : "foobar",
            "shipping": 99.99,
            "enabled" : false,
            "_link" : "http://example.com?page=2",
            "_something" : null,
            "_arr" : [1, 2, 3],
            "_date" : "2018-01-01"
        }
    }
}
"@

$expected = @"
{
    "id" : "@guid@",
    "subnode" : {
        "city" : "NY",
        "zipCode" : "@string@",
        "meta" : {
            "name" : "@string@.Contains('bar')",
            "shipping": "@double@",
            "enabled" : "@bool@",
            "_link" : "@any@",
            "_something" : "@null@",
            "_arr" : [1, 2, 3],
            "_date" : "@string@.IsDateTime()"
        }
    }
}
"@

# True Result
Test-Json -Value $actual -Reference $expected

# False Result
Test-Json -Value $actual -Reference '{}'