use Test;

use Data::Venice::Dogi;

is(@dogi.elems, 126, "Imported all dogi");
is(@married-dogi.elems, 76, "Extracted married dogi");
done-testing;
