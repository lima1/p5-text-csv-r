#############################################################################
#   $Author: markus $
#     $Date: 2010-08-06 01:43:38 +0200 (Fri, 06 Aug 2010) $
# $Revision: 2108 $
#############################################################################

package Text::CSV::R::Matrix;

require 5.005;

use strict;
use warnings;

use Tie::Array;

our @ISA = 'Tie::Array';

our $VERSION = '0.01';

sub TIEARRAY {
    my ($self) = @_;
    return bless { ARRAY => [], rownames => [], colnames => [], }, $self;
}

sub FETCH {
    my ( $self, $index ) = @_;
    return $self->{ARRAY}->[$index];
}

sub STORE {
    my ( $self, $index, $value ) = @_;
    $self->{ARRAY}->[$index] = $value;
    return;
}

sub FETCHSIZE {
    my $self = shift;
    return scalar @{ $self->{ARRAY} };
}

sub STORESIZE {
    my ( $self, $value ) = @_;
    $#{ $self->{ARRAY} }    = $value - 1;
    $#{ $self->{rownames} } = $value - 1;
    return;
}

sub EXTEND {
    my ( $self, $count ) = @_;
    $self->STORESIZE($count);
    return;
}

sub DELETE {
    my ( $self, $index ) = @_;
    return $self->STORE( $index, q{} );
}

sub SPLICE {
    my $ob  = shift;
    my $sz  = $ob->FETCHSIZE;
    my $off = @_ ? shift : 0;
    if ($off < 0) {
        $off += $sz
    }
    my $len = @_ ? shift : $sz - $off;

    # if LIST provided, empty new rownames
    my @rn = map {q{}} @_;
    splice @{ $ob->{rownames} }, $off, $len, @rn;
    return splice @{ $ob->{ARRAY} }, $off, $len, @_;
}

1;
__END__

=head1 NAME

Text::CSV::R::Matrix - Tied array with column and row names.

=head1 DESCRIPTION

This is the return object of the Text::CSV::R read_* functions. 
It's just a (two-dimensional) array with column and row names attached.

=head1 SEE ALSO

L<Text::CSV>, L<Text::CSV::R>

=head1 AUTHOR

M. Riester, E<lt>limaone@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by M. Riester.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
