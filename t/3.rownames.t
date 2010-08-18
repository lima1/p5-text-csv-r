#!perl -T
use Test::More tests => 11;
use Test::NoWarnings;

use Text::CSV::R qw(rownames read_csv);

my $M_ref = read_csv('t/testfiles/imdb.dat');

# test row.names option
$M_ref = read_csv('t/testfiles/imdb.dat',  'row_names' =>2 );

eval { rownames($M_ref, [ 1, 2]) };
like( $@, qr/^Invalid rownames length/, 'rownames too short' );

eval { rownames($M_ref, ( 1, 2, 3)) };
like( $@, qr/^Invalid rownames length/, 'rownames not array' );

eval { rownames($M_ref, { 1=>2, 3=>4}) };
like( $@, qr/^Invalid rownames length/, 'rownames hash ref' );

# test splicing
splice @{$M_ref}, 1, 1;
cmp_ok($M_ref->[0][2], '==', 1994, 'data correct');
cmp_ok($M_ref->[1][2], '==', 1974 ,'data correct');

is_deeply( rownames($M_ref), [ "The Shawshank Redemption", 
    "The Godfather: Part II" ], 'rownames');

$M_ref = read_csv('t/testfiles/imdb.dat',  'row_names' =>2 );

splice @{$M_ref}, 1, 1, ['1.5' ,9.1,1994,408145 ];
cmp_ok($M_ref->[0][2], '==', 1994, 'data correct');
cmp_ok($M_ref->[1][2], '==', 1994 ,'data correct');
cmp_ok($M_ref->[2][2], '==', 1974 ,'data correct');

is_deeply( rownames($M_ref), [ "The Shawshank Redemption", "",
    "The Godfather: Part II" ], 'rownames');

