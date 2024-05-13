#!/usr/bin/env raku

use Text::CSV;

my @rows = csv( in=> "data/venice_colleganza_puga_treffler_families.csv" );

for @rows[1..*] -> @row {
    say @row;
    my @families = unique(@row[1..*].grep: /\w/);
    for @families.combinations( 2 ) -> @pair {
        next unless @pair;
        @pair[1] = @pair[1] eq "Mastropetro" ?? "Malipiero" !! @pair[1];
        say @pair.map("\"" ~ * ~ "\"").join(","),",@row[0]";
    }
}
