function PesterMatchJsonTemplate($ActualValue, $ExpectedValue) {

    $succeeded = Test-JSON $ActualValue $ExpectedValue

    $failureMessage = $succeeded.ErrorMessage

    return New-Object psobject -Property @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

Add-AssertionOperator -Name               MatchJsonTemplate `
                      -Test               $function:PesterMatchJsonTemplate