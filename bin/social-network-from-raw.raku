#!/usr/bin/env raku

use Text::CSV;

use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my @surname-pairs;

for @married-dogi -> ( $him, $her) {
    my $surname-him=  doges-surname-from-raw($him);
    my $surname-her = dogaresse-surname-from-raw($her);
    say "$surname-him $surname-her";
    if ( $surname-her && $surname-her.comb()[0] ne "d"
            && $surname-her ne "Maria" | "Anna"
            && $surname-her ne $surname-him ) {
        @surname-pairs.push: [$surname-him, canonicalize($surname-her) ];
    }
}

csv( out => "resources/family-pairs.csv", in => @surname-pairs);
