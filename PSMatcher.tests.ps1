describe 'Test JSON' {
    Import-Module $PSScriptRoot\PSMatcher.psd1 -Force

    It 'Should match id and name' {
        '{"Id":1,"name":"jane"}' | Should MatchJsonTemplate '{"Id":1,"name":"jane"}'
    }

    It 'Should match guid' {
        '{"Id":"dd4c2ca4-5c8f-4ba3-8937-a7b101f52a99","name":"john"}' |
            Should MatchJsonTemplate '{"Id":"@guid@","name":"john"}'
    }

    It 'Should match double' {
        '{"Id":"dd4c2ca4-5c8f-4ba3-8937-a7b101f52a99","name":"john","price":10.12}' |
            Should MatchJsonTemplate '{"Id":"@guid@","name":"john","price":"@double@"}'
    }
}

describe 'Test XML' {
    Import-Module $PSScriptRoot\PSMatcher.psd1 -Force

    It 'Should match XML' {
        "<users><user>Foobar</user></users>" |
            Should MatchXMLTemplate "<users><user>Foobar</user></users>"
    }

    It 'Should fail XML match' {
        $actual = "<users><user>Foobar</user></users>"
        $expected = "<users><user>Foobar1</user></users>"

        Test-XML $actual $expected | Should Be $false
    }

    It "Matches XML With Expression" {
        $actual = "<users><user>Foobar</user></users>"
        $expected = "<users><user>@string@</user></users>"
        
        $actual | Should MatchXMLTemplate $expected
    }

    It "Matches XML With Attribute" {
        $actual = '<users><user id="1">Foobar</user></users>'
        $expected = '<users><user id="@string@">@string@.Contains("Foo")</user></users>'

        $actual | Should MatchXMLTemplate $expected
    }

    It "Matches more complex xml" {
        $actual = @'
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2001/12/soap-envelope" soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
    <soap:Body xmlns:m="http://www.example.org/stock">
        <m:GetStockPrice>
            <m:StockName>IBM</m:StockName>
            <m:StockValue>Any Value</m:StockValue>
            </m:GetStockPrice>
    </soap:Body>
</soap:Envelope>
'@

        $expected = @'
<?xml version="1.0"?>
<soap:Envelope xmlns:soap = "http://www.w3.org/2001/12/soap-envelope" soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
    <soap:Body xmlns:m="http://www.example.org/stock">
        <m:GetStockPrice>
            <m:StockName>IBM</m:StockName>
            <m:StockValue>Any Value</m:StockValue>
            </m:GetStockPrice>
    </soap:Body>
</soap:Envelope>
'@

        $actual | Should MatchXMLTemplate $expected
    }

    It "Matches more complex xml with expressions" {
        $actual = @'
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2001/12/soap-envelope" soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
    <soap:Body xmlns:m="http://www.example.org/stock">
        <m:GetStockPrice>
            <m:StockName>IBM</m:StockName>
            <m:StockValue>Any Value</m:StockValue>
            </m:GetStockPrice>
    </soap:Body>
</soap:Envelope>
'@

            $expected = @'
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="@string@" soap:encodingStyle="@string@">
    <soap:Body xmlns:m="http://www.example.org/stock">
        <m:GetStockPrice>
            <m:StockName>@string@</m:StockName>
            <m:StockValue>@string@.Contains('Any')</m:StockValue>
            </m:GetStockPrice>
    </soap:Body>
</soap:Envelope>
'@

        $actual | Should MatchXMLTemplate $expected
    }

    It "Matches with optional" {
        $actual = @'
<note>
    <to>Tove</to>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
</note>
'@

        $expected = @'
<note>
<to>Tove</to>
    <from>@string?@</from>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
</note>
'@

        $actual | Should MatchXMLTemplate $expected
    }
}