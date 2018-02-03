cls

Import-Module .\PSMatcher.psm1

function New-MatchExpression {
    param(
        [Parameter(Mandatory)]
        $Value,
        [Parameter(Mandatory)]
        $Expression
    )

    $m=New-Object NMatcher.Matcher
    $m.MatchExpression($Value, $Expression)
}

function Test-MatchExpression {
    param(
        $Expression,
        [Parameter(ValueFromPipeline)]
        $Value        
    )

    Process {
        New-MatchExpression $Value $Expression |
            Add-Member -PassThru -MemberType NoteProperty -Name "Value" -Value $Value |
            Add-Member -PassThru -MemberType NoteProperty -Name "Expression" -Value $Expression
    }
}

$list = echo a 1.2 "2018-01-01 11:00:12" "2018-02-29 11:00:12"

$list | Test-MatchExpression "@string@"
$list | Test-MatchExpression "@string@.IsDateTime()"
$list | Test-MatchExpression "@double@"