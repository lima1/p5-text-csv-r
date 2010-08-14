#!perl -T
use Test::More tests => 3;
use Test::NoWarnings;
use charnames ":full";

use Text::CSV::R qw(:all);
use Data::Dumper;

my $M_ref = read_csv('t/testfiles/unicode.dat', header=>0, encoding => 'utf8');

is($M_ref->[1][1], "U2 should \N{SKULL AND CROSSBONES}", 
    'read unicode file correctly');

open my $IN, '<:encoding(utf8)', 't/testfiles/unicode.dat';
$M_ref = read_csv($IN, header=>0, encoding => 'utf8');
close $IN;

is($M_ref->[1][1], "U2 should \N{SKULL AND CROSSBONES}", 
    'read unicode file correctly');

