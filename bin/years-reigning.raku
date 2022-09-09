#!/usr/bin/env raku

use Text::CSV;

use Data::Venice::Dogi;
use Data::Venice::PatricianNetwork;

my @surname-pairs;

say "Doge, Reigning, Century";
for @married-dogi -> ( $him, $foo) {
    my $years = $him ~~ /\(\s*(\d+)\s*"-" \s* (\d+)/;
    say "$him, ", $years[1] - $years[0], ", ",
            $years[0] > 999
                ?? substr($years[0],0,2)
                !! substr($years[0],0,1);
}


