#!/usr/bin/env raku

use Text::CSV;

use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my @parsed = [("Doge","Dogaressa",
               "Doge raw","Dogaressa raw",
               "Century", "Start", "End",
               "Family doge", "Family dogaressa"),];


for @dogi -> ( $him, $her) {
    my $his-name = $him.split(/\s+\(/)[0];
    my $her-name = $her.split(/\:\s*/)[1] // "";
    my @row = [ $his-name, $her-name, $him, $her || ""];
    my $years = $him ~~ /\(\s*(\d+)\s*"-" \s* (\d+) |
            \("c." \s+ (\d+) \) |
            \("c." \s+ (\d+) "-" (\d+) |
            \((\d+)\) |
            \("c. " (\d+)\) |
            \("c." \s+ (\d+) \s* "– c." \s+ (\d+)/;
    if ( !$years ) {
        die "Can't work with $him";
    }
    @row.append: +$years[0] div 100;
    @row.append: !$years[1].defined ?? | ~$years[0] xx 2 !! | [ ~$years[0],
                                                               ~$years[1] ];
    @row.push: doges-surname-from-raw($him);
    @row.push: dogaresse-surname-from-raw($her);
    @parsed.push: @row;
}

csv( out => "resources/venice-doges.csv", in => @parsed);
