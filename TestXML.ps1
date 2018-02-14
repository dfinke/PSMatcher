cls

ipmo .\PSMatcher.psd1 -Force

$actual = @"
<note>
    <to id="fuu" at2="bar">Tove</to>
    <heading id="h2">
        <subheader subid="s2">fooo</subheader>
        <mainheader>Reminder</mainheader>
    </heading>
    <body>Don't forget me this weekend!</body>
</note>
"@

$expected = @"
<note>
    <to id="@string@" at2="@string@">Tove</to>
    <from>@string?@</from>
    <heading id="@string@">
        <subheader subid="@string@">@string@</subheader>
        <mainheader>@string@</mainheader>
    </heading>
    <body>@string@</body>
</note>
"@

$actual   = "<data></data>"
$expected = "<data></data>"

$matcher = New-Object NMatcher.Matcher
$matcher.MatchXml($actual, $expected)