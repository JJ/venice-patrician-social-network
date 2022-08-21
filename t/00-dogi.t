use Test;

use Data::Venice::Dogi;

is(@dogi.elems, 129, "Imported all dogi");
is(@married-dogi.elems, 80, "Extracted married dogi");
done-testing;
