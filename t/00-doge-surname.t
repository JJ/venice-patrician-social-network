use Test;

use Data::Venice::PatricianNetwork;
use Data::Venice::Dogi;

my @test-data-dogi= [
    [0, "Orso"],
    [33, "Contarini"],
    [63, "Corner"],
    [125, "Manin" ]
    ];

my @test-data-dogaresse= [
    [19, "Sanudo"],
    [107, "Barbarigo"],
    [115, "Corner"],
    [125, "Grimani" ]
];

subtest "Dogi names", {
    for @test-data-dogi -> ($index, $surname) {
        is(doges-surname-from-raw(@dogi[$index]), $surname,
                "Good doge $surname");
    }
}

subtest "Dogaresse names", {
    for @test-data-dogaresse -> ($index, $surname) {
        is(dogaresse-surname-from-raw(@dogi[$index]), $surname,
                "$surname for dogaressa");
    }
}

done-testing;
