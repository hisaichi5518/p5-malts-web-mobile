package Malts::Web::MobileAgent;
use 5.008_001;
use strict;
use warnings;
use HTTP::MobileAgent;
use Exporter 'import';

our $VERSION = '0.01';
our @EXPORT = qw(mobile_agent);

sub mobile_agent {
    my $c = shift;
    $c->{'Malts::Web::MobileAgent'} ||= HTTP::MobileAgent->new($c->request->env);
}

1;
__END__

=head1 NAME

Malts::Web::MobileAgent - Perl extention to do something

=head1 SYNOPSIS

    use Malts::Web::MobileAgent;
    sub startup {
        my $c = shift;
        if ($c->mobile_agent->is_docomo) {
            ...
        }
    }

=head1 DESCRIPTION

# TODO

=head1 METHOD

=head2 C<< $c->mobile_agent -> Object >>

    $c->mobile_agent;

L<HTTP::MobileAgent> のオブジェクトを返します。

=head1 AUTHOR

hisaichi5518 E<lt>info[at]moe-project.comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, hisaichi5518. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
