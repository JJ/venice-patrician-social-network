unit module Data::Venice::PatricianNetwork;

my %canonical = ( "Cornaro" => "Corner",
                  "Loredano" => "Loredan",
                  "Pisano" => "Pisani",
                  "Mastropiero" => "Malipiero",
                  "Gradenico" => "Gradenigo",
                  "Michele" => "Michiel",
                  "Giustiniani" => "Giustinian" );

sub canonicalize( $surname ) is export {
    return %canonical{$surname} ?? %canonical{$surname} !! $surname;
}

sub doges-surname-from-raw( $wiki-column ) is export {
    $wiki-column ~~ / $<surname-him> = [ \w+ ] \s+ "(" /;
    return canonicalize(~$<surname-him>);
}

sub dogaresse-surname-from-raw( $wiki-column ) is export {
    $wiki-column ~~ / ":" \s+ \w+ \s* $<surname-her> = [\w*]/;
    if $<surname-her> {
        return canonicalize(~$<surname-her>)
    } else {
        return ""
    };
}
