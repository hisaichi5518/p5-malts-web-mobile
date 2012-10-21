package Malts::Plugin::Web::MobileAgent;
use 5.008_001;
use strict;
use warnings;
use HTTP::MobileAgent;

our $VERSION = '0.50';

sub init {
    my ($class, $c) = @_;
    $c->add_method(mobile_agent => \&_mobile_agent);
}

sub _mobile_agent {
    my $c = shift;
    $c->{'Malts::Web::MobileAgent'} ||=
        HTTP::MobileAgent->new($c->request->env);
}

1;
__END__

=head1 NAME

Malts::Web::MobileAgent - Perl extention to do something

=head1 SYNOPSIS

    package MyApp::Web;
    use strict;
    use warnings;
    use parent qw(Malts);
    __PACKAGE__->load_plugins(qw/Web::MobileAgent/);

    sub dispatch {
        my $c = shift;
        if ($c->mobile_agent->is_docomo) {
            return $c->render(200, 'root/docomo.tx');
        }
        elsif ($c->mobile_agent->is_ezweb) {
            return $c->render(200, 'root/ezweb.tx');
        }
        elsif ($c->mobile_agent->is_softbank) {
            return $c->render(200, 'root/softbank.tx');
        }
        else {
            return $c->render(200, 'root/pc.tx');
        }
    }

=head1 DESCRIPTION

HTTP::MobileAgentのオブジェクトを返す C<$c->mobile_agent> メソッドを生やします。

=head1 METHOD

=head2 C<< $class->init >>

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
