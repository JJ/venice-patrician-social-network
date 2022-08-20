#!/usr/bin/env raku

use Text::CSV;
use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my %surnames;

for @dogi -> ( $him, $her) {
    %surnames{ doges-surname-from-raw($him) }<dogo> = True;
    %surnames{ dogaresse-surname-from-raw($her) }<dogaressa> = True if dogaresse-surname-from-raw($her);
}

my @arrayed;

@arrayed.push: ["Family name", "Positions"];

for %surnames.keys -> $name {
    my %positions = %surnames{$name};
    my $position;
    if %positions<dogo> && %positions<dogaressa> {
        $position = "Both";
    } elsif %positions<dogo> {
        $position = "Doge"
    } else {
        $position = "Dogaressa"
    }
    @arrayed.push: [$name, $position ];
}
csv( out => "resources/family-positions.csv", in => @arrayed );

