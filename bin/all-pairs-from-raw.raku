#!/usr/bin/env raku

use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my @raw-pairs;

for @dogi -> ( $him, $her) {
    my $surname-him=  doges-surname-from-raw($him);
    my $surname-her = dogaresse-surname-from-raw($her);
    @raw-pairs.push( [$surname-him, $surname-her]);
}

csv( out => "resources/all-pairs.csv", in => @raw-pairs);
