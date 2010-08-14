use Test::More tests => 4;
use Test::NoWarnings;
use Test::LongString;

use Text::CSV::R qw(:all);
use File::Temp qw(tempfile);
use Data::Dumper;

my $M_ref = read_csv('t/testfiles/imdb3.dat');

my $output = q{};

my ( $FH, $filename ) = tempfile();
write_table( $M_ref, $filename, sep => q{,} );
is_string(
    slurp($filename),
    slurp('t/testfiles/Routtable.dat'),
    'same as input again'
);

( $FH, $filename ) = tempfile();
write_csv( $M_ref, $FH );
close $FH;

is_string(
    slurp($filename),
    slurp('t/testfiles/Routcsv.dat'),
    'same as input again'
);

( $FH, $filename ) = tempfile();
write_table( [ [ 1, 2 ], [ 3, 4 ] ], $filename, sep => q{,} );
is_string( slurp($filename), "1,2\n3,4\n", '2D array' );

sub slurp {
    my ($file) = @_;
    open my $IN, '<', $file;
    undef $/;
    return <$IN>;
}

