unit module Data::Venice::PatricianNetwork;

sub doges-surname-from-raw( $wiki-column ) is export {
    $wiki-column ~~ / $<surname-him> = [ \w+ ] \s+ "(" /;
    return ~$<surname-him>;
}
