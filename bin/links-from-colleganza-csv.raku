#!/usr/bin/env perl6

use Text::CSV;

my @rows = csv( in=> "data/venice_colleganza_puga_treffler_families.csv" );

for @rows[1..*] -> @row {
    my @families = unique(@row[1..*].grep: /\w/);
    for @families.combinations( 2 ) -> @pair {
        next unless @pair;
        say @pair.map("\"" ~* ~ "\"").join(", ")
    }
}