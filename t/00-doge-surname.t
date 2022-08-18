use Test;

use Data::Venice::PatricianNetwork;
use Data::Venice::Dogi;

my @test-data= [
    [0, "Ipato"],
    [33, "Contarini"],
    [125, "Manin" ]
    ];

for @test-data -> ($index, $surname ) {
    is(doges-surname-from-raw(@dogi[$index]), $surname,
            "Good doge $surname");
}

done-testing;
