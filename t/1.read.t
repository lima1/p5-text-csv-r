use Test::More tests => 19;
use Test::NoWarnings;

use Text::CSV::R qw(:all);
use Data::Dumper;

my $M_ref = read_csv('t/testfiles/imdb.dat');

is_deeply( colnames($M_ref), [ qw( Rank Rating Title Year Votes) ],
    'colnames');

cmp_ok(scalar(@$M_ref), '==', 3, 'number rows correct');
# test skip option
$M_ref = read_csv('t/testfiles/imdb.dat', skip=>1 );
is_deeply( colnames($M_ref), [ '1. ' ,9.1,'The Shawshank Redemption',1994,403610],
    'skip');

cmp_ok(scalar(@$M_ref), '==', 2, 'number rows correct');

# test blank_lines_skip option
$M_ref = read_csv('t/testfiles/imdb.dat',  skip=>1,blank_lines_skip => 0 );
cmp_ok(scalar(@$M_ref), '==', 3, 'number rows correct');

# test allow_whitespace/strip.white option
$M_ref = read_csv('t/testfiles/imdb.dat',  allow_whitespace=>1 );
is($M_ref->[0][0], '1.', 'allow_whitespace');
$M_ref = read_csv('t/testfiles/imdb.dat',  strip_white=>0 );
is($M_ref->[0][0], '1. ', 'allow_whitespace');
$M_ref = read_csv('t/testfiles/imdb.dat',  strip_white=>1 );
is($M_ref->[0][0], '1.', 'allow_whitespace');

# test nrow option
$M_ref = read_csv('t/testfiles/imdb.dat',  nrow=>2 );
cmp_ok(scalar(@$M_ref), '==', 2, 'number rows correct');
$M_ref = read_csv('t/testfiles/imdb.dat',  nrow=>2, header=>0 );
cmp_ok(scalar(@$M_ref), '==', 2, 'number rows correct');
is_deeply( colnames($M_ref), [ qw( V1 V2 V3 V4 V5 ) ],
    'colnames');

# test row.names option
$M_ref = read_csv('t/testfiles/imdb.dat',  'row_names' =>2 );
cmp_ok($M_ref->[0][2], '==', 1994, 'data correct');
cmp_ok($M_ref->[0][1], '==', 9.1 , 'data correct');
is_deeply( rownames($M_ref), [ "The Shawshank Redemption", "The Godfather",
    "The Godfather: Part II" ], 'colnames');
$M_ref = read_csv('t/testfiles/imdb.dat' );
is_deeply( rownames($M_ref), [ qw(1 2 3) ], 'colnames');

$M_ref = read_csv('t/testfiles/imdb4.dat', verbatim=>1 );
#
# test read_csv2

$M_ref = read_csv2('t/testfiles/imdb2.dat', dec => "," );
cmp_ok($M_ref->[0][1], '==', 9.1 , 'data correct');

# test auto header and row_names
$M_ref = read_table('t/testfiles/imdb3.dat', sep => q{,} );

is_deeply( rownames($M_ref), [ '1. ', '2. ',  '3. ' ], 'rownames');
is_deeply( colnames($M_ref), [ qw( Rating Title Year Votes) ],
    'colnames');

