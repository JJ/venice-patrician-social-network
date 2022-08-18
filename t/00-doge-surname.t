use Test;

use Data::Venice::PatricianNetwork;

my @test-data= [
    ["Orso Ipato (c. 727 – c. 737)", "Ipato"],
    ["Domenico I Contarini (1041-1071)", "Contarini"],
    ["Ludovico Manin (1789-1797)", "Manin" ]
    ];

for @test-data -> ($raw-string, $surname ) {
    is(doges-surname-from-raw($raw-string), $surname,
            "Good doge $surname");
}
done-testing;
