unit module Data::Venice::PatricianNetwork;

my %canonical = ( "Cornaro" => "Corner" );

sub canonicalize( $surname ) is export {
    return %canonical{$surname} ?? %canonical{$surname} !! $surname;
}

sub doges-surname-from-raw( $wiki-column ) is export {
    $wiki-column ~~ / $<surname-him> = [ \w+ ] \s+ "(" /;
    return canonicalize(~$<surname-him>);
}
