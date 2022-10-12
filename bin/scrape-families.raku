#!/usr/bin/env perl6

use LWP::Simple;

my $page = LWP::Simple.get("https://it.wikipedia.org/wiki/Patriziato_(Venezia)");

my @families = $page ~~ m:g/ "<li>" (.+?) "</li>"/;

my @family-names;

for @families -> $raw {
    given $raw[0] {
        when /^$<family> = (\w+)\s*\(/ {  @family-names.push: ~$<family> }
    }
}

say @family-names;
