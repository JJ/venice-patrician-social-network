use Text::CSV;

unit module Data::Venice::Dogi;

my @aoa = %?RESOURCES<Venice-marriage-dogi.csv>.slurp.split("\n");
our @dogi is export = csv(in => @aoa);
our @married-dogi is export = @dogi.grep( *[1] );
