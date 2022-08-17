#!/usr/bin/env raku

use Text::CSV;

my @dogi = csv(in => "resources/Venice-marriage-duci.csv");

# Filter those that are not paired

my @married-dogi = @dogi.grep( *[1] );

my @surname-pairs;

for @married-dogi -> ( $him, $her) {
    $him ~~ / $<surname-him> = [ \w+ ] \s+ "(" /;
    my $surname-him=  ~$<surname-him>;
    $her ~~ / ":" \s+ \w+ \s* $<surname-her> = [\w*]/;
    if (~$<surname-her>) {
        @surname-pairs.push: [$surname-him, ~$<surname-her>];
    }
}

csv( out => "resources/family-pairs.csv", in => @surname-pairs);
