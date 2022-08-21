#!/usr/bin/env raku

use Text::CSV;

my %doge-data = csv(in => "resources/doge-surnames-groups.csv", :key( "Family" ));

my %positions-data = csv(in => "resources/family-positions.csv",
        :key( "Family name" ));

my %dogi-number-data = csv(in => "resources/doge-surnames.csv",
        :key( "Family" ));

my %merged-data;
for %positions-data.keys -> $family {
    %merged-data{$family} = {
        Positions => %positions-data{$family}<Positions>
    };
    if %dogi-number-data{$family} {
        %merged-data{$family}<Dogi> = %dogi-number-data{$family}<Count>;
    }

    if %doge-data{$family} {
        for ["Nuovissime","Nuove","Extinct pre-serrata","Vecchie",
             "Apostoliche","Evangeliche"] -> $type {
            %merged-data{$family}<Type> = $type if %doge-data{$family}{$type};
        }
    }
}

my @aoa;

@aoa.push: ["Family","Positions", "Type"];

for %merged-data.keys -> $family {
    @aoa.push: [
        $family,
        %merged-data{$family}<Positions>,
        %merged-data{$family}<Type> || ""
    ];
}

csv( out => "resources/family-data.csv",
        in => @aoa );
