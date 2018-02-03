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
            Select-Object `
                Successful, `
                @{Name="Value";Exp={$Value}}, `
                @{Name="Expression";Exp={$Expression}}, `
                ErrorMessage
    }
}

$list = echo a 1.2 "2018-01-01 11:00:12" "2018-02-29 11:00:12"
$matchExpressoions = echo @string@ '@string@.IsDateTime()' @double@

$matchExpressoions |
    ForEach {
        $list | Test-MatchExpression $_
    }
return 
$list = echo a 1.2 "2018-01-01 11:00:12" "2018-02-29 11:00:12"

$list | Test-MatchExpression "@string@"
$list | Test-MatchExpression "@string@.IsDateTime()"
$list | Test-MatchExpression "@double@"