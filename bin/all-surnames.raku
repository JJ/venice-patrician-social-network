#!/usr/bin/env raku

use Text::CSV;
use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my %surnames;

for @dogi -> ( $him, $her) {
    %surnames{ doges-surname-from-raw($him) }++;
}

my @aoa = do [$_.key, $_.value] for %surnames.sort: -*.value;
csv( out => "resources/doge-surnames.csv", in => @aoa );
