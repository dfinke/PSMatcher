Import-Module ..\PSMatcher.psd1 -Force

$records = @"
id,region,product,cost
5d84babe-874e-4418-8cbb-f2c6ce74de92,North,Apple,1.29
"@ | ConvertFrom-Csv

$actual = $records | Select-Object id, region, product, @{n = 'cost'; e = {[double]$_.cost}} | ConvertTo-Json

$tests = $(
    '{"id":"@guid@","region":"North","product":"Apple","cost":"@int@"}'
    '{"id":"@guid@","region":"North","product":"Apple","cost":"@double@"}'

    '{"id":"@guid@","region":"North","product":"Apple","cost":"@double@.GreaterThan(1.00).LowerThan(1.29)"}'

    '{"id":"@guid@","region":"North","product":"Apple","cost":"@double@.GreaterThan(1.00).LowerThan(1.30)"}'
)

$tests | ForEach-Object { $actual | Test-Json -Test $_ }