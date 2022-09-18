#!/usr/bin/env raku

use Text::CSV;

use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my @parsed = [("Doge data","Dogaressa data","Start", "End", "Family doge",
               "Family dogaressa"),];


for @dogi -> ( $him, $her) {
    my @row = [ $him, $her || ""];
    my $years = $him ~~ /\(\s*(\d+)\s*"-" \s* (\d+) |
            \("c." \s+ (\d+) \) |
            \("c." \s+ (\d+) "-" (\d+) |
            \((\d+)\) |
            \("c. " (\d+)\) |
            \("c." \s+ (\d+) \s* "– c." \s+ (\d+)/;
    if ( !$years ) {
        die "Can't work with $him";
    }
    @row.append: !$years[1].defined ?? | ~$years[0] xx 2 !! | [ ~$years[0],
                                                               ~$years[1] ];
    @row.push: doges-surname-from-raw($him);
    @row.push: dogaresse-surname-from-raw($her);
    @parsed.push: @row;
}

csv( out => "resources/venice-doges.csv", in => @parsed);
