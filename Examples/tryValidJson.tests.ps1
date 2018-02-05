describe 'Test JSON' {
    It 'Should match first id' {
        '{"Id":1,"name":"jane"}' | Should MatchJsonTemplate '{"Id":1,"name":"john"}'
    }

    It 'Should match second Id' {
        '{"Id":2,"name":"john"}' | Should MatchJsonTemplate '{"Id":2,"name":"john"}'
    }
}