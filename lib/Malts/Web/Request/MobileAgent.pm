package Malts::Web::Request::MobileAgent;
use 5.008_001;
use strict;
use warnings;
use HTTP::MobileAgent;

our $VERSION = '0.01';

sub Malts::Web::Request::mobile_agent {
    my ($req) = @_;
    $req->env->{'malts.mobile.agent'} ||= HTTP::MobileAgent->new($req->env);
}

1;
__END__

=head1 NAME

Malts::Web::Request::MobileAgent - Perl extention to do something

=head1 VERSION

This document describes Malts::Web::Request::MobileAgent version 0.01.

=head1 SYNOPSIS

    use Malts::Web::Request::MobileAgent;

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

hisaichi5518 E<lt>info[at]moe-project.comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, hisaichi5518. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
