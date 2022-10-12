#!/usr/bin/env perl6

use LWP::Simple;

my $page = LWP::Simple.get("https://it.wikipedia.org/wiki/Patriziato_(Venezia)");

my @families = $page ~~ m:g/ "<li>" (.+?) "</li>"/;

my @family-names;

for @families -> $raw {
    given $raw[0] {
        when /^$<family> = (\w+) $/ {  @family-names.push: ~$<family> }
        when /^$<family> = (\w+)\s*\(/ {  @family-names.push: ~$<family> }
        when /$<family> = (\w+) "_(famiglia)"/ {
            @family-names.push: ~$<family>
        }
        when /">" $<family> = (\w+) "</a>"$/ {  @family-names.push: ~$<family> }
        when /"</a>" \s* $<family> = (\w+) $/ {
            @family-names.push: ~$<family>
        }
        default { say $_}
    }
}

say @family-names;
