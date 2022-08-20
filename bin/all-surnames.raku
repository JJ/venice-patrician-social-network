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

@arrayed.push: ["Family name", "Dogo","Dogaressa"];

for %surnames.keys -> $name {
    my %positions = %surnames{$name};
    @arrayed.push: [$name,
                    %positions<dogo> ?? 1 !! 0,
                    %positions<dogaressa> ?? 1!! 0];
}
say @arrayed;
csv( out => "resources/family-positions.csv", in => @arrayed );

