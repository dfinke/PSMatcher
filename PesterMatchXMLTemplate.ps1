function PesterMatchXMLTemplate($ActualValue, $ExpectedValue) {

    $succeeded = Test-XML $ActualValue $ExpectedValue

    $failureMessage = $succeeded.ErrorMessage

    return New-Object psobject -Property @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

Add-AssertionOperator -Name               MatchXMLTemplate `
                      -Test               $function:PesterMatchXMLTemplate