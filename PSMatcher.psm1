# $PSVersion = $PSVersionTable.PSVersion.Major

# switch ($PSVersion) {
#     5 {$target = "classic"}
#     6 {$target = "dotnetcore"}
# }

# $null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\$target\NMatcher.dll")
# $null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\$target\Newtonsoft.Json.dll")
# $null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\$target\Sprache.dll")

$null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib\NMatcher.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib\Newtonsoft.Json.dll")
$null = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib\Sprache.dll")

function New-BoolCompatibleResult {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [NMatcher.Matching.Result]
        $Result
    )

    Process {
        $Result.Successful |
            Add-Member -MemberType ScriptProperty -Name Successful -Value { $this.Result.Successful } -Force -PassThru |
            Add-Member -MemberType ScriptProperty -Name ErrorMessage -Value { $this.Result.ErrorMessage } -Force -PassThru |
            Add-Member -NotePropertyName Result -NotePropertyValue $result -TypeName NMatcher.Matching.Result -Force -PassThru
    }
}

function Test-Json {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [Alias('Actual')]
        [ValidateNotNullOrEmpty()]
        $Value ,

        [Parameter(
            Mandatory
        )]
        [Alias('Test')]
        [ValidateNotNullOrEmpty()]
        $Reference
    )

    Begin {
        $matcher = New-Object -TypeName NMatcher.Matcher
    }

    Process {
        $matcher.MatchJson($Value, $Reference) | New-BoolCompatibleResult
    }
}

function Test-XML {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [Alias('Actual')]
        [ValidateNotNullOrEmpty()]
        $Value ,

        [Parameter(
            Mandatory
        )]
        [Alias('Test')]
        [ValidateNotNullOrEmpty()]
        $Reference
    )

    Begin {
        $matcher = New-Object -TypeName NMatcher.Matcher
    }

    Process {
        $matcher.MatchXML($Value, $Reference) | New-BoolCompatibleResult
    }
}

. $PSScriptRoot\PesterMatchJsonTemplate.ps1
. $PSScriptRoot\PesterMatchXMLTemplate.ps1

#Export-ModuleMember -Function Test-Json, Test-XML, PesterMatchJsonTemplate
Export-ModuleMember -Function Test-Json, Test-XML, PesterMatchJsonTemplate, PesterMatchXMLTemplate